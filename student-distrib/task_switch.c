#include "task_switch.h"


/* void switch_to_tty(uint8_t tty);
 * Inputs: tty
 * Return Value: none
 * Side effect: switch to another tty. if nothing, run a shell. also, does context switch. call screen switch.
 * Function: switch tty */
void switch_to_tty(uint8_t tty) {
  switch_screen(tty);
  active_tty = tty;
  // printf("goto !!! %d\n", tty);
  // printf("active !!! %d\n", active_tty);
  if (tty_top_pid[active_tty] == TTY_UNOPENED) {
    clear();
    next_one_is_root_shell = 1;
    sys_execute((uint8_t*)"shell");
    sti();
  }

  else {
    uint8_t next_process_num = tty_top_pid[tty];
    //get next process pcb
    pcb_t* next_pcb = (pcb_t*)(EIGHT_MEG - EIGHT_KB * (next_process_num+1));

    // printf("sw %d \n", next_process_num);
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

  }
}
