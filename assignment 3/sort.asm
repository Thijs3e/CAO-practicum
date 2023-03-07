.text
	# Jump to main-routine
	j	main			

.data
	str1: .asciiz "Insert the array size\n"
	str2: .asciiz "Insert the array elements, one per line:\n"
	str3: .asciiz "The sorted array is:\n"
	str5: .asciiz "\n"


.text
	.globl	main
########
# main #
########
main:
	# printf str1
	li $v0, 4 	# indicate that we want to print
	la $a0, str1 	# load the string into the a0 register
	syscall 	# execute the syscall to print

	# get length
	li $v0, 5 		# indicate that we want to get input
	syscall 		# execute syscall
	add	$s0, $0, $v0 	# s0 = length
	sll	$s1, $s0, 2 	# s1 = length * 4
	
	# create a stack of length * 4 to put a completely on the stack
	sub $sp, $sp, $s1
	
	# printf str2
	li $v0, 4 	# indicate that we want to print
	la $a0, str2 	# load string into register
	syscall 	# execute syscall

	add $s2, $0, $0 # set i to zero
inloop:
	bge $s2, $s0, endin
	sll	$t0, $s2, 2	# $t0 = i*4
	add	$t1, $t0, $sp	# $t1 = $sp + $t1
	
	# get element
	li	$v0, 5		# Get one element of the array
	syscall			
	sw	$v0, 0($t1)	# The element is stored at the address $t1
	
	addi $s2, $s2, 1 	# increment i by 1
	j inloop
endin:
	add $a0, $0, $sp 	# put the address of a into an argument
	add $a1, $0, $s0 	# put the length into an argument
	
	jal insertionSort	# call insertSort
	
	la	$a0, str3	# Print of str3
	li	$v0, 4		# indicate that we want to print
	syscall			# execute syscall
	
	add $s2, $0, $0 	# set i to 0 again
outloop:
	bge $s2, $s0, endout	# if we reached the length, go to endout
	sll $t0, $s2, 2		# t0 = i * 4
	add $t1, $sp, $t0	# increment stack to get next element
	
	# print the element
	lw $a0, 0($t1)		# load the element into register a0
	li $v0, 1		# indicate that we want to print
	syscall
	
	# print a newline
	la $a0, str5
	li $v0, 4
	syscall

	addi $s2, $s2, 1
	j outloop
endout:
	add $sp, $sp, $s1
endmain:
	li $v0, 10
	syscall
	
#################
# insertionSort #
#################
insertionSort:
	add $s3, $0, $a0 	# save a0 to s3 which is a
	add $s4, $0, $a1 	# save a1 to s4 which is the length
	
	# allocate stack for blength
	sll	$s5, $s4, 2 	# s5 = length * 4
	
	# create a stack of length * 4 to put a completely on the stack
	sub $sp, $sp, $s5
	
	add $s2, $0, $0 	# use s2 for i again and set it to zero
for1:
	bge $s2, $s4, endFor1
	add $t0, 	
	add $a0, $0, $sp # b
	add $a1, $0, $s2 # i
	add $a2, $0, $
	j for1
endFor1:
	add $s2, $0, $0 # use s2 for i again and set it to zero
for2:
	bge $s2, $a1, endfor2
endFor2:

################
# binarySearch #
################
binarySearch:
	li $t0, -1		# int low= -1
	move $v0, $a1		# high = length
	
while: # begin of while
	addi $t9, $v0, -1 	# t9 = high-1
	blt $t0, $t9, endWhile	# while evaluation
	
	add $t1, $t0, $v0	# mid_1 = low+high
	srl $t1, $t1, 1		# mid = low+high/2 
	
	sll $t8, $t1, 2 	# t8 stores mid*4 (for adress)
	add $t8, $t8, $a0	# t8 stores the adress of a[mid]
	
	lw $t7, 0($t8)		# t7 = a[mid]
	bge $t7, $a2, if
	move $t0, $t1
	j while
	
if:	move $v0, $t1
	j while
	
endWhile: 	# end of while
	jr $ra 	# return high

##########
# insert #
##########
insert:
	addi $t0, $a1, -1
for3:
	blt $t0, $a3, endFor3
	addi $t2, $t0, 1 #j+1
	sll $t2, $t2, 2 
	add $t2, $t2, $a0 #address of a[j+1]
	sll $t3, $t0, 2 
	add $t3, $t3, $a0 # adress of a[j]
	lw $t4, 0($t3) #t4 contains a[j]
	sw $t4, 0($t2) # store a[j] in a[j+1]

	addi $t1, $t1, -1 # j--
	j for3
endFor3:
	move $t1, $a3
	sll $t1, $t1, 2 #i*4
	add $t1, $t1, $a0 # address of a[i]
	sw $a2, 0($t1) # a[i]=elem
	jr $ra
