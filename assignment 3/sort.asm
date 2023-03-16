
.text
	j	main			# Jump to main-routine

.data
str1:	.asciiz "Insert the array size \n"
str2:	.asciiz "Insert the array elements,one per line  \n"
str3:	.asciiz "The sorted array is : \n"
str5:	.asciiz "\n"

.text
	.globl	main
main:
	la	$a0, str1		# Print of str1
	li	$v0, 4			#
	syscall				#
	li	$v0, 5			# Get the array size(n) and
	syscall				# and put it in $v0
	move	$s2, $v0		# $s2=n
	sll	$s0, $v0, 2		# $s0=n*4
	sub	$sp, $sp, $s0		# This instruction creates a stack
					# frame large enough to contain
					# the array
	la	$a0, str2		#
	li	$v0, 4			# Print of str2
	syscall				#
           
	move	$s1, $zero		# i=0

for_get:
	bge	$s1, $s2, exit_get	# if i>=n go to exit_for_get
	sll	$t0, $s1, 2		# $t0=i*4
	add	$t1, $t0, $sp		# $t1=$sp+i*4
	
	li	$v0, 5			# Get one element of the array
	syscall				#
	sw	$v0, 0($t1)		# The element is stored
					# at the address $t1
	la	$a0, str5
	li	$v0, 4
	syscall

	addi	$s1, $s1, 1		# i=i+1
	j	for_get

exit_get:
	move	$a0, $sp		# $a0=base address af the array
	move	$a1, $s2		# $a1=size of the array
	jal	isort			# isort(a,n)
					# In this moment the array has been 
					# sorted and is in the stack frame 
	la	$a0, str3		# Print of str3
	li	$v0, 4
	syscall

	move	$s1, $zero		# i=0

for_print:
	bge	$s1, $s2, exit_print	# if i>=n go to exit_print
	sll	$t0, $s1, 2		# $t0=i*4
	add	$t1, $sp, $t0		# $t1=address of a[i]
	
	lw	$a0, 0($t1)		#
	li	$v0, 1			# print of the element a[i]
	syscall				#

	la	$a0, str5
	li	$v0, 4
	syscall
	
	addi	$s1, $s1, 1		# i=i+1
	j	for_print

exit_print:
	add	$sp, $sp, $s0		# elimination of the stack frame 
              
	li	$v0, 10			# EXIT
	syscall				#
	
#########
# isort #
#########
# isort(a[], length)
# implemented with s registers

isort:
	add $s3, $0, $a0 	# s3 = a
	add $s4, $0, $a1	# s4 = length		
	
	sll $t0, $s4, 2		# length * 4
	sub $sp, $sp, $t0	# create room on stack for b

	add $s5, $0, $0		# i = 0

isortfor1:
	bge $s5, $s4, endisortfor1

	sll $t1, $s5, 2		# i * 4		
	add $t2, $s3, $t1	# addr of a[i]
	
	add $a0, $0, $sp	# set b arg to addr of b
	add $a1, $0, $s5	# set i arg to value of i
	lw $a2, 0($t2)		# set a[i] arg to value of a[i]
	jal binarySearch	# call binarySearch
	
	# assume all t vars overwritten
	sll $t1, $s5, 2		# i * 4		
	add $t2, $s3, $t1	# addr of a[i]
	
	add $a0, $0, $sp	# set b arg to addr of b
	add $a1, $0, $s5	# set i arg to value of i
	lw $a2, 0($t2)		# set a[i] arg to value of a[i]
	add $a3, $0, $v0	# set pos var to return value of binsearch
	jal insert
	
	addi $s5, $s5, 1 	# i++

endisortfor1:

	add $s5, $0, $0		# i = 0

isortfor2:
	bge $s5, $s4, endisortfor2

	sll $t0, $s5, 2		# t0 = i * 4
	add $t1, $s3, $t0	# addr of a[i]
	add $t2, $sp, $t0	# addr of b[i]
	
	lw $t1, 0($t2)
	j isortfor2

endisortfor2:
	sll $t0, $s4, 2		# length * 4
	sub $sp, $sp, $t0	# remove b from the stack
	jr $s6

################
# binarySearch #
################
# int binarySearch(a[], length, elem)
# implemented without s registers

binarySearch:
	addi $t0, $0, -1	# low = -1
	add $t1, $0, $a1	# high = length
	add $s6, $0, $ra	# save ra so we can return back to caller

while:
	addi $t2, $t1, -1	# t2 = high - 1
	
	bge $t2, $0, endWhile	# while low < high -1
	
	add $t3, $t0, $t1	# midi = low+high
	srl $t3, $t3, 1		# mid = midi/2 
	
	sub $t4, $a0, $t3	# t4 = addr of a[mid]
	lw $t5, 0($t4)		# t5 = value of a[mid]
	
	bge $t5, $a2, bsif	# if a[mid] >= elem
	add $t0, $0, $t3	# low = mid
	j while			# jump back to while

bsif:
	add $t1, $0, $t3	# high = mid
	j while

endWhile: 			# end of while
	add $v0, $0, $t1	# set return value to high
	jr $ra 			# return high

##########
# insert #
##########
# void insert(a[], length, elem, i)
# implemented without s registers
insert:
	add $t0, $0, $a0 # take out the a
	addi $t1, $a1, -1 # j = length - 1
	
ifor:
	blt $t1, $a3, endifor	# j < i
	
	addi $t2, $t1, 1 	# j + 1
	sll $t2, $t2, 2 	# (j+1) * 4
	add $t3, $t0, $t2	# the addr of a[j+1]
	
	sll $t4, $t1, 2 	# j * 4
	add $t5, $t0, $t4	# the addr of a[j]
	
	lw $t3, 0($t5)		# a[j+1] = a[j]
	addi $t1, $t1, -1 	# j--
	j ifor

endifor:
	sll $t1, $a3, 2 	# i * 4
	add $t2, $t0, $t1	# addr of a[i]
	lw $t2, 0($a2)		# a[i] = elem
	jr $ra			# return

