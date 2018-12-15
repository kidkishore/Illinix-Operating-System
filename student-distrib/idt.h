/* init_idt.h - initializes the idt */

#ifndef _IDT
#define _IDT

#include "pit.h"

#define NUM_RESERVED_VEC	32
#define SYS_CALL_ENTRY 0x80
void load_idt();
void divide_zero_exception();
void single_step_exception();
void nmi_exception();
void breakpoint_exception();
void overflow_exception();
void bounds_exception();
void invalid_opcode_exception();
void coprocessor_exception();
void double_fault_exception();
void segment_overrun_exception();
void invalid_tss_exception();
void segment_not_present_exception();
void stack_fault_exception();
void general_protection_exception();
void page_fault_exception();
void math_fault_exception();
void alignment_check_exception();
void machine_check_exception();
void simd_exception();
void kb_interrupt();
void kb_interrupt_do();
void rtc_interrupt();
void pit_interrupt();
void sys_call(); 

#endif /* IDT */


