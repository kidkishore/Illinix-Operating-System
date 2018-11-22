#ifndef _RTC_H
#define _RTC_H

#include "types.h" 


//this initializes the RTC 
extern void init_rtc();

//this handles RTC interrupts 
extern void handle_rtc_interrupt();


extern int32_t rtc_close(int32_t fd); 

extern int32_t rtc_open(const uint8_t* filename); 

extern int32_t rtc_write (int32_t fd, const void* buf, int32_t nbytes);

extern int32_t rtc_read(int32_t fd, void* buf, int32_t nbytes);

#endif












