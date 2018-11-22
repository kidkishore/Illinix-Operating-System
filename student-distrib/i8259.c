/* i8259.c - Functions to interact with the 8259 interrupt controller
 * vim:ts=4 noexpandtab
 */

#include "i8259.h"
#include "lib.h"
 
/* Interrupt masks to determine which interrupts are enabled and disabled */
uint8_t master_mask = 0xff; /* IRQs 0-7  */
uint8_t slave_mask = 0xff;  /* IRQs 8-15 */

static unsigned int cached_irq_mask = 0xffff;
// all disabled

#define __byte(x,y) 	(((unsigned char *)&(y))[x])
#define cached_21	(__byte(0,cached_irq_mask))
#define cached_A1	(__byte(1,cached_irq_mask))
/* Function: i8259_init
 * Inputs: none
 * Return Value: none
 * Description: initialize the PIC (both master + slave)
 */
void i8259_init(void) {
	// unsigned long flags;

	// i8259A_auto_eoi = auto_eoi;
	// spin_lock_irqsave(&i8259A_lock, flags);

	outb(master_mask, MASTER_8259_PORT_CONFIG);	/* mask all of 8259A-1 */
	outb(slave_mask, SLAVE_8259_PORT_CONFIG);	/* mask all of 8259A-2 */

	/*
	 * outb - this has to work on a wide range of PC hardware.
	 */
	outb(ICW1, MASTER_8259_PORT);	/* ICW1: select 8259A-1 init */
	// IRQ0_VECTOR -> ICW2_MASTER
	outb(ICW2_MASTER, MASTER_8259_PORT_CONFIG);	/* ICW2: 8259A-1 IR0-7 mapped to 0x30-0x37 */
	outb(ICW3_MASTER, MASTER_8259_PORT_CONFIG);	/* 8259A-1 (the master) has a slave on IR2 */
	outb(ICW4, MASTER_8259_PORT_CONFIG);	/* master expects normal EOI */

	outb(ICW1, SLAVE_8259_PORT);	/* ICW1: select 8259A-2 init */
	outb(ICW2_SLAVE, SLAVE_8259_PORT_CONFIG);	/* ICW2: 8259A-2 IR0-7 mapped to 0x38-0x3f */
	outb(ICW3_SLAVE, SLAVE_8259_PORT_CONFIG);	/* 8259A-2 n master's IR2 */
	outb(ICW4, SLAVE_8259_PORT_CONFIG);

	// udelay(100);		/* wait for 8259A to initialize */
	// unsigned long long i;
	// for (i = 0; i < 1000000; i++);

	// outb(cached_21, MASTER_8259_PORT_CONFIG);	/* restore master IRQ mask */
	// outb(cached_A1, SLAVE_8259_PORT_CONFIG);	/* restore slave IRQ mask */
	// spin_unlock_irqrestore(&i8259A_lock, flags);
}

/* Function: enable_irq
 * Inputs: irq_num
 * Return Value: none
 * Description: enable the specific IRQ
 */
void enable_irq(uint32_t irq_num) {
	if (irq_num > 15 || irq_num < 0)
		return;
	unsigned int mask = ~(1 << irq_num);
	// unsigned long flags;

	// spin_lock_irqsave(&i8259A_lock, flags);
	cached_irq_mask &= mask;
	if (irq_num & 8)
		outb(cached_A1, SLAVE_8259_PORT_CONFIG);
	else
		outb(cached_21, MASTER_8259_PORT_CONFIG);
	// spin_unlock_irqrestore(&i8259A_lock, flags);
}

/* Function: disable_irq
 * Inputs: irq_num
 * Return Value: none
 * Description: disable specific IRQ 
 */
void disable_irq(uint32_t irq_num) {
	if (irq_num > 15 || irq_num < 0)
		return;
	unsigned int mask = 1 << irq_num;
	// unsigned long flags;

	// spin_lock_irqsave(&i8259A_lock, flags);
	cached_irq_mask |= mask;
	if (irq_num & 8)
		outb(cached_A1, SLAVE_8259_PORT_CONFIG);
	else
		outb(cached_21, MASTER_8259_PORT_CONFIG);
	// spin_unlock_irqrestore(&i8259A_lock, flags);
}

/* Function: send_eoi;
 * Inputs: irq_num
 * Return Value: none
 * Description: send eoi signal for that specific IRQ
 */
void send_eoi(uint32_t irq_num) {
    if(irq_num >= 8){                        //if on a slave port, send command to slave + master
      outb(EOI + 2, MASTER_8259_PORT);          
      outb(EOI | (irq_num - 8), SLAVE_8259_PORT);
    }
    else
      outb(EOI | irq_num, MASTER_8259_PORT);    //else if its master, just send to master only
}
