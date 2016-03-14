		# void MatMult(int x[][], int y [][], int z[][]
		# matrix z = x*y
		# int i. j. k
		# 
		# for(i=0; i != rowlen; i++)
		#	for(j=0; j != rowlen; j++
		#		for(k=0; k != rowlen; k++)
		#			z[i][j] = x[i][k] * y[k][j];
		#
		# $a0 is base for array x 
		# $a1 is base for array y
		# $a2 is base for array z
		# $a3 is rowlen




.data


xmat:	.word	1, 1, 1, 1, 2, 2, 2, 2, -1, -1, -1, -1, 3, 3, 3, 3, 1, 1, 1, 1, 2, 2, 2, 2, -1, -1, -1, -1, 3, 3, 3, 3
		1, 1, 1, 1, 2, 2, 2, 2, -1, -1, -1, -1, 3, 3, 3, 3, 1, 1, 1, 1, 2, 2, 2, 2, -1, -1, -1, -1, 3, 3, 3, 3
ymat:	.word	2, -1, 3, 2, 1, -2, 3, 5, 4, 6, -2, 3, 2, 3, 1, -1, 2, -1, 3, 2, 1, -2, 3, 5, 4, 6, -2, 3, 2, 3, 1, -1
		2, -1, 3, 2, 1, -2, 3, 5, 4, 6, -2, 3, 2, 3, 1, -1, 2, -1, 3, 2, 1, -2, 3, 5, 4, 6, -2, 3, 2, 3, 1, -1
zmat:	.word	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
rowlen:	.word	8

newline:	.asciiz		"\n" 
space:		.asciiz		" "

		
.text						
		lw $s0,rowlen

		la $a0, xmat
		addi $a1, $s0, 0
		jal printMat
		
		la $a0, ymat
		addi $a1, $s0, 0
		jal printMat
		
		la $a0, xmat
		la $a1, ymat
		la $a2, zmat
		addi $a3, $s0, 0

		jal MatMult

		la $a0, zmat
		addi $a1, $s0, 0
		jal printMat
		

Quit:
		li	$v0, 10		
		syscall			

		


##############################################################################
# 			Matrix Multiplication					
##############################################################################


MatMult:

		addi $t0, $zero 0 	# $t0 = i = 0, init for first loop
Loop1:	
		addi $t1, $zero 0 	# $t1 = j = 0, init for second loop
Loop2:	
		addi $t8, $zero, 0	# $t8 will accumulate Z[i][j], initially 0
		addi $t2, $zero 0 	# $t2 = k = 0, init for inner loop
Loop3:
		mul $t3, $t0, $a3	# $t3 = rowlen * i 
		addu $t3, $t3, $t2	# $t3 = rowlen * i + k
		sll $t3, $t3, 2		# $t3 = 4-byte offset of above
		addu $t3, $t3, $a0	# $t3 = address of x[i][[k]

		lw $t3, 0($t3)		# $t3 = x[j][k]

		mul $t4, $t2, $a3	# $t4 = rowlen * k 
		addu $t4, $t4, $t1	# $t4 = rowlen * k + j
		sll $t4, $t4, 2		# $t4 = 4-byte offset of above
		addu $t4, $t4, $a1	# $t4 = address of y[k][[j]

		lw $t4, 0($t4)		# $t4 = y[k][j]

		mul $t7, $t3, $t4	# $t8 = x[i][k]*y[k][j]
		add $t8, $t8, $t7       # add product to Z[i][j]

		addiu $t2, $t2, 1	# k = k+1
		bne $a3, $t2, Loop3	# continue Loop3 if k != rowlen, end of row
		
		mul $t5, $t0, $a3	# $t5 = rowlen * i 
		addu $t5, $t5, $t1	# $t5 = rowlen * i + j
		sll $t5, $t5, 2		# $t5 = 4-byte offset of above
		addu $t5, $t5, $a2	# $t5 = address of Z[i][[j]

		sw $t8, 0($t5)		# store value to Z[i][j]

		addiu $t1, $t1, 1	# j = j+1
		bne $a3, $t1, Loop2	# continue Loop2 if j != rowlen
		addiu $t0, $t0, 1	# i = i+1
		bne $a3, $t0, Loop1	# continue Loop2 if i != rowlen

		jr $ra

##############################################################################
# 			Print Matrix					
##############################################################################

printMat:
		addi	$t0, $a0, 0	# $t0 = base address of array
		addi	$t1, $a1, 0	# $t1 = rowlen
		
		la	$a0, newline	# Load the address of the string 
	        li	$v0, 4		# Load the system call number
		syscall 

		
		sll $t2, $t1, 2  	# t2 is row length in bytes
		mul $t3, $t1, $t2	# t3 total bytes in array
		add $t4, $t0, $t2	# t4 terminates row
		add $t5, $t3, $t0	# t5 = address after end of array

colLoop:
		la	$a0, space	# Load the address of the string 
	        li	$v0, 4		# Load the system call number
		syscall 

		lw $a0, 0($t0)		# set $a0 to matrix entry
		addi $v0, $zero, 1
		syscall			# print matrix entry
		
		addi $t0, $t0, 4
		bne $t0, $t4, colLoop
		
					# Print newline 
		la	$a0, newline	# Load the address of the string 
	        li	$v0, 4		# Load the system call number
		syscall 

		add 	$t4, $t4, $t2
		bne	$t0, $t5, colLoop
		
		jr $ra
		
