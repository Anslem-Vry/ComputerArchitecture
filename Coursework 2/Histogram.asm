.data
Histogram:.byte 0:11
Cumulative:.byte 0:6
Image:.byte 1 3 4 5 5 10
Size:.byte 6

.text

jal HistogramCalc



#Exit
li $v0, 10
syscall


HistogramCalc:
		addi $t0, $zero, 0 	# Initialise t0 as it will be used as our looping variable
		lbu $t2, Image($t0)
		la $a0, Histogram
		lbu $t1, Size 		# Load the size of the image into $t1
		add $a1, $a0, $t1	# Add the lower pointer to the image size to determine the end pointer
HistLoop: 	lbu $t4, Histogram($t2)		# Load the current Histogram value into $t4
		addi $t4, $t4, 1	# Add 1 to $t4
		sb $t4, Histogram($t2)		# Store this value back into Histogram
		addi $t2, $t2, 1 	# Increment the Histogram pointer
		addi $a0, $a0, 1	# Increment the indexing pointer

		blt $a0, $a1, HistLoop 	# If the final pointer isn't the same as the indexing pointer, branch back to HistLoop
		jr $ra

#HistogramAdd:
#		la $t2, Histogram
#		la $a0, Histogram
#		add $a1, $a0, $t1	# Add the lower pointer to the image size to determine the end pointer
#		la $t6, Cumulative
#CumuLoop:	lbu $t4, 0($t2)
		add $t7,$t7, $t4	# Store 
		jr $ra