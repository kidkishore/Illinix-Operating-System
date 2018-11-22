#include "terminal.h"


char buffer[128];
int32_t tail = -1;

int enter_status = 0;
#define MAX_BUFFER_SIZE 128

#define BKSP_PRESSED (input == 8)
#define CLS_PRESSED (input == 25)
#define ENTR_PRESSED (input == '\n')

/* Function: terminal_read
 * Inputs: int32_t fd, void* buf, int32_t nbytes
 * Return Value: bytes copied
 * Description: write stuff to given buffer, for given length, clears buffer
 */
int32_t terminal_read (int32_t fd, void* buf, int32_t nbytes) {
	while (!enter_status);
	enter_status = 0;
	int32_t i;
	char* dest = (char *)buf;
	if (tail == -1)
		return 0;
	int actual_copy = nbytes < (tail + 1) ? nbytes : (tail + 1);
	for (i = 0; i <= actual_copy - 1; i++) {
		dest[i] = buffer[i];
	}
	dest[i] = '\0';
	for (i = actual_copy; i <= tail; i++) {
		buffer[i - actual_copy] = buffer[i];
	}
	tail -= actual_copy;
	return actual_copy;
}

/* Function: terminal_write
 * Inputs: int32_t fd, const void* buf, int32_t nbytes
 * Return Value: byte written
 * Description: append content to buffer, handle fn keys
 */
int32_t terminal_write (int32_t fd, const void* buf, int32_t nbytes) {
	int i;
	for (i = 1; i <= nbytes; i++) {
		char input = ((char *)buf)[i-1];
		if (BKSP_PRESSED) {
		if (tail > -1 && fd != 1) {
		  tail --;
		  bksp();
		}
		  return 0;
	  } else if (CLS_PRESSED && fd != 1) {
		clear();
		return 0;
	  } else if (ENTR_PRESSED && fd != 1) {
		enter_status = 1;
		putc(input);
		return 1;
	  } else {
		if (tail < MAX_BUFFER_SIZE && fd != 1)
			buffer[++tail] = input;
		putc(input);
	  }
	}
	return nbytes;
}

/* Function: terminal_open
 * Inputs: const uint8_t* filename
 * Return Value: none
 * Description: open terminal device, clear screen
 */
int32_t terminal_open (const uint8_t* filename) {
	clear();
	return 0;
}

/* Function: terminal_close
 * Inputs: int32_t fd
 * Return Value: none
 * Description: closes terminal dev
 */
int32_t terminal_close (int32_t fd) {
	tail = -1;
	return 0;
}


int32_t null_func() {
	return -1; 
}
