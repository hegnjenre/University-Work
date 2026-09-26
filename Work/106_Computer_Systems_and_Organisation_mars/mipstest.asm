.data

  hw: .word 0xFA070010
  
.text
li $v0, 1
li $a1, 0x00000010
lw $a0, hw
and $a0, $a1, $a0
syscall
