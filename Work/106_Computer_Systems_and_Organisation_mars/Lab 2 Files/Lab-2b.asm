# --------------------------------
# CS106 Practical Assignment 2(b)
# Array indexing
# --------------------------------

# sample input data

.data
A:    .half     1    2   3  4 5
B:    .half 10000 1000 100 10 1
.text
      la    $a0, A
      la    $a1, B
      li    $a2, 5            # length of arrays

CodeToTest:                   # label for running tests
# ----------------------------------------------------------------
# Register $a0 contains the address of an array A of halfwords.
# Register $a1 contains the address of an array B of halfwords.
# Place B[A[1]] in $v0.
# ----------------------------------------------------------------
# YOUR CODE STARTS HERE
li    $a3, 0            # index to be shifted

lhu $s0, 4($a0) # $s0 = A[1] (2)
sll $s0, $a3, $s0 # $s0 = i shifted by A[1], i shifted by 2
add $s0, $a1, $s0 # $s0 = B + i(shift), B[A[1]]?
lhu $v0, ($s0) # $v0 = B[A[1]]

# YOUR CODE ENDS HERE
# ----------------------------------------------------------------

# UNCOMMENT THE FOLLOWING LINE TO TEST YOUR CODE
.include "Lab-2b-Tests.asm"
