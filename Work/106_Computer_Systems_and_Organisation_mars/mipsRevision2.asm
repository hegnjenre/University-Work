#the bits in each letter of a string have been mixed up! Instead of 
# x8 x7 x6 x5 | x4 x3 x2 x1 they have been stored as 
# x4 x3 x2 x1 | x8 x7 x6 x5. Unscramble the code to reveal the message

.data 
  flow1: .asciiz "rÖ7ö''âGr7æöGöWÂdV'FâvWV77rÖ¦W7GæöGW7VFGö'Wæææv'öWæF7öævÖÆÆæGVÖFFÆVöfGVævG&Væv67VF&¶ÆÆV''ö&öG7â"
  
.text 

la $a0, flow1 # pointer
li $t0, 0 # index


loop:
  move $a1, $a0     # copy of pointer into a1
  add $a1, $a1, $t0 # pointer + offset
  lbu $s0, ($a1) #current character
  beqz $s0, End # check if null byte
  srl $s1, $s0, 4 # get lower 4
  sll $s2, $s0, 4 # get upper 4
  or $s0, $s0, $s1 # get correct character
  andi $s0, $s0, 0xFF # clear the rest of register so onl have lower 8 bits
  
  sb $s0, ($a1) # store back to memory
  addi $t0, $t0, 1 # i ++
  j loop

End:
  li $v0, 4
  syscall
  li $v0, 10
  syscall
