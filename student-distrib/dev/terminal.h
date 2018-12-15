#ifndef _TERMINAL_DRIVER
#define _TERMINAL_DRIVER

#include "../types.h"
#include "../x86_desc.h"
#include "../lib.h"
#include "../pcb.h"
#include "../debug.h"


#define MAX_BUFFER_SIZE 1025
#define ENTR_PRESSED (input == '\n')
#define ENTER_PRESSED (input == 0x1c)
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
#define REQUESTED_SWITCH_TO_TTY ((input <= 61) && (input >= 59) && alt_pressed)
#define TTY_N_FROM_INPUT (input - 59)


extern int32_t terminal_read (int32_t fd, void* buf, int32_t nbytes);
extern int32_t terminal_write (int32_t fd, const void* buf, int32_t nbytes);
extern int32_t terminal_open (const uint8_t* filename);
extern int32_t terminal_close (int32_t fd);
extern int32_t null_func();


#endif /* TERMINAL_DRIVER */
