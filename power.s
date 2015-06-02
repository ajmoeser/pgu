# following ch. 4, PGU
#
# power.s
#
# illustrating popl, pushl, stacks generally
	
	.section .data

	.section .text

	.globl _start

_start:
	pushl $3			# base
	pushl $2			# power
	call power
	addl $8, %esp			# reset pointer
	pushl %eax			# saving answer (which is stored...
					# in eax, but which will be overwritten
					# by the second function call)

	pushl $2			# base
	pushl $5			# power
	call power
	addl $8, %esp			# reset pointer

	popl %ebx

	addl %eax, %ebx

	movl $1, %eax			# exit system call
	int $0x80			# interrupt
	

# power function

	.type power, @function
power:
	pushl %ebp			# saving base pointer
	movl %esp, %ebp
	subl $4, %esp

	movl 8(%ebp), %ebx
	movl 12(%ebp), %ecx

	movl %ebx, -4(%ebp)

power_loop_start:
	cmpl $1, %ecx
	je end_power

	movl -4(%ebp), %eax
	imull %ebx, %eax
	movl %eax, -4(%ebp)

	decl %ecx
	jmp power_loop_start

end_power:
	movl -4(%ebp), %eax
	movl %ebp, %esp
	popl %ebp

	ret
	
