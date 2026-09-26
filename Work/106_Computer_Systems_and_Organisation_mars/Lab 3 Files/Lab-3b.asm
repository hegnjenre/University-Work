 # --------------------------------
# CS106 Practical Assignment 3(b)
# Bitfields: Modifying data
# --------------------------------

# sample input data

.data

A:    .half 0x5555 0x7777 0x3EEF 0x7ACE 0x2BCD 0x1234

.text
CodeToTest:                   # label for running tests
# ----------------------------------------------------------------
# Data format (16 bits): JPGRYMMMMMMMMxxx
# MMMMMMMM is the magic number.
# Write code to load A[1] and change its magic number to PG0YPG1Y.
# Place the modified A[1] in $v0.
# ----------------------------------------------------------------
# YOUR CODE STARTS HERE


la $a0, A                  # a0 = A[0]
lhu $a1, 2($a0)            # a1 = A[1]

andi $t0, $a1, 0x00007800  # extracting PG0YPG1Y to t0
srl $a1, $a1, 3            # shifting right by three so that MMMMMMMM is on half word boundary
add $v0, $a1, $t0          # replacing two lowest bits using andi, current two lowest are all M's
sll $v0, $v0, 3            # shifting back to original position 

# A[1]:  7    7    7    7
#      JPGR|YMMM|MMMM|Mxxx
#      0111 1000  
#        7    8

# YOUR CODE ENDS HERE
# ----------------------------------------------------------------

# UNCOMMENT THE FOLLOWING LINE TO TEST YOUR CODE
.include "Lab-3b-Tests.asm"
