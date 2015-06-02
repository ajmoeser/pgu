# minimum.s
#
# returns the minimum of a list of numbers 
# stops reading list when 0 is read.

	.section .data

data_items:
	.long 3,9,66,2,12,0,1		# list of numbers to be checked
					# (should return 2)

	.section .text

	.globl _start

_start:
	movl $0, %edi			# index of data_items
	movl data_items(,%edi,4), %eax  # eax to hold current
	movl %eax, %ebx			# ebx to hold min. so far
					# (initially set to current)
	
	cmpl $0, %eax			# initial check:
	je loop_exit			# if current == 0, go to exit sequence

	
start_loop:
	incl %edi
	movl data_items(,%edi,4), %eax  # increment list index

	cmpl $0, %eax
	je loop_exit			# if current == 0, exit loop

	cmpl %eax, %ebx			# compare current and max
	jle start_loop			# if ebx <= eax, back to start_loop
					# else ...
	
	movl %eax, %ebx			# current becomes max and start_loop
	jmp start_loop

loop_exit:
	movl $1, %eax			# exit call
	int $0x80			# interrupt
