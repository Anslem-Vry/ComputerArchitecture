

1- The attached readFile.asm  and writeFile.asm are sample codes explaining how to do I/O with Mars assembler using files. The assembly program readFile refers to the attached file testin.txt. The full path to this file should be set correctly in the code of readFile.asm.

The assembly program wrFile.asm write a data into the file testout.txt. Similarly, the path to this file should be set correctly in the code of wrFile.asm.

If you want to check the data formatting (e.g. new line, space) in the pgm file, write in the command line session (cmd) the following instruction:
   type imageName.pgm

2- Reading the PGM file in Mars
You are encouraged to delete the header from the pgm files, to keep only the pixel values before reading them in your MIPS code

3- You can test the histogram equalisation algorithm implementation first using data values set in your program. On its successful implementation, you can then integrate the functions to read/write  from/to a file

