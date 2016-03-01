.data
Histogram:.byte 0:11
Cumulative:.byte 0:6
Image:.byte 1 3 4 5 5 10
Size:.byte 6

.text
la $a0, Image
lw $a1, Histogram
lw $a2, Cumulative
lw $a3, Size

jal HistogramCalc


#Exit
li $v0, 10
syscall


HistogramCalc:

		addi $t0, $zero, 0 	# Initialise t0 as it will be used as our looping variable  "i"
		add $t0, $t0, $a0 #Add the image arguement register value to $t0
		add $t2, $t2, $a1 #Add the Histogram arguement value to $t2
		lw $t2, 0($t0)     # load the first value in the image and store it in $t2
		add $a1, $a0, $t1	# Add the lower pointer to the image size to determine the end pointer
HistLoop: 	lbu $t4, 0($t2)		# Load the current Histogram value into $t4
		addi $t4, $t4, 1	# Add 1 to $t4  " Histogram [i] =  Histogram [i] + 1 "
		sb $t4, 0($t2)		# Store this value back into Histogram
		addi $t2, $t2, 1 	# Increment the Histogram pointer  "   i++ "
		addi $t0, $t0, 1	# Increment the indexing pointer     " i = 2^b - 1 "

		blt $a0, $a1, HistLoop 	# If the final pointer isn't the same as the indexing pointer, branch back to HistLoop  " i = 2^b - 1 "
		jr $ra     # end of stage 1

#HistogramAdd:			
#			addi $t5, $zero, 0   # Initialise t5 as it will be used as our looping variable  "j"
#			la $t2, Histogram   # ??? what?
#			la $a0, Histogram  # Load the address of the histogram.
#			lbu $t6, Cumulative($t5) # Load the current cumulative value into $t6
#			subi $t7, $t5, -1 # Create a - 1 of J ready for " j -1 " as a pointer.		
#Stage2Loop:	addi $t5,
#			addi $t5, $t5, 1 # Increment the pointer " j++ "
#			addi $a0, $a0, 1	# Increment the indexing pointer     " i = 2^b - 1 "
#			blt $t5, $a1,  stage2Loop  # j = L = 2^b - 1		
		
#			jr $ra # end of stage 2
			
			
			
			
			
			
			
		
#		add $a1, $a0, $t1	# Add the lower pointer to the image size to determine the end pointer
#		la $t6, Cumulative
#CumuLoop:	lbu $t4, 0($t2)
#		add $t7,$t7, $t4	# Store 
#		jr $ra
