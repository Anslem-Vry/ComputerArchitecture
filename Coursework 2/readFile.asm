.data  
fin: .asciiz "N:\\eng520\\filesLabs\\testin.txt"       # change the path accordingly
size: .word 20  # 20 being the number of bytes(characters) to read
buffer: .space 20  # preallocate 20 bytes to hold the read chars

.text
#open a file for writing
li   $v0, 13       # system call for open file
la   $a0, fin      # board file name
li   $a1, 0        # Open for reading
li   $a2, 0
syscall            # open a file (file descriptor returned in $v0)
move $s6, $v0      # save the file descriptor 

#read from file
li   $v0, 14       # system call for read from file
move $a0, $s6      # file descriptor 
la   $a1, buffer   # address of buffer to which to read
lw   $a2, size    # hardcoded buffer length
syscall            # read from file

# Close the file 
li   $v0, 16       # system call for close file
move $a0, $s6      # file descriptor to close
syscall            # close file


# print the data read from the file and stored in buffer
li $v0,4
la $a0,buffer
syscall

# exit

li $v0,10
syscall
