.data

  nums: .
  size: .byte 0x09
  even: .asciiz "The number is even." # using AND with one to tell if odd or even, odd returns 1 from AND
  odd: .asciiz "The number is odd."
  newline: .byte 0x0A

.text
  la $s0, nums # get address for array
  lbu $a0, size # s1 = nums.size()
  li $a1, 0 # index = 0
  li $v0, 4 # syscall for string printing
Loop:
  sll $t0, $a1, 2 # t0 = i*4, offset by one word
  add $t0, $t0, $s0 # $t0 -> nums[i], by adding the offset to the loaded address
  lw $t0, ($t0) # t0 = nums[i]
  andi $t0, $t0, 1 # nums[i] % 2, to check if even
  beqz $t0, Even # if zero -> Even
  la $a0, odd # load odd string into a0
  syscall
  j Check #skip Even
Even:
  la $a0, even # load even string into a0
  syscall
  
Check:
  la $a0, newline
  syscall
  addi $a1, $a1, 1 # index += 1
  bgt $a1, $s1, End
  j Loop
  
End:
  li $v0, 10
  syscall