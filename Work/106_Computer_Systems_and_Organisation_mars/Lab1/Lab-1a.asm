# --------------------------------
# CS106 Practical Assignment 1(a)
# a + 2b + 3c
# --------------------------------

# sample input data

.data
A:    .word 100
B:    .word 10
C:    .word 1

.text
CodeToTest:                   # label for running tests
# ----------------------------------------------------------------
# Write code to evaluate a + 2b + 3c.
# a, b and c are in memory addresses A, B and C.
# Place the result in $v0.
# ----------------------------------------------------------------
# YOUR CODE STARTS HERE

 lw $v0, A # v0 A         
 lw $t0, B # t0 B           
 lw $a0, C # a0 C
 mul $t0, $t0, 2 # t0 2B
 mul $a0, $a0, 3 # a0 3C
 add $t0, $t0, $a0 # t0 2B+3C
 add $v0, $v0, $t0 # v0 A+2B+3C
# YOUR CODE ENDS HERE
# ----------------------------------------------------------------

# UNCOMMENT THE FOLLOWING LINE TO TEST YOUR CODE
.include "Lab-1a-Tests.asm"
