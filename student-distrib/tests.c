#include "tests.h"
#include "x86_desc.h"
#include "lib.h"
#include "paging.h"


#include "rtc.h"
#include "dev/terminal.h"

#include "filesys.h"


#include "rtc.h"
#include "filesys.h"

#define TERM_BUFSIZE 128

#define PASS 1
#define FAIL 0

/* format these macros as you see fit */
#define TEST_HEADER 	\
	printf("[TEST %s] Running %s at %s:%d\n", __FUNCTION__, __FUNCTION__, __FILE__, __LINE__)
#define TEST_OUTPUT(name, result)	\
	printf("[TEST %s] Result = %s\n", name, (result) ? "PASS" : "FAIL");

static inline void assertion_failure(){
	/* Use exception #15 for assertions, otherwise
	   reserved by Intel */
	asm volatile("int $15");
}


/* Checkpoint 1 tests */

/* IDT Test - Example
 * 
 * Asserts that first 10 IDT entries are not NULL
 * Inputs: None
 * Outputs: PASS/FAIL
 * Side Effects: None
 * Coverage: Load IDT, IDT definition
 * Files: x86_desc.h/S
 */

int idt_test(){
	TEST_HEADER;

	int i;
	int result = PASS;
	for (i = 0; i < 10; ++i){
		if ((idt[i].offset_15_00 == NULL) && 
			(idt[i].offset_31_16 == NULL)){
			assertion_failure();
			result = FAIL;
		}
	}

	return result;
}

/* Paging Test
 * 
 * Checks to see if first 2 entries in page directory are set to present 
 * Inputs: None
 * Outputs: PASS/FAIL
 * Side Effects: None
 * Coverage: page_dir
 * Files: paging.h/c
 */
int paging_test(){
	TEST_HEADER;
	int result = PASS;

	int a;
	int* b;

	a = 3;
	b = &a;

	if(*b != a){
		assertion_failure();
		result = FAIL;
	}


	if((page_dir[0] & 0x1) != 1){
		assertion_failure();
		result = FAIL;
	}

	if((page_dir[1] & 0x1) != 1){
		assertion_failure();
		result = FAIL;
	}



	return result;

}



/* Checkpoint 2 tests */



/* Function Name: rtc_test()
 * Inputs: none
 * Outputs: RTC Open Pass/Fail (if it worked), bunch of 1s for rtc frequency 
 * Description: function checks if rtc_open, rtc_read, rtc_write works  
 */
void rtc_test() {
	clear(); 
	int i,j; 
	rtc_open(0);
	outb(0x70, 0x8A);
	int freq = inb(0x71);
	if((freq & 0x0F) != 0x0F){   //check if freq is 2
		printf("RTC OPEN FAIL ");
	}
	else{
		printf("RTC OPEN PASS ");
	}
	
	for(i=2; i < 1025; i *= 2){  //loop through all frequencies 
		rtc_write(0, &i, 4);
		for(j=0; j < 20; j++){
			printf("1 ");  //watch the printed 1's frequency change 
			rtc_read(0, NULL, 0);
		}
		
		clear(); 
	}
	printf("RTC READ/WRITE PASS"); 
}
	
	
	
	





/* read_dentry_by_index_test Test
 * 
 * Checks to see if we can read all the directories by index
 * Inputs: None
 * Outputs: PASS/FAIL
 * Side Effects: None
 * Coverage: read_dentry_by_index_test
 * Files: filesys.h/c
 */
int read_dentry_by_index_test(){

	TEST_HEADER;
	int result = PASS;

	int i;
	int j;
	

	putc('\n');

	//loop through all existing directory indexes and print name, filetype, and inode number
	for(i = 0; i < boot_block->num_dir; i++){
		
		dentry_t test_dir;

		//if call to read directory by index fails, test fails
		if(read_dentry_by_index(i, &test_dir) == -1){
			assertion_failure();
			result = FAIL;
			break;
		}

		//else, print the name, filetype, and inode number
		printf("  Name: ");
		for(j = 0;j < FILE_NAME_SIZE; j++){
			putc(test_dir.file_name[j]);
		}
		putc('\t');
		printf("Type:  %d    ", test_dir.file_type);
		
		inode_t* curr_inode = (void*)boot_block + (test_dir.inode_num + 1) * DATA_BLOCK_SIZE;
		
		printf("File Size: %d", curr_inode->length);
		putc('\n');


	}


	return result;

}

/* read_dentry_by_name_test Test
 * 
 * Checks to see if we can read all the directories by name
 * Inputs: None
 * Outputs: PASS/FAIL
 * Side Effects: None
 * Coverage: read_dentry_by_name_test
 * Files: filesys.h/c
 */
int read_dentry_by_name_test(){
	TEST_HEADER;
	int result = PASS;

	int i;
	int j;
	

	putc('\n');

	//loop through all existing directory indexes and print name, filetype, and inode number
	for(i = 0; i < boot_block->num_dir; i++){
		
		dentry_t test_dir;

		char name[FILE_NAME_SIZE + 1];
		strncpy(name, boot_block->directories[i].file_name, FILE_NAME_SIZE);
		name[FILE_NAME_SIZE] = '\0';

		//if call to read directory by index fails, test fails
		if(read_dentry_by_name((uint8_t*)name, &test_dir) == -1){
			assertion_failure();
			result = FAIL;
			break;
		}

		//else, print the name, filetype, and inode number
		printf("  Name: ");
		for(j = 0;j < FILE_NAME_SIZE; j++){
			putc(test_dir.file_name[j]);
		}
		putc('\t');
		printf("Type:  %d    ", test_dir.file_type);
		
		inode_t* curr_inode = (void*)boot_block + (test_dir.inode_num + 1) * DATA_BLOCK_SIZE;
		
		printf("File Size:  %d", curr_inode->length);
		putc('\n');


	}


	return result;

}

/* read_data_test Test
 * 
 * Checks to see if we can read data from a given file
 * Inputs: None
 * Outputs: PASS/FAIL
 * Side Effects: None
 * Coverage: read_data_test
 * Files: filesys.h/c
 */
int read_data_test(){
	TEST_HEADER;
	int result = PASS;

	int i;
	int bytes_read;

	int num_bytes_to_read;

	num_bytes_to_read = 1000;
	char* fname = "frame1.txt";



	putc('\n');

	uint8_t buf[num_bytes_to_read];

	dentry_t test_dir;

	//if call to read directory by index fails, test fails
	if(read_dentry_by_name((uint8_t*)fname, &test_dir) == -1){
		assertion_failure();
		result = FAIL;
	}

	bytes_read = read_data(test_dir.inode_num, 0, buf, num_bytes_to_read);

	if(bytes_read == -1){
		assertion_failure();
		result = FAIL;
	}

	if(result != FAIL){
		for(i = 0; i < bytes_read; i++)
			putc(buf[i]);
	}

	putc('\n');
	printf("File name: %s", fname);
	putc('\n');


	return result;

}

/* terminal_test Test
 * 
 * Checks to see if we can read from terminal
 * Inputs: None
 * Outputs: PASS/FAIL
 * Side Effects: None
 * Coverage: terminal_read/write
 * Files: dev/terminal.h/c
 */
int terminal_test() {
	char buf[TERM_BUFSIZE];
	int cnt;
  puts("Hi, what's your name? ");
  if (-1 == (cnt = terminal_read (0, buf, TERM_BUFSIZE-1))) {
      puts ("Can't read from keyboard.\n");
			return FAIL;
  }
  puts("\n you put:	");
  puts(buf);
  puts("\n");
  return PASS;
}

/* divide_by_zero Test
 * 
 * Aims to trigger the divide by zero exception.
 * Inputs: None
 * Outputs: Divide by Zero exception
 * Side Effects: None
 * Files: tests.c
 */
int divide_by_zero_test()
{
	int a = 2;
	int b = 0;
	int c = 0;
	c = a/b; 
	return c; 
}


/* page_fault_test
 * 
 * Aims to trigger the page_fault exception.
 * Inputs: None
 * Outputs: The Page Fault Exception 
 * Side Effects: None
 * Files: tests.c
 */
int page_fault_test()
{
	int* a = 0x0;
	int b;
	b = *a;
	return b;
}



/* Checkpoint 3 tests */
/* Checkpoint 4 tests */
/* Checkpoint 5 tests */


/* Test suite entry point */
void launch_tests(){
	//clear();
	//TEST_OUTPUT("idt_test", idt_test());
	//TEST_OUTPUT("paging_test", paging_test());

	// rtc_test(); 
	//divide_by_zero_test();
	
	//rtc_test(); 
	//page_fault_test();
	

	// TEST_OUTPUT("file_system_test", file_sys_test());

	TEST_OUTPUT("term test", terminal_test());


	//TEST_OUTPUT("read_dentry_by_index_test", read_dentry_by_index_test());
	// TEST_OUTPUT("read_dentry_by_name_test", read_dentry_by_name_test());
	// TEST_OUTPUT("read_data_test", read_data_test());
	//rtc_test(); 
	//TEST_OUTPUT("read_dentry_by_name_test", read_dentry_by_name_test());
	//TEST_OUTPUT("read_data_test", read_data_test());


	// launch your tests here
}







