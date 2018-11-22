#ifndef _TERMINAL_DRIVER
#define _TERMINAL_DRIVER

#include "../types.h"
#include "../x86_desc.h"
#include "../lib.h"
#include "../debug.h"

extern int32_t terminal_read (int32_t fd, void* buf, int32_t nbytes);
extern int32_t terminal_write (int32_t fd, const void* buf, int32_t nbytes);
extern int32_t terminal_open (const uint8_t* filename);
extern int32_t terminal_close (int32_t fd);
extern int32_t null_func(); 


#endif /* TERMINAL_DRIVER */
