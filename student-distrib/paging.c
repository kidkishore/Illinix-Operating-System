#include "paging.h"
#include "lib.h"
#include "types.h"
#include "debug.h"
#include "tests.h"
#include "multiboot.h"
#include "x86_desc.h"
#include "i8259.h"
#include "idt.h"

uint32_t page_dir[TABLE_SIZE] __attribute__((aligned(FOUR_KB)));
uint32_t page_table[TABLE_SIZE] __attribute__((aligned(FOUR_KB)));

/* Function: paging_init
 * Inputs: none
 * Return Value: none
 * Description: Sets the paging director and table to empty values
				and initializes the first entry in page directory to page table,
				the second entry to the kernel location, and video address location to the video address
 */
void paging_init(){

	

	int i;
	
	//fill in page directory to empty pages
	for(i = 0; i < TABLE_SIZE; i++){
		page_dir[i] = 0;
		page_table[i] = 0;
	}


	//set video address location in page table to present
	page_table[VIDEO / FOUR_KB] = VIDEO | PRESENT_PAGE;

	//set first entry of page directory to page table
    page_dir[0] =  (uint32_t)page_table | PRESENT_PAGE;

    //set second entry blog for kernel
    page_dir[1] = KERNEL | ENABLE_KERNEL | PRESENT_PAGE; 

}

/* Function: paging_enable
 * Inputs: none
 * Return Value: none
 * Description: Copy address of page_dir into cr3 register, 
 				enable paging (PG), protection (PE), and PSE (4MB pages)
 */

void paging_enable(){
	
	//copy address of page_dir into cr3 register, enable paging (PG) and protection (PE), enable PSE (4MB pages)     
	asm volatile("				\n\
		movl %0, %%eax 			\n\
		movl %%eax, %%cr3		\n\
		movl %%cr4, %%eax 		\n\
        orl  $0x00000010, %%eax	\n\
        movl %%eax, %%cr4 		\n\
		movl %%cr0, %%eax 		\n\
	 	orl $0x80000000, %%eax	\n\
		movl %%eax, %%cr0 		\n\
		"
		
		://output operands (optional)
		:"r" (page_dir)	//input operand, the paging directory address
		:"eax"//clobbered registers, eax
		);

}

void create_page(uint32_t curr_process) {
	
	uint32_t location = KERNEL_BOTTOM + curr_process * FOUR_MEG;

	page_dir[USER_PROGRAM_PDIR_LOC] = location | ENABLE_KERNEL | ENABLE_USER | PRESENT_PAGE; // ?
	//flush the TLB
	asm volatile("movl %%cr3, %%eax;	\n" 
				 "movl %%eax, %%cr3;	  " 
		:
		:
		: "eax");
}
