.data
   A: .half 0xBEED, 0xFEED, 0x3E00, 0x0DCA, 0x0007, 0x0012, 0x8000, 0x1234 , 0x5678, 0x9999
   terminate: .asciiz "Done!"
   newLine: .asciiz "\n"
   Neg: .asciiz "-"
.text
  li $s0, 0 # negative count
  la $t0, A # t0 -> A
  move $t1, $t0 # copy t0 pointer to t1
loop:
  li $v0, 1 # load print integer syscall
  beq $s0, 3, end # if count == 3 -> End 
  lhu $a0, ($t1) # load halfword at position $t1
  addi $t1, $t1, 2 # increment t1 to next array half word, for later
  li $a1, 0x00008000 # load the and mask for the halfword's sign bit
  and $a1, $a0, $a1 # use 'and' to extract the halfword's sign bit, if most significant bit is not 1, then $a1 == 0
  beqz $a1, printingPositive  # if extracted word is equal to zero then it is not negative, so jump to noAdd 	
  addi $s0, $s0, 1 # negCount += 1
  
printingNegative
  li $v0, 4 # load print string syscall
  move $a2, $a0 # store a0 for later
  la $a0, Neg # load -
  syscall
  li $v0, 1 # load number syscall
  move $a0, $a2 # return original a0
  syscall # print negative a0 string
  move $a2, $a0 # store a0 for later
  la $a0, newLine # newLine print
  li $v0, 4 # load print string syscall
  syscall
  move $a0, $a2 # return original a0
  j loop

printingPositive:
  syscall # print positive a0 string
  move $a2, $a0 # store a0 for later
  la $a0, newLine # newLine print
  li $v0, 4 # load print string syscall
  syscall
  move $a0, $a2 # return original a0
  j loop

end:
la $a0, terminate  # load terminate string
li $v0, 4  # load print string syscall
syscall
li $v0, 10 # load terminate syscall
syscall
