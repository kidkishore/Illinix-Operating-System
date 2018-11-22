#include "rtc.h"
#include "i8259.h"

#include "lib.h"

#include "types.h" 


#define cmosport1 0x70 //Port 0x70 is used to specify an index or "register number", and to disable NMI. 
#define cmosport2 0x71 //Port 0x71 is used to read or write from/to that byte of CMOS configuration space.

volatile int flag = 0; 

/* Function: init_rtc
 * Inputs: none
 * Return Value: none
 * Description: initialize the RTC
 */
void init_rtc(){
	cli(); // disable interrupts 
	outb(0x8A ,cmosport1); // select Status Register A, and disable NMI (by setting the 0x80 bit)
	outb(0x2F, cmosport2);	// write to CMOS/RTC RAM
	outb(0x8B, cmosport1);		// select register B, and disable NMI
	unsigned char prev=inb(cmosport2);	// read the current value of register B
	outb(0x8B, cmosport1);		// set the index again (a read will reset the index to register D)
	outb(prev | 0x40, cmosport2);	// write the previous value ORed with 0x40. This turns on bit 6 of register B
	sti(); //re-enabling interrupts

}
/* Function: rtc_interrupt_handler
 * Inputs: none
 * Return Value: none
 * Description: handles the RTC interrupts 
 */
void rtc_interrupt_handler() {
  //test_interrupts();		
  send_eoi(8); 	
  outb(0x0C,cmosport1); // select register C
  inb(cmosport2);	// just throw away contents 
  
  flag = 1; 
  
}

//rtc open = setting a frequency 
//rtc write = changing a frequency 
//rtc close = nothing
//rtc read = whenever rtc interrupt happens, rtc_read disables all other interrupts while rtc_interrupt is still going on and then re-enables

/* Function: rtc_close
 * Inputs: fd(file descriptor) 
 * Return Value: none
 * Description: close rtc
 */
int32_t rtc_close (int32_t fd) {
	return 0;  //this doesnt need any description/comments

}

/* Function: rtc_open
 * Inputs: const uint8_t* filename
 * Return Value: none
 * Description: set frequency to 2 
 */
int32_t rtc_open(const uint8_t* filename) {
		cli(); //disable interrupts
		outb(0x8A ,cmosport1); // select Status Register A, and disable NMI (by setting the 0x80 bit)
		unsigned char prev=inb(cmosport2);	// read the current value of register B
		outb(0x8A, cmosport1);		// set the index again
		outb((prev & 0xF0) | 0x0F, cmosport2); //write only our rate to A. Note, rate is the bottom 4 bits. Rate is set to 2 for open
		sti(); //re-enable interrupts 
		return 0; 
}

/* Function: rtc_open
 * Inputs: int32_t fd, const void* buf, int32_t nbytes
 * Return Value: none
 * Description: set rtc rate based on frequency  
 */
 
 //freq = (2^16/2^rate) 
int32_t rtc_write (int32_t fd, const void* buf, int32_t nbytes) {
	int rate; 
	int freq; 
	if (nbytes != 4) // if n bytes is not equal to 4, return -1, said so in documentation for mp3 
		return -1; 
	
	freq = *(int*)buf; 
	
	if ((!(freq & (freq - 1)) == 1) && (freq < 1025) && (freq > 0) ) { // check if power of 2, max 1024, must be greater than 0
	
	int counter = 0; 
	while (freq != 1) {
		freq = freq/2;     //keep dividing by 2 to get rate
		counter++; 
	}
		
	rate = 16 - counter;   // 16 - counter will = rate in the above equation
		
	}
	
	//printf("%d", rate); 

	
	cli(); //disable interrupts
	outb(0x8A ,cmosport1); // select Status Register A, and disable NMI (by setting the 0x80 bit)
	unsigned char prev=inb(cmosport2);	// read the current value of register B
	outb(0x8A, cmosport1);		// set the index again
	outb((prev & 0xF0) | rate, cmosport2); //write only our rate to A. Note, rate is the bottom 4 bits. Rate is set to 2 for open
	sti(); //re-enable interrupts 
		 
			
	return nbytes; 
}


/* Function: rtc_read
 * Inputs: int32_t fd, const void* buf, int32_t nbytes
 * Return Value: none
 * Description: whenever rtc interrupt happens, rtc_read disables all other interrupts while rtc_interrupt is still going on and then re-enables
 */

int32_t rtc_read(int32_t fd, void* buf, int32_t nbytes) {
	disable_irq(1);  //disable everything while rtc_interrupt is happening
	flag = 0; 
	while(flag == 0){  //wait till its over
	}
	enable_irq(1);  //re-enable 
	return 0; 
	
	
}












