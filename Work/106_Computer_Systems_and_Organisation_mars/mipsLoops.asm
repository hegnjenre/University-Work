.data

  max: .word 600   #maximum
  index: .word 0 #index

.text

  lw $s0, max   # s0 = i
  lw $a0, index # a0 = count = 0
  
Loop:
  
  sne $t1, $s0, $a0 # s0 != a0
  beqz $t1, End     # if s0 = a0, go to End
  addi $a0, $a0, 1  # add one to index
  j Loop            #repeat
  
End: 
  li $v0, 1 # syscall for print int
  syscall
  