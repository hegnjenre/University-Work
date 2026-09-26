.data

  x1: .word 5
  x2: .word 6
  x3: .word 7
  
.text
  lw $s0, x1           # s0 = n = 5
  li $a0, 1            # a0 = total = 1
Factorial:
  beqz $s0, End
  mul $a0, $a0, $s0 # a0 = a0 * n
  addi $s0, $s0, -1 # n = n-1
  j Factorial
End:
  li $v0, 1
  syscall

  