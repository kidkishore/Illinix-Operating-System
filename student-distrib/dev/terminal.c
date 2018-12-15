#include "terminal.h"


#define BKSP_PRESSED (input == 8)
char terminal_buffer[3][MAX_BUFFER_SIZE];
int32_t tail[3];

int enter_status = 0;


/* Function: terminal_read
 * Inputs: int32_t fd, void* buf, int32_t nbytes
 * Return Value: bytes copied
 * Description: write stuff to given buffer, for given length, clears buffer
 */
int32_t terminal_read (int32_t fd, void* buf, int32_t nbytes) {
	uint8_t target = active_tty;

	while (!enter_status);
	enter_status = 0;
	int32_t i;
	char* dest = (char *)buf;
	if (tail[target] == -1)
		return 0;
	int actual_copy = nbytes < (tail[target] + 1) ? nbytes : (tail[target] + 1);
	for (i = 0; i <= actual_copy - 1; i++) {
		dest[i] = terminal_buffer[target][i];
	}
	dest[i] = '\0';
	for (i = actual_copy; i <= tail[target]; i++) {
		terminal_buffer[target][i - actual_copy] = terminal_buffer[target][i];
	}
	tail[target] -= actual_copy;
	return actual_copy;
}

/* Function: terminal_write
 * Inputs: int32_t fd, const void* buf, int32_t nbytes
 * Return Value: byte written
 * Description: append content to buffer, handle fn keys
 */
int32_t terminal_write (int32_t fd, const void* buf, int32_t nbytes) {
	cli();
	uint8_t target = active_tty;
	/*
	pcb_t* curr_pcb = get_pcb();
	uint8_t tty = curr_pcb->tty;
	*/
  // printf("shoould print !!! %d %d\n", active_tty, curr_pcb->tty);
	int i;
	char input;
	for (i = 1; i <= nbytes; i++) {
		input = ((char *)buf)[i-1];
		if (BKSP_PRESSED && fd != 1) {
			if (tail[target] > -1 && fd != 1) {
			  tail[target] --;
			  bksp();
			}
		  return 0;
	  } /*else if (CLS_PRESSED && fd != 1) {
			clear();
			return 0;
	  }*/ else if (ENTR_PRESSED && fd != 1) {
			enter_status = 1;
			putc(input);
			return 1;
	  } else {
			if (tail[target] < MAX_BUFFER_SIZE && fd != 1)
				terminal_buffer[target][++tail[target]] = input;
			putc(input);
		}
	}
	sti();
	return nbytes;
}

/* Function: terminal_open
 * Inputs: const uint8_t* filename
 * Return Value: none
 * Description: open terminal device, clear screen
 */
int32_t terminal_open (const uint8_t* filename) {
	clear();
	int32_t i;

	for(i = 0; i < MAX_TTY; i++){ //length of number of terminals
		tail[i] = -1;
	}

	return 0;
}

/* Function: terminal_close
 * Inputs: int32_t fd
 * Return Value: none
 * Description: closes terminal dev
 */
int32_t terminal_close (int32_t fd) {
	tail[active_tty] = -1;
	return 0;
}


int32_t null_func() {
	return -1; 
}
