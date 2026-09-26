 # --------------------------------
# CS106 Practical Assignment 5(b)
# Signed overflow
# --------------------------------

.data
A:    .half 99 101
.text
      la    $a0, A
      la    $a1, A+2

CodeToTest:                   # label for running tests
# ----------------------------------------------------------------
# Add the signed 16-bit numbers at the addresses in $a0 and $a1.
# If no overflow (as 16-bit signed integers) occurred, place their sum in $v0.
# If overflow did occur, place the minimum possible 32-bit signed value in $v0.
# ----------------------------------------------------------------
# YOUR CODE STARTS HERE
main:
  lh $a0, ($a0)
  lh $a1, ($a1)

  addu $v0, $a1, $a0 # add values
  xor $t0, $a1, $a0 # check if sign bits are the same,           0 if same, 1 if different
  sge $t1, $t0, 0 # set if same sign
  xor $t0, $v0, $a0 # check if answer sign bit is also same
  slti $t2, $t0, 0
  and $t0, $t2, $t1 
  beqz $t0, noverflow
  j end
noverflow:
  li $v0, 0x80000000
end:
  
# YOUR CODE ENDS HERE
# ----------------------------------------------------------------

# UNCOMMENT THE FOLLOWING LINE TO TEST YOUR CODE
.include "Lab-5b-Tests.asm"
