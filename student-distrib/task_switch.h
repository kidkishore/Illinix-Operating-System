#ifndef _TASKSWITCH_H
#define _TASKSWITCH_H

#include "types.h"
#include "filesys.h"
#include "multiboot.h"
#include "dev/terminal.h"
#include "system.h"
#include "lib.h"

#define MAX_TTY 3
#define TTY_UNOPENED 255
uint8_t volatile active_tty;
uint8_t volatile tty_top_pid[MAX_TTY];
uint8_t volatile root_shell_pid[MAX_TTY];
uint8_t volatile next_one_is_root_shell;


void switch_to_tty(uint8_t tty);
#endif
