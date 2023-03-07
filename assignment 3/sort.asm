insert:
# adress of a[0] --> a0
# length --> a1
# elem --> a2
# i --> a3
# j --> t0
for:
addi $t0, $a1, -1

forCompare:
bge $t0, $a3, forBody
j forEnd

forBody:
addi $t2, $t0, 1 #j+1
sll $t2, $t2, 2 
add $t2, $t2, $a0 #address of a[j+1]
sll $t3, $t0, 2 
add $t3, $t3, $a0 # adress of a[j]
lw $t4, 0($t3) #t4 contains a[j]
sw $t4, 0($t2) # store a[j] in a[j+1]

addi $t1, $t1, -1 # j--
j forCompare

forEnd:
move $t1, $a3
sll $t1, $t1, 2 #i*4
add $t1, $t1, $a0 # address of a[i]
sw $a2, 0($t1) # a[i]=elem
jr $ra



binarySearch:
# low --> t0
# high --> v0
# mid --> t1
# adress of a[0] --> a0
# length --> a1
# elem --> a2 
	li $t0, -1		# int low= -1
	move $v0, $a1		# high = length
BOW: #begin of while
	addi $t9, $v0, -1 	# t9 = high-1
	blt $t0, $t9, EOW	# while evaluation
	
	add $t1, $t0, $v0	# mid_1 = low+high
	srl $t1, $t1, 1		# mid = low+high/2 
	
	sll $t8, $t1, 2 	# t8 stores mid*4 (for adress)
	add $t8, $t8, $a0	# t8 stores the adress of a[mid]
	
	lw $t7, 0($t8)		# t7 = a[mid]
	bge $t7, $a2, IF
	move $t0, $t1
	j BOW
IF:	move $v0, $t1
	j BOW
EOW: #end of while
	jr $ra 			#return high;
	
	
insertionSort:
# addres of a[0] --> $a0, $s3
# length --> $a1
# i --> $s5
#address of b[0] --> $t1

# get everything out of the a regs
move $s3, $a0
move $s4, $a1

#create b array
sll $s6, $s4, 2
sub $sp, $sp, $s6 # allocate space on stack

for:
move $s5 

forCompare:
#jump conditional
j forEnd

forBody:

#increment iterator
j forCompare

forEnd:







# delete stack
add $sp, $sp, $s6 