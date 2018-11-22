#include "pcb.h"
#include "lib.h"
#include "types.h"
#include "system.h"
#include "filesys.h"
#include "rtc.h"


fd_struct_t stdin, stdout;

struct file_op_table terminal_input_jump_table = { 
  &terminal_read, &null_func, &terminal_open, &terminal_close
};

struct file_op_table terminal_output_jump_table = { 
  &null_func, &terminal_write, &terminal_open, &terminal_close
};



/* Function: pcb_t create_pcb()
 * Inputs: none
 * Return Value: pcb 
 * Description:  creates a pcb and then returns it
 */

pcb_t create_pcb(){
	int i;
	pcb_t pcb;

/*
  stdout.flags = 1;
  stdout.file_pos = 0;
  stdout.inode_num = 0;
  stdout.file_operations = &terminal_output_jump_table;
  stdin.flags = 1;
  stdin.file_pos = 0;
  stdin.inode_num = 0;
  stdin.file_operations = &terminal_input_jump_table;
  */

	for(i = 0; i < FD_ARRAY_SIZE; i++){
		pcb.fd_array[i].file_operations = NULL;
		pcb.fd_array[i].inode_num = 0;
		pcb.fd_array[i].file_pos = 0;	//updated by read
		pcb.fd_array[i].flags = 0;	//marking is "in use"
	}
	
	pcb.fd_array[0].file_operations = &terminal_input_jump_table;
	pcb.fd_array[1].file_operations = &terminal_output_jump_table;
	pcb.fd_array[0].flags = 1;
	pcb.fd_array[1].flags = 1;
	
	return pcb;
}


/* Function: pcb_t *get_pcb(void)
 * Inputs: none
 * Return Value: current pcb
 * Description:  gets the current pcb
 */

pcb_t *get_pcb(void){
  pcb_t *pcb;
  asm volatile("movl %%esp, %0       \n\
                andl %1, %0"
                 : "=r" (pcb)
                 : "i" (PCB_MASK)
               );
  return pcb;
}


