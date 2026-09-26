.data
   Array: .half 0xFFFF, 0x1000, 0X3EEE, 0X0DCA, 0x0000, 0x0012
   Size: .byte 6
   newLine: .asciiz "\n"
.text
  la $s0, Array # s0 -> Array[0]
  li $t0, 0 # load index
  lb $t1, Size # load size
loop:
  li $v0, 34 # print hex number syscall
  beq $t0, $t1, end # branch if index == size
  li $s2, 0x00000001 # loading and mask
  
  lhu $a0, ($s0) # loading halfword from array
  addiu $s0, $s0, 2 # incrementing array
  
  and $s2, $t0, $s2 # and masking to check if index is even, if s2 = 0x00000001 then t0 is odd
  beq $s2, 0x00000001, odd # branch to odd if index not even
  
even:
  not $a0, $a0 # logical negation of value at a0
  syscall # print
  li $v0, 4 # print str syscall
  la $a0, newLine # new line for readability
  syscall
  j increment

odd:
  divu $a0, $a0, 2 # division by 2 of value at a0
  syscall # print
  li $v0, 4 # print str syscall
  la $a0, newLine # new line for readability
  syscall
  j increment

                   ## not storing values back into memory because the question doesn't ask for it

increment:
  addiu $t0, $t0, 1 # i++
  j loop
  
end:
li $v0, 10 # terminate syscall
syscall