.data

  films: .asciiz "Lionheart", "TimeCop", "Hard Target", "Sudden Death", "BloodSport"
  old: .asciiz "o"
  new: .asciiz "E"

.text
  la $a0, films # a0 -> films[0]
  li $s3, 5 # size of loop = 5
  li $s2, 0 # i = 0

Main:
  beq $s2, $s3, endMain # i == size -> endMain
  
  lbu $a1, old # char to replace
  lbu $a2, new # replace with
  move $s0, $a0 # save pointer
  j changeChar

returnChange:
  move $s1, $v0 # save end of string
  move $a0, $s0 # get start of string from saved pointer
  j printLine

returnPrint:
  addi $s1, $s1 1 #increase saved end of string by one then
  move $a0, $s1 # place in main pointer
  addi $s2, $s2, 1  # i+=1
  j Main

endMain:
  li, $v0, 10 # terminate
  syscall

.include "mipsPrinting.asm"
.include "changeCharacter.asm"
