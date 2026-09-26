.data
# a0 = pointer to string
# a1 = oldchar, a2 = newchar
  

.text
changeChar:
  lbu $t0, ($a0) # get char[i]
  beqz $t0, End # if char[i] = 0 -> End
  
  bne $t0, $a1, Done # if old != current -> Done
  
  sb $a2, ($a0) #store new character in pointer position
  
Done:
  addi $a0, $a0, 1 # i+=1, (pointer pos += 1)
  j changeChar
  
End:
  move $v0, $a0 #return end of string array
  j returnChange