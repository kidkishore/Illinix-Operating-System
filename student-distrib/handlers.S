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

.global pit_interrupt

pit_interrupt:
  pusha
  call pit_handler
  popa
  iret

.global sys_call 
sys_call:
	# push %eax 
	pushl %ebp
	pushl %edi
	pushl %esi
	pushl %edx
	pushl %ecx
	pushl %ebx
	
	# Check if EAX is out of bounds -- if so, jump to
	cmp $1, %eax
	jl not_valid		#check to see if vaid system call number
	cmp $10, %eax
	jg not_valid		#check to see if vaid system call number
	call *sys_call_jumptable(, %eax, 4)
	
	jmp finish
not_valid:
	movl $-1,%eax
finish:
	popl %ebx
	popl %ecx
	popl %edx 
	popl %esi
	popl %edi 
	popl %ebp
  sti
	# pop %eax
    # overwritten by return value
	iret


sys_call_jumptable: 
	.long 0x0, halt, execute, read, write, open, close, getargs, vidmap, set_handler, sigreturn

	.end

	#, getargs, vidmap, set_handler, sigreturn 
