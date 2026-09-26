# --------------------------------
# CS106 Practical Assignment 6(b)
# Vector dot product by shifting and adding
# --------------------------------

# sample input data

.data
A:    .half     1    2   3  4 5
B:    .half 10000 1000 100 10 1
.text
      la    $a0, A
      la    $a1, B
      li    $a2, 5

CodeToTest:                   # label for running tests
# ----------------------------------------------------------------
# Calculate the dot product of the halfword vectors at $a0 and $a1.
# The vector length is given in $a2.
# Place the result in $v0.
# Do not use mul or div.
# ----------------------------------------------------------------
# YOUR CODE STARTS HERE



# YOUR CODE ENDS HERE
# ----------------------------------------------------------------

# UNCOMMENT THE FOLLOWING LINE TO TEST YOUR CODE
#.include "Lab-6b-Tests.asm"
