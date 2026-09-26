# --------------------------------
# CS106 Practical Assignment 3(a)
# Bitfields: Extracting data
# --------------------------------

# sample input data

.data

A:    .half 0x5555 0x7777 0x3EEF 0x7ACE 0x2BCD 0x1234

.text
CodeToTest:                   # label for running tests
# ----------------------------------------------------------------
# Data format (16 bits): JPGRYMMMMMMMMxxx
# MMMMMMMM is the magic number.
# Write code to extract the magic number from A[0] into $v0
# and the magic number from A[5] into $v1.
# ----------------------------------------------------------------
# YOUR CODE STARTS HERE
la $a0, A             # a0 -> A[0] pointer
lhu $a1, ($a0)        # a1 = A[0]
andi $v0, $a1, 0x07F8 # v0 = and masked A
srl $v0, $v0, 3       # shift right by 3 to account for the xxx
lhu $a1, 10($a0)      # a1 = A[5]
andi $v1, $a1, 0x07F8 # v1 = and masked A
srl $v1, $v1, 3       # shift right by 3 to account for the xxx

# YOUR CODE ENDS HERE
# ----------------------------------------------------------------

# UNCOMMENT THE FOLLOWING LINE TO TEST YOUR CODE
.include "Lab-3a-Tests.asm"
