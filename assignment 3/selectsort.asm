		.text
		j	main			# Jump to main-routine

		.data
str1:		.asciiz "Insert the array size \n"
str2:		.asciiz "Insert the array elements,one per line  \n"
str3:		.asciiz "The sorted array is : \n"
str5:		.asciiz "\n"

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
for_get:	bge	$s1, $s2, exit_get	# if i>=n go to exit_for_get
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
exit_get:	move	$a0, $sp		# $a0=base address af the array
		move	$a1, $s2		# $a1=size of the array
		jal	isort			# isort(a,n)
						# In this moment the array has been
						# sorted and is in the stack frame
		la	$a0, str3		# Print of str3
		li	$v0, 4
		syscall

		move	$s1, $zero		# i=0
for_print:	bge	$s1, $s2, exit_print	# if i>=n go to exit_print
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
exit_print:	add	$sp, $sp, $s0		# elimination of the stack frame

		li	$v0, 10			# EXIT
		syscall				#

#################
# selectionSort #
#################
isort:
        addi $s3, $a1, -1   # s3 = length-1
        move $s1, $zero     # s1 is used as iterator, so can be reused without problems
        move $s7, $ra   # store return addr of main in s7
for_sort:
        bge $s1, $s3, end_for_sort
        # addr of a already in a0
        move $a1, $s1
        move $a2, $s3
        jal indexMin
        # a0 and a1 are already correctly set.
        move $a2, $v0
        jal swap
        addi $s1, $s1, 1    #increment i
        j for_sort
end_for_sort:
        # restore ra
        move $ra, $s7
        jr $ra

################
# indexMinimum #
################
indexMin:
        move $v0, $a1
        sll $t0, $a1, 2     # t0 = 4*first
        add $t0, $t0, $a0   # t0 = address of v[first]
        lw $t1, 0($t0)      # t1 = min = v[first]
        addi $t2, $a1, 1    # t2 = i = first+1
for_index:
        bgt $t2, $a2, end_for_index
        sll $t3, $t2, 2      # t3=i*4
        add $t3, $t3, $a0   # t3 = addr of v[i]
        lw $t3, 0($t3)      # t3 = v[i]
        bge $t3, $t2, increment_index
        move $v0, $t2       # mini = i
        move $t1, $t3       # min = v[i]
increment_index:
        addi $t2, $t2, 1
        j for_index
end_for_index:
        jr $ra

########
# swap #
########
swap:
        sll $t0, $a1, 2     # t0 = i*4
        add $t0, $t0, $a0   # t0=addr of v[i]
        sll $t1, $a2, 2     # t1 = j*4
        add $t1, $t1, $a0   # t1=addr of v[j]
        lw $t2, 0($t0)      # t2 = temp = v[i]
        lw $t3, 0($t1)      # t3 = v[j]
        sw $t3, 0($t0)      # store v[j] at the address of v[i]
        sw $t2, 0($t1)      # store temp at the addres of v[j]
        jr $ra
