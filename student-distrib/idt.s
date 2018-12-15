	.file	"idt.c"
	.section	.debug_abbrev,"",@progbits
.Ldebug_abbrev0:
	.section	.debug_info,"",@progbits
.Ldebug_info0:
	.section	.debug_line,"",@progbits
.Ldebug_line0:
	.text
.Ltext0:
.globl load_idt
	.type	load_idt, @function
load_idt:
.LFB5:
	.file 1 "idt.c"
	.loc 1 17 0
	pushl	%ebp
.LCFI0:
	movl	%esp, %ebp
.LCFI1:
	subl	$16, %esp
.LCFI2:
	.loc 1 20 0
	movl	$0, -4(%ebp)
	.loc 1 22 0
	jmp	.L15
.L3:
	.loc 1 24 0
	cmpl	$15, -4(%ebp)
	jne	.L4
	.loc 1 25 0
	addl	$1, -4(%ebp)
	.loc 1 26 0
	jmp	.L2
.L4:
	.loc 1 31 0
	movl	-4(%ebp), %eax
	movw	$16, idt+2(,%eax,8)
	.loc 1 32 0
	movl	-4(%ebp), %edx
	movzbl	idt+5(,%edx,8), %eax
	andl	$-97, %eax
	movb	%al, idt+5(,%edx,8)
	.loc 1 33 0
	movl	-4(%ebp), %edx
	movzbl	idt+5(,%edx,8), %eax
	orl	$-128, %eax
	movb	%al, idt+5(,%edx,8)
	.loc 1 34 0
	movl	-4(%ebp), %edx
	movzbl	idt+5(,%edx,8), %eax
	orl	$8, %eax
	movb	%al, idt+5(,%edx,8)
	.loc 1 36 0
	movl	-4(%ebp), %eax
	movb	$0, idt+4(,%eax,8)
	.loc 1 37 0
	movl	-4(%ebp), %edx
	movzbl	idt+5(,%edx,8), %eax
	andl	$-2, %eax
	movb	%al, idt+5(,%edx,8)
	.loc 1 38 0
	movl	-4(%ebp), %edx
	movzbl	idt+5(,%edx,8), %eax
	orl	$2, %eax
	movb	%al, idt+5(,%edx,8)
	.loc 1 39 0
	movl	-4(%ebp), %edx
	movzbl	idt+5(,%edx,8), %eax
	orl	$4, %eax
	movb	%al, idt+5(,%edx,8)
	.loc 1 40 0
	movl	-4(%ebp), %edx
	movzbl	idt+5(,%edx,8), %eax
	andl	$-17, %eax
	movb	%al, idt+5(,%edx,8)
	.loc 1 45 0
	cmpl	$31, -4(%ebp)
	jg	.L6
	.loc 1 47 0
	movl	-4(%ebp), %eax
	movzbl	idt+5(,%eax,8), %edx
	orl	$1, %edx
	movb	%dl, idt+5(,%eax,8)
.L6:
	.loc 1 51 0
	cmpl	$33, -4(%ebp)
	je	.L8
	cmpl	$40, -4(%ebp)
	jne	.L10
.L8:
	.loc 1 54 0
	movl	-4(%ebp), %eax
	movw	$16, idt+2(,%eax,8)
	.loc 1 55 0
	movl	-4(%ebp), %edx
	movzbl	idt+5(,%edx,8), %eax
	orl	$-128, %eax
	movb	%al, idt+5(,%edx,8)
	.loc 1 56 0
	movl	-4(%ebp), %edx
	movzbl	idt+5(,%edx,8), %eax
	andl	$-97, %eax
	movb	%al, idt+5(,%edx,8)
	.loc 1 57 0
	movl	-4(%ebp), %edx
	movzbl	idt+5(,%edx,8), %eax
	andl	$-2, %eax
	movb	%al, idt+5(,%edx,8)
	.loc 1 58 0
	movl	-4(%ebp), %edx
	movzbl	idt+5(,%edx,8), %eax
	orl	$2, %eax
	movb	%al, idt+5(,%edx,8)
	.loc 1 59 0
	movl	-4(%ebp), %edx
	movzbl	idt+5(,%edx,8), %eax
	orl	$4, %eax
	movb	%al, idt+5(,%edx,8)
	.loc 1 60 0
	movl	-4(%ebp), %edx
	movzbl	idt+5(,%edx,8), %eax
	andl	$-17, %eax
	movb	%al, idt+5(,%edx,8)
	.loc 1 61 0
	movl	-4(%ebp), %edx
	movzbl	idt+5(,%edx,8), %eax
	orl	$8, %eax
	movb	%al, idt+5(,%edx,8)
	.loc 1 51 0
	jmp	.L11
.L10:
	.loc 1 62 0
	cmpl	$128, -4(%ebp)
	jne	.L11
	.loc 1 64 0
	movl	-4(%ebp), %edx
	movzbl	idt+5(,%edx,8), %eax
	orl	$96, %eax
	movb	%al, idt+5(,%edx,8)
	.loc 1 65 0
	movl	-4(%ebp), %edx
	movzbl	idt+5(,%edx,8), %eax
	orl	$1, %eax
	movb	%al, idt+5(,%edx,8)
	.loc 1 66 0
	movl	-4(%ebp), %edx
	movzbl	idt+5(,%edx,8), %eax
	orl	$2, %eax
	movb	%al, idt+5(,%edx,8)
	.loc 1 67 0
	movl	-4(%ebp), %edx
	movzbl	idt+5(,%edx,8), %eax
	orl	$4, %eax
	movb	%al, idt+5(,%edx,8)
	.loc 1 68 0
	movl	-4(%ebp), %edx
	movzbl	idt+5(,%edx,8), %eax
	orl	$8, %eax
	movb	%al, idt+5(,%edx,8)
.L11:
	.loc 1 70 0
	addl	$1, -4(%ebp)
.L2:
.L15:
	.loc 1 22 0
	cmpl	$255, -4(%ebp)
	jle	.L3
	.loc 1 73 0
	movl	$divide_zero_exception, %eax
	movw	$0, %ax
	shrl	$16, %eax
	movw	%ax, idt+6
	movl	$divide_zero_exception, %eax
	movw	%ax, idt
	.loc 1 74 0
	movl	$single_step_exception, %eax
	movw	$0, %ax
	shrl	$16, %eax
	movw	%ax, idt+14
	movl	$single_step_exception, %eax
	movw	%ax, idt+8
	.loc 1 75 0
	movl	$nmi_exception, %eax
	movw	$0, %ax
	shrl	$16, %eax
	movw	%ax, idt+22
	movl	$nmi_exception, %eax
	movw	%ax, idt+16
	.loc 1 76 0
	movl	$breakpoint_exception, %eax
	movw	$0, %ax
	shrl	$16, %eax
	movw	%ax, idt+30
	movl	$breakpoint_exception, %eax
	movw	%ax, idt+24
	.loc 1 77 0
	movl	$overflow_exception, %eax
	movw	$0, %ax
	shrl	$16, %eax
	movw	%ax, idt+38
	movl	$overflow_exception, %eax
	movw	%ax, idt+32
	.loc 1 78 0
	movl	$bounds_exception, %eax
	movw	$0, %ax
	shrl	$16, %eax
	movw	%ax, idt+46
	movl	$bounds_exception, %eax
	movw	%ax, idt+40
	.loc 1 79 0
	movl	$invalid_opcode_exception, %eax
	movw	$0, %ax
	shrl	$16, %eax
	movw	%ax, idt+54
	movl	$invalid_opcode_exception, %eax
	movw	%ax, idt+48
	.loc 1 80 0
	movl	$coprocessor_exception, %eax
	movw	$0, %ax
	shrl	$16, %eax
	movw	%ax, idt+62
	movl	$coprocessor_exception, %eax
	movw	%ax, idt+56
	.loc 1 81 0
	movl	$double_fault_exception, %eax
	movw	$0, %ax
	shrl	$16, %eax
	movw	%ax, idt+70
	movl	$double_fault_exception, %eax
	movw	%ax, idt+64
	.loc 1 82 0
	movl	$segment_overrun_exception, %eax
	movw	$0, %ax
	shrl	$16, %eax
	movw	%ax, idt+78
	movl	$segment_overrun_exception, %eax
	movw	%ax, idt+72
	.loc 1 83 0
	movl	$invalid_tss_exception, %eax
	movw	$0, %ax
	shrl	$16, %eax
	movw	%ax, idt+86
	movl	$invalid_tss_exception, %eax
	movw	%ax, idt+80
	.loc 1 84 0
	movl	$segment_not_present_exception, %eax
	movw	$0, %ax
	shrl	$16, %eax
	movw	%ax, idt+94
	movl	$segment_not_present_exception, %eax
	movw	%ax, idt+88
	.loc 1 85 0
	movl	$stack_fault_exception, %eax
	movw	$0, %ax
	shrl	$16, %eax
	movw	%ax, idt+102
	movl	$stack_fault_exception, %eax
	movw	%ax, idt+96
	.loc 1 86 0
	movl	$general_protection_exception, %eax
	movw	$0, %ax
	shrl	$16, %eax
	movw	%ax, idt+110
	movl	$general_protection_exception, %eax
	movw	%ax, idt+104
	.loc 1 87 0
	movl	$page_fault_exception, %eax
	movw	$0, %ax
	shrl	$16, %eax
	movw	%ax, idt+118
	movl	$page_fault_exception, %eax
	movw	%ax, idt+112
	.loc 1 88 0
	movl	$math_fault_exception, %eax
	movw	$0, %ax
	shrl	$16, %eax
	movw	%ax, idt+134
	movl	$math_fault_exception, %eax
	movw	%ax, idt+128
	.loc 1 89 0
	movl	$alignment_check_exception, %eax
	movw	$0, %ax
	shrl	$16, %eax
	movw	%ax, idt+142
	movl	$alignment_check_exception, %eax
	movw	%ax, idt+136
	.loc 1 90 0
	movl	$machine_check_exception, %eax
	movw	$0, %ax
	shrl	$16, %eax
	movw	%ax, idt+150
	movl	$machine_check_exception, %eax
	movw	%ax, idt+144
	.loc 1 91 0
	movl	$simd_exception, %eax
	movw	$0, %ax
	shrl	$16, %eax
	movw	%ax, idt+158
	movl	$simd_exception, %eax
	movw	%ax, idt+152
	.loc 1 92 0
	movl	$kb_interrupt, %eax
	movw	$0, %ax
	shrl	$16, %eax
	movw	%ax, idt+270
	movl	$kb_interrupt, %eax
	movw	%ax, idt+264
	.loc 1 93 0
	movl	$rtc_interrupt, %eax
	movw	$0, %ax
	shrl	$16, %eax
	movw	%ax, idt+326
	movl	$rtc_interrupt, %eax
	movw	%ax, idt+320
	.loc 1 94 0
	movl	$sys_call, %eax
	movw	$0, %ax
	shrl	$16, %eax
	movw	%ax, idt+1030
	movl	$sys_call, %eax
	movw	%ax, idt+1024
	.loc 1 95 0
	leave
	ret
.LFE5:
	.size	load_idt, .-load_idt
.globl caps_enabled
	.bss
	.align 4
	.type	caps_enabled, @object
	.size	caps_enabled, 4
caps_enabled:
	.zero	4
.globl shift_pressed
	.align 4
	.type	shift_pressed, @object
	.size	shift_pressed, 4
shift_pressed:
	.zero	4
.globl ctrl_pressed
	.align 4
	.type	ctrl_pressed, @object
	.size	ctrl_pressed, 4
ctrl_pressed:
	.zero	4
.globl alt_pressed
	.align 4
	.type	alt_pressed, @object
	.size	alt_pressed, 4
alt_pressed:
	.zero	4
.globl meta_pressed
	.align 4
	.type	meta_pressed, @object
	.size	meta_pressed, 4
meta_pressed:
	.zero	4
.globl enter_pressed
	.align 4
	.type	enter_pressed, @object
	.size	enter_pressed, 4
enter_pressed:
	.zero	4
.globl char_map
	.data
	.align 32
	.type	char_map, @object
	.size	char_map, 57
char_map:
	.byte	63
	.byte	63
	.byte	49
	.byte	50
	.byte	51
	.byte	52
	.byte	53
	.byte	54
	.byte	55
	.byte	56
	.byte	57
	.byte	48
	.byte	45
	.byte	61
	.byte	63
	.byte	32
	.byte	113
	.byte	119
	.byte	101
	.byte	114
	.byte	116
	.byte	121
	.byte	117
	.byte	105
	.byte	111
	.byte	112
	.byte	91
	.byte	93
	.byte	10
	.byte	63
	.byte	97
	.byte	115
	.byte	100
	.byte	102
	.byte	103
	.byte	104
	.byte	106
	.byte	107
	.byte	108
	.byte	59
	.byte	39
	.byte	96
	.byte	63
	.byte	92
	.byte	122
	.byte	120
	.byte	99
	.byte	118
	.byte	98
	.byte	110
	.byte	109
	.byte	44
	.byte	46
	.byte	47
	.byte	63
	.byte	63
	.byte	32
.globl char_map_caps
	.align 32
	.type	char_map_caps, @object
	.size	char_map_caps, 57
char_map_caps:
	.byte	63
	.byte	63
	.byte	33
	.byte	64
	.byte	35
	.byte	36
	.byte	37
	.byte	94
	.byte	38
	.byte	42
	.byte	40
	.byte	41
	.byte	95
	.byte	43
	.byte	63
	.byte	32
	.byte	81
	.byte	87
	.byte	69
	.byte	82
	.byte	84
	.byte	89
	.byte	85
	.byte	73
	.byte	79
	.byte	80
	.byte	123
	.byte	125
	.byte	10
	.byte	63
	.byte	65
	.byte	83
	.byte	68
	.byte	70
	.byte	71
	.byte	72
	.byte	74
	.byte	75
	.byte	76
	.byte	58
	.byte	34
	.byte	126
	.byte	63
	.byte	124
	.byte	90
	.byte	88
	.byte	67
	.byte	86
	.byte	66
	.byte	78
	.byte	77
	.byte	44
	.byte	46
	.byte	63
	.byte	63
	.byte	63
	.byte	32
.globl x
	.bss
	.align 4
	.type	x, @object
	.size	x, 4
x:
	.zero	4
.globl y
	.align 4
	.type	y, @object
	.size	y, 4
y:
	.zero	4
	.text
.globl kb_interrupt_do
	.type	kb_interrupt_do, @function
kb_interrupt_do:
.LFB6:
	.loc 1 144 0
	pushl	%ebp
.LCFI3:
	movl	%esp, %ebp
.LCFI4:
	subl	$40, %esp
.LCFI5:
	.loc 1 146 0
	movl	$100, (%esp)
	call	inb
	movb	%al, -2(%ebp)
	.loc 1 147 0
	movl	$96, (%esp)
	call	inb
	movb	%al, -1(%ebp)
	.loc 1 151 0
	cmpb	$-128, -1(%ebp)
	jbe	.L17
	cmpb	$-40, -1(%ebp)
	ja	.L17
	.loc 1 152 0
	cmpb	$-99, -1(%ebp)
	jne	.L20
	.loc 1 153 0
	movl	$0, ctrl_pressed
.L20:
	.loc 1 154 0
	cmpb	$-86, -1(%ebp)
	je	.L22
	cmpb	$-74, -1(%ebp)
	jne	.L24
.L22:
	.loc 1 155 0
	movl	$0, shift_pressed
.L24:
	.loc 1 156 0
	cmpb	$-72, -1(%ebp)
	jne	.L27
	.loc 1 157 0
	movl	$0, alt_pressed
	.loc 1 158 0
	jmp	.L27
.L17:
	.loc 1 160 0
	cmpb	$42, -1(%ebp)
	je	.L28
	cmpb	$54, -1(%ebp)
	jne	.L30
.L28:
	.loc 1 161 0
	movl	$1, shift_pressed
	.loc 1 162 0
	jmp	.L27
.L30:
	.loc 1 164 0
	cmpb	$56, -1(%ebp)
	je	.L31
	cmpb	$54, -1(%ebp)
	jne	.L33
.L31:
	.loc 1 165 0
	movl	$1, alt_pressed
	.loc 1 166 0
	jmp	.L27
.L33:
	.loc 1 168 0
	cmpb	$29, -1(%ebp)
	je	.L34
	cmpb	$-32, -1(%ebp)
	jne	.L36
.L34:
	.loc 1 169 0
	movl	$1, ctrl_pressed
	.loc 1 170 0
	jmp	.L27
.L36:
	.loc 1 172 0
	cmpb	$28, -1(%ebp)
	jne	.L37
	.loc 1 173 0
	movl	$1, enter_pressed
	.loc 1 174 0
	movb	$10, -3(%ebp)
	.loc 1 175 0
	movl	$1, 8(%esp)
	leal	-3(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	$0, (%esp)
	call	terminal_write
	.loc 1 176 0
	jmp	.L27
.L37:
	.loc 1 178 0
	cmpb	$58, -1(%ebp)
	jne	.L39
	.loc 1 179 0
	movl	caps_enabled, %eax
	movl	$1, %edx
	movl	%edx, %ecx
	subl	%eax, %ecx
	movl	%ecx, %eax
	movl	%eax, caps_enabled
	.loc 1 180 0
	jmp	.L27
.L39:
	.loc 1 183 0
	cmpb	$14, -1(%ebp)
	jne	.L41
	.loc 1 184 0
	movb	$8, -3(%ebp)
	.loc 1 185 0
	movl	$1, 8(%esp)
	leal	-3(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	$0, (%esp)
	call	terminal_write
	.loc 1 186 0
	jmp	.L27
.L41:
	.loc 1 189 0
	movl	alt_pressed, %eax
	testl	%eax, %eax
	jne	.L43
	movl	ctrl_pressed, %eax
	testl	%eax, %eax
	jne	.L43
	movl	meta_pressed, %eax
	testl	%eax, %eax
	je	.L46
.L43:
	.loc 1 190 0
	movl	ctrl_pressed, %eax
	testl	%eax, %eax
	je	.L27
	cmpb	$38, -1(%ebp)
	jne	.L27
	.loc 1 191 0
	movb	$25, -3(%ebp)
	.loc 1 192 0
	movl	$1, 8(%esp)
	leal	-3(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	$0, (%esp)
	call	terminal_write
	.loc 1 194 0
	jmp	.L27
.L46:
	.loc 1 196 0
	movzbl	-1(%ebp), %eax
	movzbl	char_map(%eax), %eax
	cmpb	$122, %al
	jg	.L50
	movzbl	-1(%ebp), %eax
	movzbl	char_map(%eax), %eax
	cmpb	$96, %al
	jle	.L50
	.loc 1 197 0
	movl	shift_pressed, %edx
	movl	caps_enabled, %eax
	cmpl	%eax, %edx
	je	.L53
	movzbl	-1(%ebp), %eax
	movzbl	char_map_caps(%eax), %eax
	movb	%al, -18(%ebp)
	jmp	.L55
.L53:
	movzbl	-1(%ebp), %eax
	movzbl	char_map(%eax), %eax
	movb	%al, -18(%ebp)
.L55:
	movzbl	-18(%ebp), %eax
	movb	%al, -3(%ebp)
	.loc 1 196 0
	jmp	.L56
.L50:
	.loc 1 199 0
	movl	shift_pressed, %eax
	testl	%eax, %eax
	je	.L57
	movzbl	-1(%ebp), %eax
	movzbl	char_map_caps(%eax), %eax
	movb	%al, -17(%ebp)
	jmp	.L59
.L57:
	movzbl	-1(%ebp), %eax
	movzbl	char_map(%eax), %eax
	movb	%al, -17(%ebp)
.L59:
	movzbl	-17(%ebp), %ecx
	movb	%cl, -3(%ebp)
.L56:
	.loc 1 201 0
	movl	$1, 8(%esp)
	leal	-3(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	$0, (%esp)
	call	terminal_write
.L27:
	.loc 1 205 0
	movl	$1, (%esp)
	call	send_eoi
	.loc 1 206 0
	leave
	ret
.LFE6:
	.size	kb_interrupt_do, .-kb_interrupt_do
	.type	inb, @function
inb:
.LFB2:
	.file 2 "lib.h"
	.loc 2 36 0
	pushl	%ebp
.LCFI6:
	movl	%esp, %ebp
.LCFI7:
	subl	$16, %esp
.LCFI8:
	.loc 2 38 0
	movl	8(%ebp), %edx
#APP
	             
            xorl %eax, %eax         
            inb  (%dx), %al     
            
#NO_APP
	movl	%eax, -4(%ebp)
	.loc 2 46 0
	movl	-4(%ebp), %eax
	.loc 2 47 0
	leave
	ret
.LFE2:
	.size	inb, .-inb
	.section	.rodata
.LC0:
	.string	"divide by zero exception.\n"
	.text
.globl divide_zero_exception
	.type	divide_zero_exception, @function
divide_zero_exception:
.LFB7:
	.loc 1 217 0
	pushl	%ebp
.LCFI9:
	movl	%esp, %ebp
.LCFI10:
	subl	$8, %esp
.LCFI11:
	.loc 1 218 0
#APP
	cli
	.loc 1 219 0
#NO_APP
	movl	$.LC0, (%esp)
	call	printf
	.loc 1 221 0
	leave
	ret
.LFE7:
	.size	divide_zero_exception, .-divide_zero_exception
	.section	.rodata
.LC1:
	.string	"Single step exception.\n"
	.text
.globl single_step_exception
	.type	single_step_exception, @function
single_step_exception:
.LFB8:
	.loc 1 229 0
	pushl	%ebp
.LCFI12:
	movl	%esp, %ebp
.LCFI13:
	subl	$8, %esp
.LCFI14:
	.loc 1 230 0
#APP
	cli
	.loc 1 231 0
#NO_APP
	movl	$.LC1, (%esp)
	call	printf
	.loc 1 233 0
	leave
	ret
.LFE8:
	.size	single_step_exception, .-single_step_exception
	.section	.rodata
.LC2:
	.string	"NMI exception.\n"
	.text
.globl nmi_exception
	.type	nmi_exception, @function
nmi_exception:
.LFB9:
	.loc 1 240 0
	pushl	%ebp
.LCFI15:
	movl	%esp, %ebp
.LCFI16:
	subl	$8, %esp
.LCFI17:
	.loc 1 241 0
#APP
	cli
	.loc 1 242 0
#NO_APP
	movl	$.LC2, (%esp)
	call	printf
	.loc 1 244 0
	leave
	ret
.LFE9:
	.size	nmi_exception, .-nmi_exception
	.section	.rodata
.LC3:
	.string	"Breakpoint exception.\n"
	.text
.globl breakpoint_exception
	.type	breakpoint_exception, @function
breakpoint_exception:
.LFB10:
	.loc 1 253 0
	pushl	%ebp
.LCFI18:
	movl	%esp, %ebp
.LCFI19:
	subl	$8, %esp
.LCFI20:
	.loc 1 254 0
#APP
	cli
	.loc 1 255 0
#NO_APP
	movl	$.LC3, (%esp)
	call	printf
	.loc 1 257 0
	leave
	ret
.LFE10:
	.size	breakpoint_exception, .-breakpoint_exception
	.section	.rodata
.LC4:
	.string	"Overflow exception.\n"
	.text
.globl overflow_exception
	.type	overflow_exception, @function
overflow_exception:
.LFB11:
	.loc 1 265 0
	pushl	%ebp
.LCFI21:
	movl	%esp, %ebp
.LCFI22:
	subl	$8, %esp
.LCFI23:
	.loc 1 266 0
#APP
	cli
	.loc 1 267 0
#NO_APP
	movl	$.LC4, (%esp)
	call	printf
	.loc 1 269 0
	leave
	ret
.LFE11:
	.size	overflow_exception, .-overflow_exception
	.section	.rodata
.LC5:
	.string	"Bounds exception.\n"
	.text
.globl bounds_exception
	.type	bounds_exception, @function
bounds_exception:
.LFB12:
	.loc 1 277 0
	pushl	%ebp
.LCFI24:
	movl	%esp, %ebp
.LCFI25:
	subl	$8, %esp
.LCFI26:
	.loc 1 278 0
#APP
	cli
	.loc 1 279 0
#NO_APP
	movl	$.LC5, (%esp)
	call	printf
	.loc 1 281 0
	leave
	ret
.LFE12:
	.size	bounds_exception, .-bounds_exception
	.section	.rodata
.LC6:
	.string	"Invalid opcode exception.\n"
	.text
.globl invalid_opcode_exception
	.type	invalid_opcode_exception, @function
invalid_opcode_exception:
.LFB13:
	.loc 1 289 0
	pushl	%ebp
.LCFI27:
	movl	%esp, %ebp
.LCFI28:
	subl	$8, %esp
.LCFI29:
	.loc 1 290 0
#APP
	cli
	.loc 1 291 0
#NO_APP
	movl	$.LC6, (%esp)
	call	printf
	.loc 1 293 0
	leave
	ret
.LFE13:
	.size	invalid_opcode_exception, .-invalid_opcode_exception
	.section	.rodata
.LC7:
	.string	"Coprocessor exception.\n"
	.text
.globl coprocessor_exception
	.type	coprocessor_exception, @function
coprocessor_exception:
.LFB14:
	.loc 1 300 0
	pushl	%ebp
.LCFI30:
	movl	%esp, %ebp
.LCFI31:
	subl	$8, %esp
.LCFI32:
	.loc 1 301 0
#APP
	cli
	.loc 1 302 0
#NO_APP
	movl	$.LC7, (%esp)
	call	printf
	.loc 1 304 0
	leave
	ret
.LFE14:
	.size	coprocessor_exception, .-coprocessor_exception
	.section	.rodata
.LC8:
	.string	"Double fault exception.\n"
	.text
.globl double_fault_exception
	.type	double_fault_exception, @function
double_fault_exception:
.LFB15:
	.loc 1 311 0
	pushl	%ebp
.LCFI33:
	movl	%esp, %ebp
.LCFI34:
	subl	$8, %esp
.LCFI35:
	.loc 1 312 0
#APP
	cli
	.loc 1 313 0
#NO_APP
	movl	$.LC8, (%esp)
	call	printf
	.loc 1 315 0
	leave
	ret
.LFE15:
	.size	double_fault_exception, .-double_fault_exception
	.section	.rodata
.LC9:
	.string	"Segment overrun exception.\n"
	.text
.globl segment_overrun_exception
	.type	segment_overrun_exception, @function
segment_overrun_exception:
.LFB16:
	.loc 1 322 0
	pushl	%ebp
.LCFI36:
	movl	%esp, %ebp
.LCFI37:
	subl	$8, %esp
.LCFI38:
	.loc 1 323 0
#APP
	cli
	.loc 1 324 0
#NO_APP
	movl	$.LC9, (%esp)
	call	printf
	.loc 1 326 0
	leave
	ret
.LFE16:
	.size	segment_overrun_exception, .-segment_overrun_exception
	.section	.rodata
.LC10:
	.string	"Invalid tss exception.\n"
	.text
.globl invalid_tss_exception
	.type	invalid_tss_exception, @function
invalid_tss_exception:
.LFB17:
	.loc 1 333 0
	pushl	%ebp
.LCFI39:
	movl	%esp, %ebp
.LCFI40:
	subl	$8, %esp
.LCFI41:
	.loc 1 334 0
#APP
	cli
	.loc 1 335 0
#NO_APP
	movl	$.LC10, (%esp)
	call	printf
	.loc 1 337 0
	leave
	ret
.LFE17:
	.size	invalid_tss_exception, .-invalid_tss_exception
	.section	.rodata
	.align 4
.LC11:
	.string	"Segment not present exception.\n"
	.text
.globl segment_not_present_exception
	.type	segment_not_present_exception, @function
segment_not_present_exception:
.LFB18:
	.loc 1 344 0
	pushl	%ebp
.LCFI42:
	movl	%esp, %ebp
.LCFI43:
	subl	$8, %esp
.LCFI44:
	.loc 1 345 0
#APP
	cli
	.loc 1 346 0
#NO_APP
	movl	$.LC11, (%esp)
	call	printf
	.loc 1 348 0
	leave
	ret
.LFE18:
	.size	segment_not_present_exception, .-segment_not_present_exception
	.section	.rodata
.LC12:
	.string	"Stack fault exception.\n"
	.text
.globl stack_fault_exception
	.type	stack_fault_exception, @function
stack_fault_exception:
.LFB19:
	.loc 1 356 0
	pushl	%ebp
.LCFI45:
	movl	%esp, %ebp
.LCFI46:
	subl	$8, %esp
.LCFI47:
	.loc 1 357 0
#APP
	cli
	.loc 1 358 0
#NO_APP
	movl	$.LC12, (%esp)
	call	printf
	.loc 1 360 0
	leave
	ret
.LFE19:
	.size	stack_fault_exception, .-stack_fault_exception
	.section	.rodata
	.align 4
.LC13:
	.string	"General protection exception.\n"
	.text
.globl general_protection_exception
	.type	general_protection_exception, @function
general_protection_exception:
.LFB20:
	.loc 1 368 0
	pushl	%ebp
.LCFI48:
	movl	%esp, %ebp
.LCFI49:
	subl	$8, %esp
.LCFI50:
	.loc 1 369 0
#APP
	cli
	.loc 1 370 0
#NO_APP
	movl	$.LC13, (%esp)
	call	printf
	.loc 1 372 0
	leave
	ret
.LFE20:
	.size	general_protection_exception, .-general_protection_exception
	.section	.rodata
.LC14:
	.string	"Page fault exception.\n"
	.text
.globl page_fault_exception
	.type	page_fault_exception, @function
page_fault_exception:
.LFB21:
	.loc 1 379 0
	pushl	%ebp
.LCFI51:
	movl	%esp, %ebp
.LCFI52:
	subl	$8, %esp
.LCFI53:
	.loc 1 380 0
#APP
	cli
	.loc 1 381 0
#NO_APP
	movl	$.LC14, (%esp)
	call	printf
	.loc 1 383 0
	leave
	ret
.LFE21:
	.size	page_fault_exception, .-page_fault_exception
	.section	.rodata
.LC15:
	.string	"Math fault exception.\n"
	.text
.globl math_fault_exception
	.type	math_fault_exception, @function
math_fault_exception:
.LFB22:
	.loc 1 390 0
	pushl	%ebp
.LCFI54:
	movl	%esp, %ebp
.LCFI55:
	subl	$8, %esp
.LCFI56:
	.loc 1 391 0
#APP
	cli
	.loc 1 392 0
#NO_APP
	movl	$.LC15, (%esp)
	call	printf
	.loc 1 394 0
	leave
	ret
.LFE22:
	.size	math_fault_exception, .-math_fault_exception
	.section	.rodata
.LC16:
	.string	"Alignment check exception.\n"
	.text
.globl alignment_check_exception
	.type	alignment_check_exception, @function
alignment_check_exception:
.LFB23:
	.loc 1 402 0
	pushl	%ebp
.LCFI57:
	movl	%esp, %ebp
.LCFI58:
	subl	$8, %esp
.LCFI59:
	.loc 1 403 0
#APP
	cli
	.loc 1 404 0
#NO_APP
	movl	$.LC16, (%esp)
	call	printf
	.loc 1 406 0
	leave
	ret
.LFE23:
	.size	alignment_check_exception, .-alignment_check_exception
	.section	.rodata
.LC17:
	.string	"Machine check exception.\n"
	.text
.globl machine_check_exception
	.type	machine_check_exception, @function
machine_check_exception:
.LFB24:
	.loc 1 414 0
	pushl	%ebp
.LCFI60:
	movl	%esp, %ebp
.LCFI61:
	subl	$8, %esp
.LCFI62:
	.loc 1 415 0
#APP
	cli
	.loc 1 416 0
#NO_APP
	movl	$.LC17, (%esp)
	call	printf
	.loc 1 418 0
	leave
	ret
.LFE24:
	.size	machine_check_exception, .-machine_check_exception
	.section	.rodata
.LC18:
	.string	"Simd exception.\n"
	.text
.globl simd_exception
	.type	simd_exception, @function
simd_exception:
.LFB25:
	.loc 1 426 0
	pushl	%ebp
.LCFI63:
	movl	%esp, %ebp
.LCFI64:
	subl	$8, %esp
.LCFI65:
	.loc 1 427 0
#APP
	cli
	.loc 1 428 0
#NO_APP
	movl	$.LC18, (%esp)
	call	printf
	.loc 1 430 0
	leave
	ret
.LFE25:
	.size	simd_exception, .-simd_exception
	.section	.debug_frame,"",@progbits
.Lframe0:
	.long	.LECIE0-.LSCIE0
.LSCIE0:
	.long	0xffffffff
	.byte	0x1
	.string	""
	.uleb128 0x1
	.sleb128 -4
	.byte	0x8
	.byte	0xc
	.uleb128 0x4
	.uleb128 0x4
	.byte	0x88
	.uleb128 0x1
	.align 4
.LECIE0:
.LSFDE0:
	.long	.LEFDE0-.LASFDE0
.LASFDE0:
	.long	.Lframe0
	.long	.LFB5
	.long	.LFE5-.LFB5
	.byte	0x4
	.long	.LCFI0-.LFB5
	.byte	0xe
	.uleb128 0x8
	.byte	0x85
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI1-.LCFI0
	.byte	0xd
	.uleb128 0x5
	.align 4
.LEFDE0:
.LSFDE2:
	.long	.LEFDE2-.LASFDE2
.LASFDE2:
	.long	.Lframe0
	.long	.LFB6
	.long	.LFE6-.LFB6
	.byte	0x4
	.long	.LCFI3-.LFB6
	.byte	0xe
	.uleb128 0x8
	.byte	0x85
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI4-.LCFI3
	.byte	0xd
	.uleb128 0x5
	.align 4
.LEFDE2:
.LSFDE4:
	.long	.LEFDE4-.LASFDE4
.LASFDE4:
	.long	.Lframe0
	.long	.LFB2
	.long	.LFE2-.LFB2
	.byte	0x4
	.long	.LCFI6-.LFB2
	.byte	0xe
	.uleb128 0x8
	.byte	0x85
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI7-.LCFI6
	.byte	0xd
	.uleb128 0x5
	.align 4
.LEFDE4:
.LSFDE6:
	.long	.LEFDE6-.LASFDE6
.LASFDE6:
	.long	.Lframe0
	.long	.LFB7
	.long	.LFE7-.LFB7
	.byte	0x4
	.long	.LCFI9-.LFB7
	.byte	0xe
	.uleb128 0x8
	.byte	0x85
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI10-.LCFI9
	.byte	0xd
	.uleb128 0x5
	.align 4
.LEFDE6:
.LSFDE8:
	.long	.LEFDE8-.LASFDE8
.LASFDE8:
	.long	.Lframe0
	.long	.LFB8
	.long	.LFE8-.LFB8
	.byte	0x4
	.long	.LCFI12-.LFB8
	.byte	0xe
	.uleb128 0x8
	.byte	0x85
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI13-.LCFI12
	.byte	0xd
	.uleb128 0x5
	.align 4
.LEFDE8:
.LSFDE10:
	.long	.LEFDE10-.LASFDE10
.LASFDE10:
	.long	.Lframe0
	.long	.LFB9
	.long	.LFE9-.LFB9
	.byte	0x4
	.long	.LCFI15-.LFB9
	.byte	0xe
	.uleb128 0x8
	.byte	0x85
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI16-.LCFI15
	.byte	0xd
	.uleb128 0x5
	.align 4
.LEFDE10:
.LSFDE12:
	.long	.LEFDE12-.LASFDE12
.LASFDE12:
	.long	.Lframe0
	.long	.LFB10
	.long	.LFE10-.LFB10
	.byte	0x4
	.long	.LCFI18-.LFB10
	.byte	0xe
	.uleb128 0x8
	.byte	0x85
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI19-.LCFI18
	.byte	0xd
	.uleb128 0x5
	.align 4
.LEFDE12:
.LSFDE14:
	.long	.LEFDE14-.LASFDE14
.LASFDE14:
	.long	.Lframe0
	.long	.LFB11
	.long	.LFE11-.LFB11
	.byte	0x4
	.long	.LCFI21-.LFB11
	.byte	0xe
	.uleb128 0x8
	.byte	0x85
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI22-.LCFI21
	.byte	0xd
	.uleb128 0x5
	.align 4
.LEFDE14:
.LSFDE16:
	.long	.LEFDE16-.LASFDE16
.LASFDE16:
	.long	.Lframe0
	.long	.LFB12
	.long	.LFE12-.LFB12
	.byte	0x4
	.long	.LCFI24-.LFB12
	.byte	0xe
	.uleb128 0x8
	.byte	0x85
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI25-.LCFI24
	.byte	0xd
	.uleb128 0x5
	.align 4
.LEFDE16:
.LSFDE18:
	.long	.LEFDE18-.LASFDE18
.LASFDE18:
	.long	.Lframe0
	.long	.LFB13
	.long	.LFE13-.LFB13
	.byte	0x4
	.long	.LCFI27-.LFB13
	.byte	0xe
	.uleb128 0x8
	.byte	0x85
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI28-.LCFI27
	.byte	0xd
	.uleb128 0x5
	.align 4
.LEFDE18:
.LSFDE20:
	.long	.LEFDE20-.LASFDE20
.LASFDE20:
	.long	.Lframe0
	.long	.LFB14
	.long	.LFE14-.LFB14
	.byte	0x4
	.long	.LCFI30-.LFB14
	.byte	0xe
	.uleb128 0x8
	.byte	0x85
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI31-.LCFI30
	.byte	0xd
	.uleb128 0x5
	.align 4
.LEFDE20:
.LSFDE22:
	.long	.LEFDE22-.LASFDE22
.LASFDE22:
	.long	.Lframe0
	.long	.LFB15
	.long	.LFE15-.LFB15
	.byte	0x4
	.long	.LCFI33-.LFB15
	.byte	0xe
	.uleb128 0x8
	.byte	0x85
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI34-.LCFI33
	.byte	0xd
	.uleb128 0x5
	.align 4
.LEFDE22:
.LSFDE24:
	.long	.LEFDE24-.LASFDE24
.LASFDE24:
	.long	.Lframe0
	.long	.LFB16
	.long	.LFE16-.LFB16
	.byte	0x4
	.long	.LCFI36-.LFB16
	.byte	0xe
	.uleb128 0x8
	.byte	0x85
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI37-.LCFI36
	.byte	0xd
	.uleb128 0x5
	.align 4
.LEFDE24:
.LSFDE26:
	.long	.LEFDE26-.LASFDE26
.LASFDE26:
	.long	.Lframe0
	.long	.LFB17
	.long	.LFE17-.LFB17
	.byte	0x4
	.long	.LCFI39-.LFB17
	.byte	0xe
	.uleb128 0x8
	.byte	0x85
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI40-.LCFI39
	.byte	0xd
	.uleb128 0x5
	.align 4
.LEFDE26:
.LSFDE28:
	.long	.LEFDE28-.LASFDE28
.LASFDE28:
	.long	.Lframe0
	.long	.LFB18
	.long	.LFE18-.LFB18
	.byte	0x4
	.long	.LCFI42-.LFB18
	.byte	0xe
	.uleb128 0x8
	.byte	0x85
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI43-.LCFI42
	.byte	0xd
	.uleb128 0x5
	.align 4
.LEFDE28:
.LSFDE30:
	.long	.LEFDE30-.LASFDE30
.LASFDE30:
	.long	.Lframe0
	.long	.LFB19
	.long	.LFE19-.LFB19
	.byte	0x4
	.long	.LCFI45-.LFB19
	.byte	0xe
	.uleb128 0x8
	.byte	0x85
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI46-.LCFI45
	.byte	0xd
	.uleb128 0x5
	.align 4
.LEFDE30:
.LSFDE32:
	.long	.LEFDE32-.LASFDE32
.LASFDE32:
	.long	.Lframe0
	.long	.LFB20
	.long	.LFE20-.LFB20
	.byte	0x4
	.long	.LCFI48-.LFB20
	.byte	0xe
	.uleb128 0x8
	.byte	0x85
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI49-.LCFI48
	.byte	0xd
	.uleb128 0x5
	.align 4
.LEFDE32:
.LSFDE34:
	.long	.LEFDE34-.LASFDE34
.LASFDE34:
	.long	.Lframe0
	.long	.LFB21
	.long	.LFE21-.LFB21
	.byte	0x4
	.long	.LCFI51-.LFB21
	.byte	0xe
	.uleb128 0x8
	.byte	0x85
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI52-.LCFI51
	.byte	0xd
	.uleb128 0x5
	.align 4
.LEFDE34:
.LSFDE36:
	.long	.LEFDE36-.LASFDE36
.LASFDE36:
	.long	.Lframe0
	.long	.LFB22
	.long	.LFE22-.LFB22
	.byte	0x4
	.long	.LCFI54-.LFB22
	.byte	0xe
	.uleb128 0x8
	.byte	0x85
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI55-.LCFI54
	.byte	0xd
	.uleb128 0x5
	.align 4
.LEFDE36:
.LSFDE38:
	.long	.LEFDE38-.LASFDE38
.LASFDE38:
	.long	.Lframe0
	.long	.LFB23
	.long	.LFE23-.LFB23
	.byte	0x4
	.long	.LCFI57-.LFB23
	.byte	0xe
	.uleb128 0x8
	.byte	0x85
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI58-.LCFI57
	.byte	0xd
	.uleb128 0x5
	.align 4
.LEFDE38:
.LSFDE40:
	.long	.LEFDE40-.LASFDE40
.LASFDE40:
	.long	.Lframe0
	.long	.LFB24
	.long	.LFE24-.LFB24
	.byte	0x4
	.long	.LCFI60-.LFB24
	.byte	0xe
	.uleb128 0x8
	.byte	0x85
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI61-.LCFI60
	.byte	0xd
	.uleb128 0x5
	.align 4
.LEFDE40:
.LSFDE42:
	.long	.LEFDE42-.LASFDE42
.LASFDE42:
	.long	.Lframe0
	.long	.LFB25
	.long	.LFE25-.LFB25
	.byte	0x4
	.long	.LCFI63-.LFB25
	.byte	0xe
	.uleb128 0x8
	.byte	0x85
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI64-.LCFI63
	.byte	0xd
	.uleb128 0x5
	.align 4
.LEFDE42:
	.file 3 "types.h"
	.file 4 "x86_desc.h"
	.text
.Letext0:
	.section	.debug_loc,"",@progbits
.Ldebug_loc0:
.LLST0:
	.long	.LFB5-.Ltext0
	.long	.LCFI0-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	.LCFI0-.Ltext0
	.long	.LCFI1-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 8
	.long	.LCFI1-.Ltext0
	.long	.LFE5-.Ltext0
	.value	0x2
	.byte	0x75
	.sleb128 8
	.long	0x0
	.long	0x0
.LLST1:
	.long	.LFB6-.Ltext0
	.long	.LCFI3-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	.LCFI3-.Ltext0
	.long	.LCFI4-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 8
	.long	.LCFI4-.Ltext0
	.long	.LFE6-.Ltext0
	.value	0x2
	.byte	0x75
	.sleb128 8
	.long	0x0
	.long	0x0
.LLST2:
	.long	.LFB2-.Ltext0
	.long	.LCFI6-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	.LCFI6-.Ltext0
	.long	.LCFI7-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 8
	.long	.LCFI7-.Ltext0
	.long	.LFE2-.Ltext0
	.value	0x2
	.byte	0x75
	.sleb128 8
	.long	0x0
	.long	0x0
.LLST3:
	.long	.LFB7-.Ltext0
	.long	.LCFI9-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	.LCFI9-.Ltext0
	.long	.LCFI10-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 8
	.long	.LCFI10-.Ltext0
	.long	.LFE7-.Ltext0
	.value	0x2
	.byte	0x75
	.sleb128 8
	.long	0x0
	.long	0x0
.LLST4:
	.long	.LFB8-.Ltext0
	.long	.LCFI12-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	.LCFI12-.Ltext0
	.long	.LCFI13-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 8
	.long	.LCFI13-.Ltext0
	.long	.LFE8-.Ltext0
	.value	0x2
	.byte	0x75
	.sleb128 8
	.long	0x0
	.long	0x0
.LLST5:
	.long	.LFB9-.Ltext0
	.long	.LCFI15-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	.LCFI15-.Ltext0
	.long	.LCFI16-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 8
	.long	.LCFI16-.Ltext0
	.long	.LFE9-.Ltext0
	.value	0x2
	.byte	0x75
	.sleb128 8
	.long	0x0
	.long	0x0
.LLST6:
	.long	.LFB10-.Ltext0
	.long	.LCFI18-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	.LCFI18-.Ltext0
	.long	.LCFI19-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 8
	.long	.LCFI19-.Ltext0
	.long	.LFE10-.Ltext0
	.value	0x2
	.byte	0x75
	.sleb128 8
	.long	0x0
	.long	0x0
.LLST7:
	.long	.LFB11-.Ltext0
	.long	.LCFI21-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	.LCFI21-.Ltext0
	.long	.LCFI22-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 8
	.long	.LCFI22-.Ltext0
	.long	.LFE11-.Ltext0
	.value	0x2
	.byte	0x75
	.sleb128 8
	.long	0x0
	.long	0x0
.LLST8:
	.long	.LFB12-.Ltext0
	.long	.LCFI24-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	.LCFI24-.Ltext0
	.long	.LCFI25-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 8
	.long	.LCFI25-.Ltext0
	.long	.LFE12-.Ltext0
	.value	0x2
	.byte	0x75
	.sleb128 8
	.long	0x0
	.long	0x0
.LLST9:
	.long	.LFB13-.Ltext0
	.long	.LCFI27-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	.LCFI27-.Ltext0
	.long	.LCFI28-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 8
	.long	.LCFI28-.Ltext0
	.long	.LFE13-.Ltext0
	.value	0x2
	.byte	0x75
	.sleb128 8
	.long	0x0
	.long	0x0
.LLST10:
	.long	.LFB14-.Ltext0
	.long	.LCFI30-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	.LCFI30-.Ltext0
	.long	.LCFI31-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 8
	.long	.LCFI31-.Ltext0
	.long	.LFE14-.Ltext0
	.value	0x2
	.byte	0x75
	.sleb128 8
	.long	0x0
	.long	0x0
.LLST11:
	.long	.LFB15-.Ltext0
	.long	.LCFI33-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	.LCFI33-.Ltext0
	.long	.LCFI34-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 8
	.long	.LCFI34-.Ltext0
	.long	.LFE15-.Ltext0
	.value	0x2
	.byte	0x75
	.sleb128 8
	.long	0x0
	.long	0x0
.LLST12:
	.long	.LFB16-.Ltext0
	.long	.LCFI36-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	.LCFI36-.Ltext0
	.long	.LCFI37-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 8
	.long	.LCFI37-.Ltext0
	.long	.LFE16-.Ltext0
	.value	0x2
	.byte	0x75
	.sleb128 8
	.long	0x0
	.long	0x0
.LLST13:
	.long	.LFB17-.Ltext0
	.long	.LCFI39-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	.LCFI39-.Ltext0
	.long	.LCFI40-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 8
	.long	.LCFI40-.Ltext0
	.long	.LFE17-.Ltext0
	.value	0x2
	.byte	0x75
	.sleb128 8
	.long	0x0
	.long	0x0
.LLST14:
	.long	.LFB18-.Ltext0
	.long	.LCFI42-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	.LCFI42-.Ltext0
	.long	.LCFI43-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 8
	.long	.LCFI43-.Ltext0
	.long	.LFE18-.Ltext0
	.value	0x2
	.byte	0x75
	.sleb128 8
	.long	0x0
	.long	0x0
.LLST15:
	.long	.LFB19-.Ltext0
	.long	.LCFI45-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	.LCFI45-.Ltext0
	.long	.LCFI46-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 8
	.long	.LCFI46-.Ltext0
	.long	.LFE19-.Ltext0
	.value	0x2
	.byte	0x75
	.sleb128 8
	.long	0x0
	.long	0x0
.LLST16:
	.long	.LFB20-.Ltext0
	.long	.LCFI48-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	.LCFI48-.Ltext0
	.long	.LCFI49-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 8
	.long	.LCFI49-.Ltext0
	.long	.LFE20-.Ltext0
	.value	0x2
	.byte	0x75
	.sleb128 8
	.long	0x0
	.long	0x0
.LLST17:
	.long	.LFB21-.Ltext0
	.long	.LCFI51-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	.LCFI51-.Ltext0
	.long	.LCFI52-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 8
	.long	.LCFI52-.Ltext0
	.long	.LFE21-.Ltext0
	.value	0x2
	.byte	0x75
	.sleb128 8
	.long	0x0
	.long	0x0
.LLST18:
	.long	.LFB22-.Ltext0
	.long	.LCFI54-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	.LCFI54-.Ltext0
	.long	.LCFI55-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 8
	.long	.LCFI55-.Ltext0
	.long	.LFE22-.Ltext0
	.value	0x2
	.byte	0x75
	.sleb128 8
	.long	0x0
	.long	0x0
.LLST19:
	.long	.LFB23-.Ltext0
	.long	.LCFI57-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	.LCFI57-.Ltext0
	.long	.LCFI58-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 8
	.long	.LCFI58-.Ltext0
	.long	.LFE23-.Ltext0
	.value	0x2
	.byte	0x75
	.sleb128 8
	.long	0x0
	.long	0x0
.LLST20:
	.long	.LFB24-.Ltext0
	.long	.LCFI60-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	.LCFI60-.Ltext0
	.long	.LCFI61-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 8
	.long	.LCFI61-.Ltext0
	.long	.LFE24-.Ltext0
	.value	0x2
	.byte	0x75
	.sleb128 8
	.long	0x0
	.long	0x0
.LLST21:
	.long	.LFB25-.Ltext0
	.long	.LCFI63-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	.LCFI63-.Ltext0
	.long	.LCFI64-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 8
	.long	.LCFI64-.Ltext0
	.long	.LFE25-.Ltext0
	.value	0x2
	.byte	0x75
	.sleb128 8
	.long	0x0
	.long	0x0
	.section	.debug_info
	.long	0x723
	.value	0x2
	.long	.Ldebug_abbrev0
	.byte	0x4
	.uleb128 0x1
	.long	.Ldebug_line0
	.long	.Letext0
	.long	.Ltext0
	.string	"GNU C 4.1.2 20070626 (Red Hat 4.1.2-13)"
	.byte	0x1
	.string	"idt.c"
	.string	"/workdir/mp3_group_44/student-distrib"
	.uleb128 0x2
	.string	"int32_t"
	.byte	0x3
	.byte	0xf
	.long	0x7c
	.uleb128 0x3
	.string	"int"
	.byte	0x4
	.byte	0x5
	.uleb128 0x2
	.string	"uint32_t"
	.byte	0x3
	.byte	0x10
	.long	0x93
	.uleb128 0x4
	.long	.LASF0
	.byte	0x4
	.byte	0x7
	.uleb128 0x3
	.string	"short int"
	.byte	0x2
	.byte	0x5
	.uleb128 0x2
	.string	"uint16_t"
	.byte	0x3
	.byte	0x13
	.long	0xb7
	.uleb128 0x3
	.string	"short unsigned int"
	.byte	0x2
	.byte	0x7
	.uleb128 0x3
	.string	"char"
	.byte	0x1
	.byte	0x6
	.uleb128 0x2
	.string	"uint8_t"
	.byte	0x3
	.byte	0x16
	.long	0xe4
	.uleb128 0x3
	.string	"unsigned char"
	.byte	0x1
	.byte	0x8
	.uleb128 0x5
	.long	0x105
	.long	0x83
	.uleb128 0x6
	.long	0x105
	.byte	0x1
	.byte	0x0
	.uleb128 0x4
	.long	.LASF0
	.byte	0x4
	.byte	0x7
	.uleb128 0x7
	.long	0x202
	.byte	0x8
	.byte	0x4
	.byte	0x97
	.uleb128 0x8
	.string	"offset_15_00"
	.byte	0x4
	.byte	0x98
	.long	0xa7
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0x8
	.string	"seg_selector"
	.byte	0x4
	.byte	0x99
	.long	0xa7
	.byte	0x2
	.byte	0x23
	.uleb128 0x2
	.uleb128 0x8
	.string	"reserved4"
	.byte	0x4
	.byte	0x9a
	.long	0xd5
	.byte	0x2
	.byte	0x23
	.uleb128 0x4
	.uleb128 0x9
	.string	"reserved3"
	.byte	0x4
	.byte	0x9b
	.long	0x83
	.byte	0x4
	.byte	0x1
	.byte	0x17
	.byte	0x2
	.byte	0x23
	.uleb128 0x4
	.uleb128 0x9
	.string	"reserved2"
	.byte	0x4
	.byte	0x9c
	.long	0x83
	.byte	0x4
	.byte	0x1
	.byte	0x16
	.byte	0x2
	.byte	0x23
	.uleb128 0x4
	.uleb128 0x9
	.string	"reserved1"
	.byte	0x4
	.byte	0x9d
	.long	0x83
	.byte	0x4
	.byte	0x1
	.byte	0x15
	.byte	0x2
	.byte	0x23
	.uleb128 0x4
	.uleb128 0x9
	.string	"size"
	.byte	0x4
	.byte	0x9e
	.long	0x83
	.byte	0x4
	.byte	0x1
	.byte	0x14
	.byte	0x2
	.byte	0x23
	.uleb128 0x4
	.uleb128 0x9
	.string	"reserved0"
	.byte	0x4
	.byte	0x9f
	.long	0x83
	.byte	0x4
	.byte	0x1
	.byte	0x13
	.byte	0x2
	.byte	0x23
	.uleb128 0x4
	.uleb128 0x9
	.string	"dpl"
	.byte	0x4
	.byte	0xa0
	.long	0x83
	.byte	0x4
	.byte	0x2
	.byte	0x11
	.byte	0x2
	.byte	0x23
	.uleb128 0x4
	.uleb128 0x9
	.string	"present"
	.byte	0x4
	.byte	0xa1
	.long	0x83
	.byte	0x4
	.byte	0x1
	.byte	0x10
	.byte	0x2
	.byte	0x23
	.uleb128 0x4
	.uleb128 0x8
	.string	"offset_31_16"
	.byte	0x4
	.byte	0xa2
	.long	0xa7
	.byte	0x2
	.byte	0x23
	.uleb128 0x6
	.byte	0x0
	.uleb128 0xa
	.long	0x21f
	.long	.LASF1
	.byte	0x8
	.byte	0x4
	.byte	0x95
	.uleb128 0xb
	.string	"val"
	.byte	0x4
	.byte	0x96
	.long	0xf5
	.uleb128 0xc
	.long	0x10c
	.byte	0x0
	.uleb128 0xd
	.long	.LASF1
	.byte	0x4
	.byte	0xa4
	.long	0x202
	.uleb128 0xe
	.long	0x254
	.byte	0x1
	.string	"load_idt"
	.byte	0x1
	.byte	0x11
	.long	.LFB5
	.long	.LFE5
	.long	.LLST0
	.uleb128 0xf
	.string	"i"
	.byte	0x1
	.byte	0x13
	.long	0x7c
	.byte	0x2
	.byte	0x91
	.sleb128 -12
	.byte	0x0
	.uleb128 0x10
	.long	0x2e4
	.byte	0x1
	.string	"kb_interrupt_do"
	.byte	0x1
	.byte	0x90
	.byte	0x1
	.long	.LFB6
	.long	.LFE6
	.long	.LLST1
	.uleb128 0x11
	.string	"irq"
	.byte	0x1
	.byte	0x90
	.long	0x7c
	.byte	0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x11
	.string	"dev_id"
	.byte	0x1
	.byte	0x90
	.long	0x2e4
	.byte	0x2
	.byte	0x91
	.sleb128 4
	.uleb128 0xf
	.string	"status"
	.byte	0x1
	.byte	0x91
	.long	0xe4
	.byte	0x2
	.byte	0x91
	.sleb128 -10
	.uleb128 0xf
	.string	"input"
	.byte	0x1
	.byte	0x91
	.long	0xe4
	.byte	0x2
	.byte	0x91
	.sleb128 -9
	.uleb128 0xf
	.string	"character"
	.byte	0x1
	.byte	0x95
	.long	0xcd
	.byte	0x2
	.byte	0x91
	.sleb128 -11
	.uleb128 0x12
	.string	"kb_handle_done"
	.byte	0x1
	.byte	0xcc
	.long	.L27
	.byte	0x0
	.uleb128 0x13
	.byte	0x4
	.uleb128 0x14
	.long	0x31f
	.string	"inb"
	.byte	0x2
	.byte	0x24
	.long	0x83
	.long	.LFB2
	.long	.LFE2
	.long	.LLST2
	.uleb128 0x11
	.string	"port"
	.byte	0x2
	.byte	0x24
	.long	0x7c
	.byte	0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0xf
	.string	"val"
	.byte	0x2
	.byte	0x25
	.long	0x83
	.byte	0x2
	.byte	0x91
	.sleb128 -12
	.byte	0x0
	.uleb128 0x15
	.byte	0x1
	.string	"divide_zero_exception"
	.byte	0x1
	.byte	0xd9
	.long	.LFB7
	.long	.LFE7
	.long	.LLST3
	.uleb128 0x15
	.byte	0x1
	.string	"single_step_exception"
	.byte	0x1
	.byte	0xe5
	.long	.LFB8
	.long	.LFE8
	.long	.LLST4
	.uleb128 0x15
	.byte	0x1
	.string	"nmi_exception"
	.byte	0x1
	.byte	0xf0
	.long	.LFB9
	.long	.LFE9
	.long	.LLST5
	.uleb128 0x15
	.byte	0x1
	.string	"breakpoint_exception"
	.byte	0x1
	.byte	0xfd
	.long	.LFB10
	.long	.LFE10
	.long	.LLST6
	.uleb128 0x16
	.byte	0x1
	.string	"overflow_exception"
	.byte	0x1
	.value	0x109
	.long	.LFB11
	.long	.LFE11
	.long	.LLST7
	.uleb128 0x16
	.byte	0x1
	.string	"bounds_exception"
	.byte	0x1
	.value	0x115
	.long	.LFB12
	.long	.LFE12
	.long	.LLST8
	.uleb128 0x16
	.byte	0x1
	.string	"invalid_opcode_exception"
	.byte	0x1
	.value	0x121
	.long	.LFB13
	.long	.LFE13
	.long	.LLST9
	.uleb128 0x16
	.byte	0x1
	.string	"coprocessor_exception"
	.byte	0x1
	.value	0x12c
	.long	.LFB14
	.long	.LFE14
	.long	.LLST10
	.uleb128 0x16
	.byte	0x1
	.string	"double_fault_exception"
	.byte	0x1
	.value	0x137
	.long	.LFB15
	.long	.LFE15
	.long	.LLST11
	.uleb128 0x16
	.byte	0x1
	.string	"segment_overrun_exception"
	.byte	0x1
	.value	0x142
	.long	.LFB16
	.long	.LFE16
	.long	.LLST12
	.uleb128 0x16
	.byte	0x1
	.string	"invalid_tss_exception"
	.byte	0x1
	.value	0x14d
	.long	.LFB17
	.long	.LFE17
	.long	.LLST13
	.uleb128 0x16
	.byte	0x1
	.string	"segment_not_present_exception"
	.byte	0x1
	.value	0x158
	.long	.LFB18
	.long	.LFE18
	.long	.LLST14
	.uleb128 0x16
	.byte	0x1
	.string	"stack_fault_exception"
	.byte	0x1
	.value	0x164
	.long	.LFB19
	.long	.LFE19
	.long	.LLST15
	.uleb128 0x16
	.byte	0x1
	.string	"general_protection_exception"
	.byte	0x1
	.value	0x170
	.long	.LFB20
	.long	.LFE20
	.long	.LLST16
	.uleb128 0x16
	.byte	0x1
	.string	"page_fault_exception"
	.byte	0x1
	.value	0x17b
	.long	.LFB21
	.long	.LFE21
	.long	.LLST17
	.uleb128 0x16
	.byte	0x1
	.string	"math_fault_exception"
	.byte	0x1
	.value	0x186
	.long	.LFB22
	.long	.LFE22
	.long	.LLST18
	.uleb128 0x16
	.byte	0x1
	.string	"alignment_check_exception"
	.byte	0x1
	.value	0x192
	.long	.LFB23
	.long	.LFE23
	.long	.LLST19
	.uleb128 0x16
	.byte	0x1
	.string	"machine_check_exception"
	.byte	0x1
	.value	0x19e
	.long	.LFB24
	.long	.LFE24
	.long	.LLST20
	.uleb128 0x16
	.byte	0x1
	.string	"simd_exception"
	.byte	0x1
	.value	0x1aa
	.long	.LFB25
	.long	.LFE25
	.long	.LLST21
	.uleb128 0x5
	.long	0x613
	.long	0x21f
	.uleb128 0x6
	.long	0x105
	.byte	0xff
	.byte	0x0
	.uleb128 0x17
	.string	"idt"
	.byte	0x4
	.byte	0xa7
	.long	0x603
	.byte	0x1
	.byte	0x1
	.uleb128 0x18
	.string	"caps_enabled"
	.byte	0x1
	.byte	0x62
	.long	0x6d
	.byte	0x1
	.byte	0x5
	.byte	0x3
	.long	caps_enabled
	.uleb128 0x18
	.string	"shift_pressed"
	.byte	0x1
	.byte	0x63
	.long	0x6d
	.byte	0x1
	.byte	0x5
	.byte	0x3
	.long	shift_pressed
	.uleb128 0x18
	.string	"ctrl_pressed"
	.byte	0x1
	.byte	0x64
	.long	0x6d
	.byte	0x1
	.byte	0x5
	.byte	0x3
	.long	ctrl_pressed
	.uleb128 0x18
	.string	"alt_pressed"
	.byte	0x1
	.byte	0x65
	.long	0x6d
	.byte	0x1
	.byte	0x5
	.byte	0x3
	.long	alt_pressed
	.uleb128 0x18
	.string	"meta_pressed"
	.byte	0x1
	.byte	0x66
	.long	0x6d
	.byte	0x1
	.byte	0x5
	.byte	0x3
	.long	meta_pressed
	.uleb128 0x18
	.string	"enter_pressed"
	.byte	0x1
	.byte	0x67
	.long	0x6d
	.byte	0x1
	.byte	0x5
	.byte	0x3
	.long	enter_pressed
	.uleb128 0x5
	.long	0x6d3
	.long	0xcd
	.uleb128 0x6
	.long	0x105
	.byte	0x38
	.byte	0x0
	.uleb128 0x18
	.string	"char_map"
	.byte	0x1
	.byte	0x69
	.long	0x6c3
	.byte	0x1
	.byte	0x5
	.byte	0x3
	.long	char_map
	.uleb128 0x18
	.string	"char_map_caps"
	.byte	0x1
	.byte	0x6f
	.long	0x6c3
	.byte	0x1
	.byte	0x5
	.byte	0x3
	.long	char_map_caps
	.uleb128 0x18
	.string	"x"
	.byte	0x1
	.byte	0x89
	.long	0x6d
	.byte	0x1
	.byte	0x5
	.byte	0x3
	.long	x
	.uleb128 0x18
	.string	"y"
	.byte	0x1
	.byte	0x89
	.long	0x6d
	.byte	0x1
	.byte	0x5
	.byte	0x3
	.long	y
	.byte	0x0
	.section	.debug_abbrev
	.uleb128 0x1
	.uleb128 0x11
	.byte	0x1
	.uleb128 0x10
	.uleb128 0x6
	.uleb128 0x12
	.uleb128 0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x25
	.uleb128 0x8
	.uleb128 0x13
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x1b
	.uleb128 0x8
	.byte	0x0
	.byte	0x0
	.uleb128 0x2
	.uleb128 0x16
	.byte	0x0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0x3
	.uleb128 0x24
	.byte	0x0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.byte	0x0
	.byte	0x0
	.uleb128 0x4
	.uleb128 0x24
	.byte	0x0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.byte	0x0
	.byte	0x0
	.uleb128 0x5
	.uleb128 0x1
	.byte	0x1
	.uleb128 0x1
	.uleb128 0x13
	.uleb128 0x49
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0x6
	.uleb128 0x21
	.byte	0x0
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2f
	.uleb128 0xb
	.byte	0x0
	.byte	0x0
	.uleb128 0x7
	.uleb128 0x13
	.byte	0x1
	.uleb128 0x1
	.uleb128 0x13
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.byte	0x0
	.byte	0x0
	.uleb128 0x8
	.uleb128 0xd
	.byte	0x0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0xa
	.byte	0x0
	.byte	0x0
	.uleb128 0x9
	.uleb128 0xd
	.byte	0x0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0xd
	.uleb128 0xb
	.uleb128 0xc
	.uleb128 0xb
	.uleb128 0x38
	.uleb128 0xa
	.byte	0x0
	.byte	0x0
	.uleb128 0xa
	.uleb128 0x17
	.byte	0x1
	.uleb128 0x1
	.uleb128 0x13
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.byte	0x0
	.byte	0x0
	.uleb128 0xb
	.uleb128 0xd
	.byte	0x0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0xc
	.uleb128 0xd
	.byte	0x0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0xd
	.uleb128 0x16
	.byte	0x0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0xe
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x1
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0xc
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x1
	.uleb128 0x40
	.uleb128 0x6
	.byte	0x0
	.byte	0x0
	.uleb128 0xf
	.uleb128 0x34
	.byte	0x0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0xa
	.byte	0x0
	.byte	0x0
	.uleb128 0x10
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x1
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0xc
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0xc
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x1
	.uleb128 0x40
	.uleb128 0x6
	.byte	0x0
	.byte	0x0
	.uleb128 0x11
	.uleb128 0x5
	.byte	0x0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0xa
	.byte	0x0
	.byte	0x0
	.uleb128 0x12
	.uleb128 0xa
	.byte	0x0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x11
	.uleb128 0x1
	.byte	0x0
	.byte	0x0
	.uleb128 0x13
	.uleb128 0xf
	.byte	0x0
	.uleb128 0xb
	.uleb128 0xb
	.byte	0x0
	.byte	0x0
	.uleb128 0x14
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x1
	.uleb128 0x13
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x1
	.uleb128 0x40
	.uleb128 0x6
	.byte	0x0
	.byte	0x0
	.uleb128 0x15
	.uleb128 0x2e
	.byte	0x0
	.uleb128 0x3f
	.uleb128 0xc
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x1
	.uleb128 0x40
	.uleb128 0x6
	.byte	0x0
	.byte	0x0
	.uleb128 0x16
	.uleb128 0x2e
	.byte	0x0
	.uleb128 0x3f
	.uleb128 0xc
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x1
	.uleb128 0x40
	.uleb128 0x6
	.byte	0x0
	.byte	0x0
	.uleb128 0x17
	.uleb128 0x34
	.byte	0x0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0xc
	.uleb128 0x3c
	.uleb128 0xc
	.byte	0x0
	.byte	0x0
	.uleb128 0x18
	.uleb128 0x34
	.byte	0x0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0xc
	.uleb128 0x2
	.uleb128 0xa
	.byte	0x0
	.byte	0x0
	.byte	0x0
	.section	.debug_pubnames,"",@progbits
	.long	0x2b2
	.value	0x2
	.long	.Ldebug_info0
	.long	0x727
	.long	0x22a
	.string	"load_idt"
	.long	0x254
	.string	"kb_interrupt_do"
	.long	0x31f
	.string	"divide_zero_exception"
	.long	0x345
	.string	"single_step_exception"
	.long	0x36b
	.string	"nmi_exception"
	.long	0x389
	.string	"breakpoint_exception"
	.long	0x3ae
	.string	"overflow_exception"
	.long	0x3d2
	.string	"bounds_exception"
	.long	0x3f4
	.string	"invalid_opcode_exception"
	.long	0x41e
	.string	"coprocessor_exception"
	.long	0x445
	.string	"double_fault_exception"
	.long	0x46d
	.string	"segment_overrun_exception"
	.long	0x498
	.string	"invalid_tss_exception"
	.long	0x4bf
	.string	"segment_not_present_exception"
	.long	0x4ee
	.string	"stack_fault_exception"
	.long	0x515
	.string	"general_protection_exception"
	.long	0x543
	.string	"page_fault_exception"
	.long	0x569
	.string	"math_fault_exception"
	.long	0x58f
	.string	"alignment_check_exception"
	.long	0x5ba
	.string	"machine_check_exception"
	.long	0x5e3
	.string	"simd_exception"
	.long	0x620
	.string	"caps_enabled"
	.long	0x63b
	.string	"shift_pressed"
	.long	0x657
	.string	"ctrl_pressed"
	.long	0x672
	.string	"alt_pressed"
	.long	0x68c
	.string	"meta_pressed"
	.long	0x6a7
	.string	"enter_pressed"
	.long	0x6d3
	.string	"char_map"
	.long	0x6ea
	.string	"char_map_caps"
	.long	0x706
	.string	"x"
	.long	0x716
	.string	"y"
	.long	0x0
	.section	.debug_aranges,"",@progbits
	.long	0x1c
	.value	0x2
	.long	.Ldebug_info0
	.byte	0x4
	.byte	0x0
	.value	0x0
	.value	0x0
	.long	.Ltext0
	.long	.Letext0-.Ltext0
	.long	0x0
	.long	0x0
	.section	.debug_str,"",@progbits
.LASF0:
	.string	"unsigned int"
.LASF1:
	.string	"idt_desc_t"
	.ident	"GCC: (GNU) 4.1.2 20070626 (Red Hat 4.1.2-13)"
	.section	.note.GNU-stack,"",@progbits
