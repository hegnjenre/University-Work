# --------------------------------
# CS106 Practical Assignment 5(a)
# Unsigned overflow
# --------------------------------

.data
A:    .half 0x0000FFFF 0x00000001
.text
      la    $a0, A
      la    $a1, A+2

CodeToTest:                   # label for running tests
# ----------------------------------------------------------------
# Add the unsigned 16-bit numbers at the addresses in $a0 and $a1.
# If no overflow (as 16-bit unsigned integers) occurred, place their sum in $v0.
# If overflow did occur, place the minimum possible 32-bit signed value in $v0.
# ----------------------------------------------------------------
# YOUR CODE STARTS HERE
main:
  lhu $a0, ($a0)
  lhu $a1, ($a1)
  
  add $v0, $a0, $a1 # add together
  andi $a2, $v0, 0x000F0000 # and mask for next largest bit position
  beq $a2, 0x00010000, overflow # if next largest bit position has value in it, then half word unsigned overflow occurred
  j end
overflow:
  li $v0, 0x80000000
end:
# YOUR CODE ENDS HERE
# ----------------------------------------------------------------

# UNCOMMENT THE FOLLOWING LINE TO TEST YOUR CODE
.include "Lab-5a-Tests.asm"
