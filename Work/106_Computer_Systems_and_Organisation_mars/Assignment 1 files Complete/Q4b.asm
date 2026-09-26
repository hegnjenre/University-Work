.data 
  matrix: .word 0xFFFFFFFF, 0xEEEEEEEE, 0xDDDDDDDD, 0xCCCCCCCC, 0xBBBBBBBB, 0xAAAAAAAA, 0x99999999, 0x88888888, 0x77777777, 0x66666666, 0x55555555, 0x44444444, 0x33333333, 0x22222222, 0x11111111, 0x00000000,0xFFFFFFFF, 0xEEEEEEEE, 0xDDDDDDDD, 0xCCCCCCCC, 0xBBBBBBBB, 0xAAAAAAAA, 0x99999999, 0x88888888, 0x77777777, 0x66666666, 0x55555555, 0x44444444, 0x33333333, 0x22222222, 0x11111111, 0x00000000
  newline: .asciiz "\n"
  one: .asciiz "1"
  zero: .asciiz "0"
.text 
  li $t1, 127 # length of matrix, 32 entries starting with 0th, index increase by 4 to be on word boundary, therefore, (32*4)-1
  li $a1, 0 # index for 'horizontal' position, to be inserted into subroutine
  li $t0, 0 # index for 'vertical' position, for moving through matrix array
  li $t4, 0 # for the extra zeroes that don't print at the beginning of printing the numbers later
loop:
  li $s1, 0 # index for printing 32 bit number
  la $s0, matrix # s0 -> matrix[0]
  add $s0, $s0, $t0 # shift array position by index, matrix[i]
  lw $a0, ($s0)     # load word at matrix[i] into $a0 for subroutine
  bltu $t0, $t1, extractAndPrint  # if i < matrix length, jump to subroutine. If i > matrix length, fall through to termination
end:
  li $v0, 10
  syscall
  
extractAndPrint:
  move $a3, $a1
  li $v1, 0 # boolean for printing zeroes
printLoop:
  li $v0, 4 # print str syscall
  bltu $v1, 1, printZeroes # prints the extra zeroes that are left out of later printing
  j extractionSR
printZeroes:
  move $t2, $a0 # storing a0 for later
  move $t5, $t4 # copy $t4 for later
zeroLoop:
  beqz $t4, StartExtraction # branch if no more zeroes to print
  la $a0, zero # load string 0
  syscall
  subiu $t4, $t4, 1 # decrease number of zeroes left to print
  j zeroLoop
  
StartExtraction:
  move $a0, $t2 # reset a1 to prior value, so every main loop a1 will start 1 higher
  j extractionSR

exitSR:
  li $v1, 1 # switch print zeroes bool to 1 to prevent printing more unneeded zeroes 
  move $t2, $a0 # copying a0, to use a0 for printing and t2 for comparison
  #printing string 1 whenever extracted bit is 1, otherwise, print 0
  beqz $t2, print0 # if extracted $a0 = 0 branch to print 0, else print 1
print1:
  la $a0, one # load string 1
  syscall
  j cont
print0:
  la $a0, zero # load string 0
  syscall
  
                   ### I do not know how to print the 1 in the correct bit position
                   ### the data retrieved from the extraction subroutine is correct, 
                   ### and if there was a direct syscall for translating hex to bin before printing
                   ### then I would have a correct answer.
                   ### But there isn't, so I have no more ideas on how to get the 1 to print in the correct place
                   ###
                   ### by correct I mean that if 0x00000002 was printed as binary it would be 00000000000000000000000000000010
                   ###
                   ### 0x00000001		00000000000000000000000000000001
                   ### 0x00000002		00000000000000000000000000000010
                   ### 0x00000004	        00000000000000000000000000000100
                   ### and so on...
                   ### at that point I would just shift the extracted along by a decreasing index, 
                   ### so that it was a diagonal from left to right rather than right to left
                   ###
                   ### but obviously I can't, and this is the best I could do to try to translate hex to binary for the question.
  
cont:
  move $a0, $t2 # return original a0                                              .
  addi $a1, $a1, 1 # printIdx++
  bltu $a1, 32, printLoop # if s1 index is less than the length of a 32 bit number
  la $a0, newline # linebreak
  li $v0, 4 # print str syscall
  syscall
exitPrintLoop:
  move $t4, $t5 # reset t4
  move $a1, $a3 # reset a1 to prior value, so every main loop a1 will start 1 higher
  addi $t4, $t4, 1 # add a zero at the beginning of print number
  addi $a1, $a1, 1 # HIndex++
  addi $t0, $t0, 4 # VIndex++
  li $v1, 0 # reset printZeroes boolean
  j loop
  
.include "Q4a.asm"
