#include "multiboot.h"
#include "x86_desc.h"
#include "lib.h"
#include "i8259.h"
#include "debug.h"
#include "tests.h"
#include "idt.h"
#include "system.h"
#include "dev/terminal.h"

/* Function: init_idt
 * Inputs: none
 * Return Value: none
 * Description: initialize the idt table. sets the corresponding correct idt entry descriptors 
 */

void load_idt(){

	int i;
	i=0;

	while(i<NUM_VEC) {

		if(i==15){	//dont use the intel deserved vector
			i++;
			continue;
		}


		//default descriptors get these properties
		idt[i].seg_selector = KERNEL_CS;
		idt[i].dpl = 0;
		idt[i].present = 1;
		idt[i].size = 1;

		idt[i].reserved4 = 0;
		idt[i].reserved3 = 0;
		idt[i].reserved2 = 1;
		idt[i].reserved1 = 1;
		idt[i].reserved0 = 0;



		//if trap vector, change type to 1
		if(i<NUM_RESERVED_VEC){
	
			idt[i].reserved3 = 1;

    	}

      if (i == 33 || i == 40) {
        // intterupt
        // kb, rtc
        idt[i].seg_selector = KERNEL_CS;
        idt[i].present = 1;
        idt[i].dpl = 0;
        idt[i].reserved3 = 0;
        idt[i].reserved2 = 1;
        idt[i].reserved1 = 1;
        idt[i].reserved0 = 0;
        idt[i].size      = 1;
      } else if( i == SYS_CALL_ENTRY) {
        // system calls
        idt[i].dpl = 3;
        idt[i].reserved3 = 1;
        idt[i].reserved2 = 1;
        idt[i].reserved1 = 1;  
        idt[i].size      = 1; 
      }
    	i++;
	}

    SET_IDT_ENTRY(idt[0],divide_zero_exception);
    SET_IDT_ENTRY(idt[1],single_step_exception);
    SET_IDT_ENTRY(idt[2],nmi_exception);
    SET_IDT_ENTRY(idt[3],breakpoint_exception);
    SET_IDT_ENTRY(idt[4],overflow_exception);
    SET_IDT_ENTRY(idt[5],bounds_exception);
    SET_IDT_ENTRY(idt[6],invalid_opcode_exception);
    SET_IDT_ENTRY(idt[7],coprocessor_exception);
    SET_IDT_ENTRY(idt[8],double_fault_exception);
    SET_IDT_ENTRY(idt[9],segment_overrun_exception);
    SET_IDT_ENTRY(idt[10],invalid_tss_exception);
    SET_IDT_ENTRY(idt[11],segment_not_present_exception);
    SET_IDT_ENTRY(idt[12],stack_fault_exception);
    SET_IDT_ENTRY(idt[13],general_protection_exception);
    SET_IDT_ENTRY(idt[14],page_fault_exception);
    SET_IDT_ENTRY(idt[16],math_fault_exception);
    SET_IDT_ENTRY(idt[17],alignment_check_exception);
    SET_IDT_ENTRY(idt[18],machine_check_exception);
    SET_IDT_ENTRY(idt[19],simd_exception);
    SET_IDT_ENTRY(idt[33], kb_interrupt);
	  SET_IDT_ENTRY(idt[40], rtc_interrupt);
    SET_IDT_ENTRY(idt[SYS_CALL_ENTRY], sys_call);
}

// keyboard 
int32_t caps_enabled = 0;
int32_t shift_pressed = 0;
int32_t ctrl_pressed = 0;
int32_t alt_pressed = 0;
int32_t meta_pressed = 0;
int32_t enter_pressed = 0;

char char_map[57] = {
  '?', '?', '1', '2', '3', '4', '5', '6', '7', '8', '9', '0', '-', '=', '?', ' ',
  'q', 'w', 'e', 'r', 't', 'y', 'u', 'i', 'o', 'p', '[', ']', '\n', '?', 'a', 's',
  'd', 'f', 'g', 'h', 'j', 'k', 'l', ';', '\'', '`', '?', '\\', 'z', 'x', 'c', 'v',
  'b', 'n', 'm', ',', '.', '/', '?', '?', ' '};

char char_map_caps[57] = {
  '?', '?', '!', '@', '#', '$', '%', '^', '&', '*', '(', ')', '_', '+', '?', ' ',
  'Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P', '{', '}', '\n', '?', 'A', 'S',
  'D', 'F', 'G', 'H', 'J', 'K', 'L', ':', '"', '~', '?', '|', 'Z', 'X', 'C', 'V',
  'B', 'N', 'M', ',', '.', '?', '?', '?', ' '};


#define ENTER_PRESSED (input == 0x1c)
#define BKSP_PRESSED (input == 0x0e)
#define BKSP_CHAR 8
#define CLS_CHAR 25
#define VIDEO       0xB8000
#define NUM_COLS    80
#define NUM_ROWS    25
#define ATTRIB      0x7
#define CTRL_PRESSED ((input == 0x1D) || (input == 0xE0))
#define CTRL_RELEASED ((input == 0x9D))
#define SHIFT_PRESSED ((input == 42) || (input == 54))
#define SHIFT_RELEASED ((input == 0xAA) || (input == 0xB6))
#define ALT_PRESSED ((input == 0x38) || (input == 0x36))
#define ALT_RELEASED (input == 0xB8)
#define ANY_RELEASED ((input >= 0x81 && input <= 0xD8))
#define CLEAR_PRESSED ctrl_pressed && (input == 0x26)
#define CAPS_PRESSED (input == 0x3A)
#define NOT_SYMBOL_PRESSED (char_map[input] <= 'z' && char_map[input] >= 'a')

int32_t x = 0, y = 0;

/* Function: kb_interrupt_do
 * Inputs: irq, *dev_id 
 * Return Value: none
 * Description: detect if any key is being pressed to send interrupt 
 */
void kb_interrupt_do(int irq, void *dev_id/*, struct pt_regs *regs*/) {
  unsigned char status, input;
  status = inb(0x64);
  input = inb(0x60);

  char character;
  // printf("%d\n", input);
  if (ANY_RELEASED) {
    if (CTRL_RELEASED)
      ctrl_pressed = 0;
    if (SHIFT_RELEASED)
      shift_pressed = 0;
    if (ALT_RELEASED)
      alt_pressed = 0;
    goto kb_handle_done;
  }
  if (SHIFT_PRESSED) {
    shift_pressed = 1;
    goto kb_handle_done;
  }
  if (ALT_PRESSED) {
    alt_pressed = 1;
    goto kb_handle_done;
  }
  if (CTRL_PRESSED) {
    ctrl_pressed = 1;
    goto kb_handle_done;
  }
  if (ENTER_PRESSED) {
    enter_pressed = 1;
    character = '\n';
    terminal_write(0, &character, 1);
    goto kb_handle_done;
  }
  if (CAPS_PRESSED) {
    caps_enabled = 1 - caps_enabled;
    goto kb_handle_done;
  }

  if (BKSP_PRESSED) {
    character = BKSP_CHAR;
    terminal_write(0, &character, 1);
    goto kb_handle_done;
  }

  if (alt_pressed || ctrl_pressed || meta_pressed) {
    if (CLEAR_PRESSED) {
      character = CLS_CHAR;
      terminal_write(0, &character, 1);
    }
    goto kb_handle_done;
  } else {
    if (NOT_SYMBOL_PRESSED) {
      character = shift_pressed ^ caps_enabled ? char_map_caps[input] : char_map[input];
    } else {
      character = shift_pressed ? char_map_caps[input] : char_map[input];
    }
    terminal_write(0, &character, 1);
  }

  kb_handle_done:
  send_eoi(1);
}




/* Function: divide_zero_exception
 * Inputs: none
 * Return Value: none
 * Description: interrupt for corresponding idt entry 
 */

void divide_zero_exception(){
  cli();
  printf("divide by zero exception.\n");
  halt(-1);
}

/* Function: single_step_exception
 * Inputs: none
 * Return Value: none
 * Description: interrupt for corresponding idt entry 
 */

void single_step_exception(){
  cli();
  printf("Single step exception.\n");
  halt(-1);
}

/* Function: nmi_exception
 * Inputs: none
 * Return Value: none
 * Description: interrupt for corresponding idt entry 
 */
void nmi_exception(){
  cli();
  printf("NMI exception.\n");
  halt(-1);
}


/* Function: breakpoint_exceptionn
 * Inputs: none
 * Return Value: none
 * Description: interrupt for corresponding idt entry 
 */

void breakpoint_exception(){
  cli();
  printf("Breakpoint exception.\n");
  halt(-1);
}


/* Function: overflow_exception
 * Inputs: none
 * Return Value: none
 * Description: interrupt for corresponding idt entry 
 */
void overflow_exception(){
  cli();
  printf("Overflow exception.\n");
  halt(-1);
}


/* Function: bounds_exception
 * Inputs: none
 * Return Value: none
 * Description: interrupt for corresponding idt entry 
 */
void bounds_exception(){
  cli();
  printf("Bounds exception.\n");
  halt(-1);
}


/* Function: invalid_opcode_exception
 * Inputs: none
 * Return Value: none
 * Description: interrupt for corresponding idt entry 
 */
void invalid_opcode_exception(){
  cli();
  printf("Invalid opcode exception.\n");
  halt(-1);
}

/* Function: coprocessor_exception
 * Inputs: none
 * Return Value: none
 * Description: interrupt for corresponding idt entry 
 */
void coprocessor_exception(){
  cli();
  printf("Coprocessor exception.\n");
  halt(-1);
}

/* Function: double_fault_exception
 * Inputs: none
 * Return Value: none
 * Description: interrupt for corresponding idt entry 
 */
void double_fault_exception(){
  cli();
  printf("Double fault exception.\n");
  halt(-1);
}

/* Function: segment_overrun_exception
 * Inputs: none
 * Return Value: none
 * Description: interrupt for corresponding idt entry 
 */
void segment_overrun_exception(){
  cli();
  printf("Segment overrun exception.\n");
  halt(-1);
}

/* Function: invalid_tss_exception
 * Inputs: none
 * Return Value: none
 * Description: interrupt for corresponding idt entry 
 */
void invalid_tss_exception(){
  cli();
  printf("Invalid tss exception.\n");
  halt(-1);
}

/* Function: segment_not_present_exception
 * Inputs: none
 * Return Value: none
 * Description: interrupt for corresponding idt entry 
 */
void segment_not_present_exception(){
  cli();
  printf("Segment not present exception.\n");
  halt(-1);
}


/* Function: stack_fault_exception
 * Inputs: none
 * Return Value: none
 * Description: interrupt for corresponding idt entry 
 */
void stack_fault_exception(){
  cli();
  printf("Stack fault exception.\n");
  halt(-1);
}


/* Function: general_protection_exception
 * Inputs: none
 * Return Value: none
 * Description: interrupt for corresponding idt entry 
 */
void general_protection_exception(){
  cli();
  printf("General protection exception.\n");
  halt(-1);
}

/* Function: page_fault_exception
 * Inputs: none
 * Return Value: none
 * Description: interrupt for corresponding idt entry 
 */
void page_fault_exception(){
  cli();
  printf("Page fault exception.\n");
  halt(-1);
}

/* Function: math_fault_exception
 * Inputs: none
 * Return Value: none
 * Description: interrupt for corresponding idt entry 
 */
void math_fault_exception(){
  cli();
  printf("Math fault exception.\n");
  halt(-1);
}


/* Function: alignment_check_exception
 * Inputs: none
 * Return Value: none
 * Description: interrupt for corresponding idt entry 
 */
void alignment_check_exception(){
  cli();
  printf("Alignment check exception.\n");
  halt(-1);
}


/* Function: machine_check_exception
 * Inputs: none
 * Return Value: none
 * Description: interrupt for corresponding idt entry 
 */
void machine_check_exception(){
  cli();
  printf("Machine check exception.\n");
  halt(-1);
}


/* Function: simd_exception
 * Inputs: none
 * Return Value: none
 * Description: interrupt for corresponding idt entry 
 */
void simd_exception(){
  cli();
  printf("Simd exception.\n");
  halt(-1);
}

