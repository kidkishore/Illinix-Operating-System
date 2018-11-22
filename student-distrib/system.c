#include "lib.h"
#include "types.h"
#include "system.h"
#include "filesys.h"
#include "multiboot.h"
#include "x86_desc.h"
#include "paging.h"
#include "pcb.h"
#include "rtc.h"
#include "dev/terminal.h"

int curr_process = 0;
int curr_pid = 1;


asm(".global ret_from_child");


//rtc jump table
struct file_op_table rtc_jump_table = {
  &rtc_read, &rtc_write, &rtc_open, &rtc_close
  };

//directory jump table
struct file_op_table directory_jump_table = {
  &dir_read, &dir_write, &dir_open, &dir_close
  };

//file jump table
 struct file_op_table file_jump_table = {
  &file_read, &file_write, &file_open, &file_close
};

/* Function: int32_t halt (uint8_t status)
 * Inputs: uint8_t status
 * Return Value: specified value to its parent process
 * Description:  terminates process
 */
extern int32_t halt (uint8_t status){
	cli();
	int i;
	pcb_t *curr_pcb = get_pcb(); 
	pcb_t *parent_pcb = curr_pcb -> parent;

	// close files	
	for (i = 0; i < FD_ARRAY_SIZE; i++) {
		close(i); 
	}

	// clear pcb structure


	// free pid
	processes[curr_pcb->process_num] = 0;
	processes[parent_pcb->process_num] = 1;
	curr_process = parent_pcb->process_num;
	
  // tss to parent
	tss.ss0 = KERNEL_DS;
	tss.esp0 = KERNEL_BOTTOM - (curr_process) * EIGHT_KB - BYTES_IN_INT;

	// restore paging
	create_page(parent_pcb->process_num);	
	
	// restore esp ebp
  register uint32_t temp asm("ecx");
  temp = curr_pcb->parent_esp;
	asm ("movl %0, %%ebp;" :: "r"(curr_pcb->parent_ebp) :"%ebp"); 
	asm ("movl %%ecx, %%esp;" :::"%ecx", "%esp"); 
	sti();
	asm ("jmp ret_from_child;"); 
	return 0;
}

extern int32_t sys_execute(const uint8_t* _command) {
        int b;
        asm ("movl %1, %%ebx; \
              movl %%ebx, %0;"
             :"=r"(b)        /* output */
             :"r"(_command)         /* input */
             :"%ebx"         /* clobbered register */
             ); 

	execute(NULL);

	return 0;
}
/* Function: extern int32_t execute (const uint8_t* command)
 * Inputs: Pointer to Command
 * Return Value: Returns -1 on Failure
 * Description:  Enters userspace, pages memory for process, context switches, sets PCB, etc. 
 */
extern int32_t execute (const uint8_t* _command) {
   register uint8_t* arg_cmd asm("ebx");
	
	uint8_t* command = arg_cmd;
	int i;
	dentry_t dentry;

	pcb_t curr_pcb;
	pcb_t* pcb_loc;

	uint16_t k_ds = 0;
	uint16_t k_cs = 0;
	uint32_t u_ds = 0;
	uint32_t u_cs = 0;

	uint32_t eip = 0;
	uint32_t esp = 0;


	uint8_t program[FILE_NAME_SIZE];
	uint8_t args[ARGS_ARR_SIZE];
	uint8_t file_header[HEADER_SIZE];
	
	//1. Parse args
	parse_args(program, args, command);


	//2. Check file validity
	if (check_validity(program, &dentry)) {
		// printf("%s file is NOT valid", command);
		return -1;
	}


	for (i = 0; i < MAX_NUM_PROCESSES; i++) {
		if ((processes[i] == NULL)) { 
			processes[i] = (curr_pid = i + 1);
			curr_process = i;
			break;
		}


	}
	
	//3. Set up paging
	create_page(curr_process);


	//4. Load file into memory
	load_file(&dentry);


	//5. Create PCB/Open FDs
	curr_pcb = create_pcb();
	
	
	curr_pcb.parent = get_pcb();
	curr_pcb.process_num = curr_process;


	curr_pcb.parent_esp0 = tss.esp0; // ??
	curr_pcb.parent_ss0 = tss.ss0;

	asm ("movl %%ebp, %0 ; \
	  		movl %%esp, %1;"
	 	:"=r"(curr_pcb.parent_ebp), "=r"(curr_pcb.parent_esp)     
	); 

	pcb_loc = (pcb_t*) ((uint32_t)KERNEL_BOTTOM - (curr_process + 1) * EIGHT_KB);
	memcpy(pcb_loc, &curr_pcb, sizeof(pcb_t));


	//read header of file
	read_data(dentry.inode_num, 0, file_header, HEADER_SIZE);

	//set up EIP (bytes 24-27)
	eip = (file_header[27] << 24) | (file_header[26] << 16) | (file_header[25] << 8) | (file_header[24]);
	// esp = USER_PROG_LOC + FOUR_MEG * (curr_process + 1) - 4; //esp located 4 bytes above the bottom of 4MB page
	esp = USER_PROG_LOC + FOUR_MEG - BYTES_IN_INT;
	//6. Prepare for context switch
		//something with TSS


	
	tss.ss0 = KERNEL_DS;
	tss.esp0 = KERNEL_BOTTOM - (curr_process) * EIGHT_KB - BYTES_IN_INT;
	// curr_pcb.ss0 = tss.ss0; 
	// curr_pcb.esp0 = tss.esp0; 

	
	k_ds = KERNEL_DS;
	k_cs = KERNEL_CS;
	u_ds = USER_DS;
	u_cs = USER_CS;

	//7. Push IRET context to stack
	asm volatile(
		"movl	%3, %%eax;	\n"		//set ds, es, fs, gs to user DS
		"movw	%%ax, %%ds	\n" 
		/*
		"movw	%%ax, %%es	\n"
		"movw	%%ax, %%fs	\n"
		"movw	%%ax, %%gs	\n"
		*/

//		"movl	%1, %%eax	\n"

		"pushl	%3			\n"		//push user DS to stack
		"pushl	%1			\n"		//push ESP to stack
		"pushfl				\n"		//push flags to stack
		"popl %%eax			\n"
		"orl $0x200, %%eax	\n"		//enable interrupts
		"pushl	%%eax		\n"
		
		"pushl	%2			\n"		//push user CS to stack
		"pushl	%0			\n"		//push EIP to stack

	: 
	: "r"(eip), "r"(esp), "r"(u_cs), "r"(u_ds)
	: "eax");

	//8. IRET
	//IRET_POS:
	asm volatile(
		"iret				\n"		//call iret
	);

	asm("ret_from_child:");
	//9. return 
	sti();
	return 0;
}


/* Function: parse_args(uint8_t* program, uint8_t* args, const uint8_t* command)
 * Inputs: buffer for program name, buffer for args, original command
 * Return Value: None
 * Description:  given a space separated list of words, get the first word which is the name 
 								 program to run, and rest of words which are the args for that program
 */
void parse_args(uint8_t* program, uint8_t* args, const uint8_t* command) {

	int i, program_name_found = 0;



	//initialize both arrays
	for (i = 0; i < FILE_NAME_SIZE; i++) { program[i] = '\0';}
	for (i = 0; i < ARGS_ARR_SIZE; i++) { args[i] = '\0';}

	

	//get name of program we want to run
	for(i = 0; i < FILE_NAME_SIZE; i++){			
		if((command[i] == ' ') || (command[i] == '\0')){
			program_name_found = 1;
		}
		program[i] = command[i];
	}

													//still need to handle args



}


/* Function: check_validity(uint8_t* program, dentry_t* dentry)
 * Inputs: name of program, dentry object to fill
 * Return Value: 0 on success, -1 on fail
 * Description:  Determine if file given is valid executable
 */
int32_t check_validity(uint8_t* program, dentry_t* dentry) {
	int read_dentry_fail;

	read_dentry_fail = read_dentry_by_name(program, dentry);
	// printf("%s\n", program);
	if (read_dentry_fail) {
		return -1;
	}

	//first 4 bytes which might contain magic numbers
	uint8_t exe_check[4];
	read_data(dentry->inode_num, 0, exe_check, 4);

	if ((dentry->file_type != 2)
		|| (exe_check[0] != MAGIC_EXE_NUM_1)
		|| (exe_check[1] != MAGIC_EXE_NUM_2)
		|| (exe_check[2] != MAGIC_EXE_NUM_3)
		|| (exe_check[3] != MAGIC_EXE_NUM_4)) {
		// printf("%02x %02x %02x %02x \n", exe_check[0], exe_check[1], exe_check[2], exe_check[3]);
		// printf("%s file is NOT valid", program);
		return -1;
	} else {
		// printf("%s file is valid", program);
		return 0;
	}

}

void load_file(dentry_t* dentry){

	uint8_t* virtual_addr = (uint8_t*)VIRTUAL_ADDR;
	inode_t* curr_inode = (void*)boot_block + (dentry->inode_num + 1) * DATA_BLOCK_SIZE;
	uint8_t file_data[curr_inode->length];

	read_data(dentry->inode_num, 0, file_data, curr_inode->length);
	memcpy(virtual_addr, file_data, curr_inode->length);


}


/* Function: int32_t read (int32_t _fd, const void* _buf, int32_t _nbytes)
 * Inputs: int32_t _fd, const void* _buf, int32_t _nbytes
 * Return Value: # of bytes written or -1 if fail
 * Description:  reads data from the keyboard, a file, device (RTC), or directory
 */

int32_t read (int32_t _fd, void* _buf, int32_t _nbytes){
    register int32_t ret asm("eax");
    register int32_t fd asm("ebx");
    register void* buf asm("ecx");
    register int32_t nbytes asm("edx");

    int32_t bytes_read;
    bytes_read = 0;
	
	// get pcb
	pcb_t *curr_pcb = get_pcb();
	//check bounds
	if (fd < 0 || fd > FD_ARRAY_SIZE)
		return -1;


	//see if file is open
	if (curr_pcb->fd_array[fd].flags == 0) 
		return -1;
	
	if (curr_pcb->fd_array[fd].file_operations) {
		// for terminal and stuff
		bytes_read = curr_pcb->fd_array[fd].file_operations->read(fd, (char*)buf, nbytes);
		ret = 0;
		return bytes_read;
	}
	

	switch(curr_pcb->fd_array[fd].dentry.file_type) {
		// 0 for a file giving user-level access to the real-time clock (RTC), 1 for the directory, and 2 for a regular file
		case 1:
			return read_data(curr_pcb->fd_array[fd].inode_num, curr_pcb->fd_array[fd].file_pos, buf, nbytes);
			break;
	}
	return 0;
}

/* Function: int32_t write (int32_t _fd, const void* _buf, int32_t _nbytes)
 * Inputs: int32_t _fd, const void* _buf, int32_t _nbytes
 * Return Value: # of bytes written or -1 if fail
 * Description: writes data to the terminal or to a device (RTC). In the case of the terminal, all data should
be displayed to the screen immediately
 */
int32_t write (int32_t _fd, const void* _buf, int32_t _nbytes){
    register int32_t ret asm("eax");
    register int32_t fd asm("ebx");
    register void* buf asm("ecx");
    register int32_t nbytes asm("edx");

    int32_t bytes_wrote;
	
	// get pcb
	pcb_t *curr_pcb = get_pcb();
	//check bounds
	if (fd < 0 || fd > FD_ARRAY_SIZE)
		return -1;

	
    if (curr_pcb->fd_array[fd].flags == 1) {
        bytes_wrote = curr_pcb->fd_array[fd].file_operations->write(fd, buf, nbytes);
		ret = 0;
		return bytes_wrote;
	}

    return -1;
}


/* Function: int32_t open(const uint8_t* _filename) 
 * Inputs: const uint8_t* _filename
 * Return Value: -1 if fail, else finds the right type of file and opens based on case
 * Description: find the directory entry corresponding to the
	named file, allocate an unused file descriptor, and set up any data necessary to handle the given type of file (directory,
	RTC device, or regular file). 
 */
int32_t open (const uint8_t* _filename) {
  register uint8_t* filename asm("ebx");
	pcb_t *pcb = get_pcb();
	
	int fd_idx;
	int success;

	dentry_t dentry;

	int i;

	//find next available fd block
	for(i = 2; i < FD_ARRAY_SIZE; i++){

		if(pcb->fd_array[i].flags == 0){
			
			//check if we can read the filename
			if (read_dentry_by_name(filename, &dentry) == -1){
				return -1;
			}

			fd_idx = i;
			break;
		}
	}

	switch(dentry.file_type){
		case 0:	//handle case of RTC type
			pcb->fd_array[fd_idx].inode_num = 0;
			pcb->fd_array[fd_idx].file_pos = 0;
			pcb->fd_array[fd_idx].flags = 1;
			pcb->fd_array[fd_idx].file_operations = &rtc_jump_table;
			success = pcb->fd_array[fd_idx].file_operations->open(_filename);
			return fd_idx;
			break;
		case 1://handle case of directory type
			pcb->fd_array[fd_idx].inode_num = 0;
			pcb->fd_array[fd_idx].file_pos = 0;
			pcb->fd_array[fd_idx].flags = 1;
			pcb->fd_array[fd_idx].file_operations = &directory_jump_table;
			success = pcb->fd_array[fd_idx].file_operations->open(_filename);
			return fd_idx;
			break;
		case 2://handle case of directory type
			pcb->fd_array[fd_idx].inode_num = dentry.inode_num;
			pcb->fd_array[fd_idx].file_pos = 0;
			pcb->fd_array[fd_idx].flags = 1;
			pcb->fd_array[fd_idx].file_operations = &file_jump_table;
			success = pcb->fd_array[fd_idx].file_operations->open(_filename);
			return fd_idx;
			break;
	}

	return 0;
}
/* Function: int32_t close(int32_t fd) 
 * Inputs: fd
 * Return Value: 0 on success or -1 on fail
 * Description: closes the specified file descriptor and makes it available for return from later calls
 */
int32_t close (int32_t fd){

	pcb_t *pcb = get_pcb();
	if (pcb->fd_array[fd].flags == 0)
		return -1;

	// change flag to 0 to show file closed
	pcb->fd_array[fd].flags = 0;
	
	//close
	if (0 != pcb->fd_array[fd].file_operations->close(fd))
		return -1;
	
	return 0;
}





