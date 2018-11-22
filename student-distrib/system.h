#ifndef _SYSTEM_H
#define _SYSTEM_H

#include "types.h"
#include "multiboot.h"
#include "paging.h"
#include "filesys.h"

#define BYTES_IN_INT 4
#define HEADER_SIZE 40
#define NAME_SIZE 33
#define PATH_SIZE 120
#define ARGS_ARR_SIZE 100
#define MAGIC_EXE_NUM_1 0x7f
#define MAGIC_EXE_NUM_2 0x45
#define MAGIC_EXE_NUM_3 0x4c
#define MAGIC_EXE_NUM_4 0x46
#define VIRTUAL_ADDR  0x08048000
#define USER_PROG_LOC 0x08000000
#define asmlinkage __attribute__((regparm(0)))


/* SYSTEM CALLS */

asmlinkage int32_t halt (uint8_t status);
extern int32_t sys_execute(const uint8_t* _command);
asmlinkage int32_t execute (const uint8_t* command);
asmlinkage int32_t read (int32_t fd, void* buf, int32_t nbytes);
asmlinkage int32_t write (int32_t fd, const void* buf, int32_t nbytes);
asmlinkage int32_t open (const uint8_t* filename);
asmlinkage int32_t close (int32_t fd);


/* HELPER FUNCTIONS */
int32_t check_validity(uint8_t* program, dentry_t* dentry);
void load_file(dentry_t* dentry);
void parse_args(uint8_t* program, uint8_t* args, const uint8_t* command);

#endif 
