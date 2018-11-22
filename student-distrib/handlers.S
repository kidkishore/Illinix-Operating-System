.global kb_interrupt

kb_interrupt:
  pusha
  call kb_interrupt_do
  popa
  iret
  
.global rtc_interrupt 

rtc_interrupt:
  pusha
  call rtc_interrupt_handler
  popa
  iret

.global sys_call 
sys_call:
	# push %eax 
	push %ebp
	push %edi
	push %esi
	push %edx
	push %ecx
	push %ebx
	push %esp
	call *sys_call_jumptable(, %eax, 4)
	add $4, %esp
	pop %ebx
	pop %ecx
	pop %edx 
	pop %esi
	pop %edi 
	pop %ebp 
	# pop %eax
    # overwritten by return value	
	iret 


sys_call_jumptable: 
	.long 0, halt, execute, read, write, open, close

	#, getargs, vidmap, set_handler, sigreturn 
