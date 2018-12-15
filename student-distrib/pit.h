#ifndef PIT_H 
 #define PIT_H 
 
 
 #include "lib.h" 
 #include "types.h" 
 #include "i8259.h" 
 
 
 /* ports for pit */ 
 #define PIT_CH0	0x40 
 #define PIT_CMD	0x43 
 
 
 /* PIT init command word */ 
 #define PIT_MODE		0x36 
 #define PIT_FREQ		1193182 
 #define PIT_COUNT 		100 
 
 
 
 
 /* irq num for PIT */ 
 #define PIT_MASK 		0xFF 
 #define PIT_SHIFT	0x8 
 
 
 void pit_init(); 
 void pit_handler(); 
 
 
 #endif
 





