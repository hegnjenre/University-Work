# --------------------------------
# CS106 Practical Assignment 1(b)
# ax^2 + bx + c
# --------------------------------

# sample input data

.data
A:    .word 100
B:    .word 10
C:    .word 1
.text
    li    $a0, 3

CodeToTest:                   # label for running tests
# ----------------------------------------------------------------
# Write code to evaluate ax^2 + bx + c.
# a, b and c are in memory addresses A, B and C.
# x is in register $a0.
# Place the result in $v0.
# ----------------------------------------------------------------
# YOUR CODE STARTS HERE
 lw $t0, A # t0 A
 lw $t1, B # t1 B
 lw $t2, C # t2 C
 mul $t1, $t1, $a0 # t1 BX
 mul $a0, $a0, $a0 # a0 X^2
 mul $t0, $t0, $a0 # t0 AX^2
 add $t1, $t1, $t2 # t1 BX+C
 add $v0, $t0, $t1 # v0 AX^2 + BX + C
 

# YOUR CODE ENDS HERE
# ----------------------------------------------------------------

# UNCOMMENT THE FOLLOWING LINE TO TEST YOUR CODE
.include "Lab-1b-Tests.asm"
