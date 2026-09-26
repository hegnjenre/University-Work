.data
 X: .word 0xBBCCDDFF
 A: .word 0x0000CAFE, 0x00F100FE
       #   nlnl  Y Z   nl W nl X  

.text
 #lbu $t0, X #t0 FF
 #lbu $t1, X+1
 #lbu $t2, X+2
 #lbu $t3, X+3 #t3 BB
 
 #sb $t0, X+3 #x+3 FF
 #sb $t1, X+2
 #sb $t2, X+1
 #sb $t3, X #x BB
 
 #lw $a0, X #print reg
 li $v0, 34 #set to print on syscall
 #syscall
 
 # W|null|X|null|null|Y|X
 # 4W+X - Y*Z
 lbu $t0, A #t0 Z
 lbu $t1, A+1 #t1 Y
 lbu $t2, A+4 #t2 X
 lbu $t3, A+6 #t3 W
 
 mul $a0, $t3, 4 # 4W
 mul $a1, $t1, $t0 # Y*Z
 add $a0, $a0, $t2 # 4W+X
 sub $a0, $a0, $a1 # 4W+X - Y*Z
 
 syscall
 
 
 