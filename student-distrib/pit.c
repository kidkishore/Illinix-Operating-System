#include "pit.h"
#include "i8259.h"
#include "lib.h"
#include "scheduling.h"

#include "types.h" 


/* 
 * Function: void pit_init() 
 * Input: void 
 * Return: void 
 * Description: initialize the pit 
 */ 
 void pit_init() 
 {              
 	/* set command byte 0x36 */ 
     outb(PIT_MODE, PIT_CMD);  
     /* set low byte */ 
     outb((PIT_FREQ / PIT_COUNT) & PIT_MASK, PIT_CH0); 
     /* set high byte*/ 
     outb((PIT_FREQ / PIT_COUNT) >> PIT_SHIFT, PIT_CH0);  
 	 
     /* enable on the PIC*/ 
 	 
 	return; 
 } 

/* Function: pit_handler
 * Inputs: None
 * Return Value: None
 * Description: Is called everytime a PIT interrupt is generated. 
 				Sends EOI signal and calls the switch_process function to switch to the next active process.
 */
void pit_handler() 
{

	send_eoi(0);

	switch_process(); 

}



