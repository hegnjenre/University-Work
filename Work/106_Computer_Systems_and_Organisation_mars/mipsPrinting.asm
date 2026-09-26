.data
  newLine: .asciiz "\n"
  #assume string in $a0
.text
printLine:
  li $v0, 4
  syscall
  la $a0, newLine # print newline after text printed
  syscall
  j returnPrint


