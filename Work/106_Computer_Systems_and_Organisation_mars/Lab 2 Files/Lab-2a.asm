# --------------------------------
# CS106 Practical Assignment 2(a)
# Pointers
# --------------------------------

# sample input data

.data
P:    .word 99
Q:    .word 101
.text
      la    $a0, P
      la    $a1, Q

CodeToTest:                   # label for running tests
# ----------------------------------------------------------------
# Registers $a0 and $a1 will contain pointers to words in memory.
# Read the words at memory locations $a0 and $a1, and place their
# product back into memory location $a0.
# ----------------------------------------------------------------
# YOUR CODE STARTS HERE

lw $s0, ($a0)
lw $s1, ($a1) # load both words, brackets for memory pointers

mul $s0, $s0, $s1 # product of both words
sw $s0, ($a0)

# YOUR CODE ENDS HERE
# ----------------------------------------------------------------

# UNCOMMENT THE FOLLOWING LINE TO TEST YOUR CODE
.include "Lab-2a-Tests.asm"
