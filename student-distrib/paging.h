#ifndef _PAGING
#define _PAGING
#include "types.h"

#define TABLE_SIZE 1024
#define FOUR_KB 4096
#define EIGHT_KB 8192
#define PRESENT_PAGE 0x1
#define FOUR_MEG 0x400000
#define VIDEO 0xB8000
#define KERNEL 0x400000
#define KERNEL_BOTTOM 0x800000
#define ENABLE_KERNEL 0x80
#define ENABLE_USER   0x7
#define USER_PROGRAM_PDIR_LOC 32


//page directory
extern uint32_t page_dir[TABLE_SIZE] __attribute__((aligned(FOUR_KB)));

//page table
extern uint32_t page_table[TABLE_SIZE] __attribute__((aligned(FOUR_KB)));

extern void create_page(uint32_t curr_process);

void paging_init();
void paging_enable();
extern void create_page(uint32_t curr_process);

#endif /* _PAGING_H */

