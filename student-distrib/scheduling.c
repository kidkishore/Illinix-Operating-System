#include "lib.h"
#include "types.h"
#include "filesys.h"
#include "multiboot.h"
#include "pcb.h"
#include "paging.h"
#include "system.h"


/* Function: get_next_process
 * Inputs: current terminal ID (curr_tty)
 * Return Value: process number of next process
 * Description: Find the next active process in the other terminals, and return its process number
 */
uint32_t get_next_process(uint32_t curr_tty) {
	uint32_t next_tty = curr_tty + 1;

	while (tty_top_pid[next_tty] == TTY_UNOPENED) {
		next_tty += 1;
		next_tty %= MAX_TTY;
	}

	return tty_top_pid[curr_tty];

}

/* Function: switch_process
 * Inputs: None
 * Return Value: None
 * Description: Switches to the next active process amongst the terminals whenver the PIT interrupt is generated
 */
void switch_process() {
	cli();
	// get pcb
	pcb_t *curr_pcb = get_pcb();
	pcb_t* next_pcb;
	uint32_t next_process_num;

	uint32_t curr_process_num = curr_pcb->process_num;
	uint32_t curr_tty = curr_pcb->tty;

	//save current processes ebp and esp
	asm volatile("movl %%ebp, %0 ; \
	  		movl %%esp, %1;"
		:"=r"(curr_pcb->ebp), "=r"(curr_pcb->esp)
	);

	
	//get next active process
	next_process_num = get_next_process(curr_tty);
	// printf("!%d!", next_process_num);
	if ((next_process_num) == -1 || (next_process_num == curr_process_num)) {
		return;
	}
	

	//get next process pcb
	next_pcb = (pcb_t*)(EIGHT_MEG - EIGHT_KB * (next_process_num+1));

	//load up next processes
	create_page(next_process_num);

	//set tss
	tss.ss0 = KERNEL_DS;
	tss.esp0 = KERNEL_BOTTOM - (next_process_num)* EIGHT_KB - BYTES_IN_INT;

	// restore esp ebp
	register uint32_t temp asm("ecx");
	temp = next_pcb->esp;
	asm volatile("movl %0, %%ebp;" :: "r"(next_pcb->ebp) : "%ebp");
	asm volatile("movl %%ecx, %%esp;" :::"%ecx", "%esp");

	sti();
}
