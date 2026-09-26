.data 
  flow1: .word 0xFF007964
  # shifting two halves of a word
.text 

  la $t0, flow1     # a0 -> flow1
  lw $a0, ($t0)     # load the word twice
  lw $a1, ($t0)
  sll $a0, $a0, 16   # shift the first word left (x8 - x5) become most significant bits
  srl $a1, $a1, 16   # shift the second word right (x4 - x1) become least significant bits
  add $a0, $a0, $a1 # add the two together, since unsigned: all the added bits from shifting are zero, so adding will just replace them
  li $v0, 1
  syscall
  