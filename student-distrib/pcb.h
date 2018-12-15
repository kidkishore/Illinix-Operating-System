#ifndef _PCB_H
#define _PCB_H

#include "types.h"
#include "filesys.h"
#include "multiboot.h"
#include "dev/terminal.h"
#include "system.h"

#define FD_ARRAY_SIZE 8
#define NUM_OPERATIONS 4
#define PCB_MASK 0xFFFFE000

typedef struct fd_struct {
	struct file_op_table* file_operations;
	int32_t inode_num;	//only value for data files, 0 for directories and rtc	
	int32_t file_pos;	//updated by read
	int32_t flags;	//marking is "in use"
	dentry_t dentry;
} fd_struct_t;

struct pcb  {
	fd_struct_t fd_array[FD_ARRAY_SIZE];
	struct pcb* parent; 
	int32_t process_num;
	int32_t parent_esp0; 
	int32_t parent_ss0;
	int32_t ebp;
	int32_t esp;
	int32_t parent_ebp;
	int32_t parent_esp;
	uint8_t args[ARGS_ARR_SIZE];
	uint8_t tty;
}  __attribute__((aligned(16)));

typedef struct pcb pcb_t;



typedef struct file_op_table {

	int32_t (*read)(int32_t fd, void* buf, int32_t nbytes);
	int32_t (*write)(int32_t fd, const void* buf, int32_t nbytes);
	int32_t (*open)(const uint8_t* filename);
	int32_t (*close)(int32_t fd);

} file_op_table_t;


 

extern pcb_t create_pcb();

uint32_t processes[MAX_NUM_PROCESSES];
pcb_t *get_pcb(void);


/* FILE OPERATIONS */
/*
open();
close();
read();
write();
*/


/* HELPER FUNCTIONS */





#endif 

