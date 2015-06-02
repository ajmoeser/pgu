#First Program: Programming from the Ground Up

.section .data

.section .text
	
.globl _start
_start:
movl $1, %eax  #exit command

movl $0, %ebx  #status number

int $0x80      #wakes up kernel to run exit command
