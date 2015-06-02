# max_length_count.s
# 
# Returns maximum of list of numbers of specified length.
# As written, checks first 10 numbers of given list
#
# from PGU ch. 3
	
	.section .data

data_items:
	.long 12, 55, 1, 2, 99, 3, 98, 0, 44, 10, 23, 121, 7
					# 13 items, but only checks first 10
					# (should return 99)

	.section .text

	.globl _start

_start:
	movl $0, %edi			# edi holds index
	movl data_items(,%edi,4), %eax	# eax holds current value
	movl %eax, %ebx			# ebx holds current max
					# (initially, current = max)

start_loop:
	cmpl $9, %edi			# if index = 9, go to exit
	je loop_exit			# NOTE: loop ends at 9, since check
					# occurs before edi incremented

	incl %edi			# update index ...
	movl data_items(,%edi,4), %eax  # and current value to be eval'd
	
	cmpl %eax, %ebx			# if ebx >= eax, return to
	jge start_loop			# start of loop, else...

	movl %eax, %ebx			# set max (ebx) to current (eax)
	jmp start_loop			# and return to top of loop

loop_exit:
	movl $1, %eax			# exit code
	int $0x80			# interrupt
