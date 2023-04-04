# sra test
addi $s0, $zero, 2032	# 00000000 00000000 00000111 11110000 , 7f0
addi $s1, $zero, -250	# 11111111 11111111 11111111 00000110 , ffffff06
srl $s2, $s0, 2 # 00000000 00000000 00000001 11111100 , 1fc
srl $s3, $s1, 2 # 00111111 11111111 00111111 00000001 , 3fffffc1
sra $s4, $s0, 2 # 00000000 00000000 00000001 11111100 , 1fc
sra $s5, $s1, 2 # 11111111 11111111 00111111 00000001 , ffffffc1

# jal test
addi $t0, $zero, 1
add $t1, $zero, $t0
addi $t0, $t0, 1
add $t2, $zero, $t0
jal B
addi $t0, $t0, 1
add $t3, $zero, $t0
addi $t0, $t0, 1
add $t4, $zero, $t0
j end

B: 
addi $t0, $t0, 1
add $t5, $zero, $t0
addi $t0, $t0, 1
add $t6, $zero, $t0
jr $ra

end:
addi $t0, $t0, 1
add $t7, $zero, $t0

#    t reg: 1	2	3	4	5	6	7
#  reg val: 1	2	5	6	3	4	7