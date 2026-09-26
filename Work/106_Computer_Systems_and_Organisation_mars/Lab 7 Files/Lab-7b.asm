# --------------------------------
# CS106 Practical Assignment 7(b)
# Converting ARGB to greyscale
# --------------------------------

.text

      j     Z_StartTests      # run tests

# ----------------------------------------------------------------
# GreyFromARGB
# Input:   a0: an ARGB colour
# Returns: v0: the colour in $a0 converted to grayscale
#              using the formula grey: y = (5r + 9g + 2b) / 16, where FF:y:y:y ; each channel should be the SAME
# ----------------------------------------------------------------
# YOUR CODE STARTS HERE

GreyFromARGB:
  srl $t0, $a0, 16 # put red into lowest byte
  andi $t0, $t0, 0xFF # and mask for red
  mul $v0, $t0, 5 # v0 = 5r
  srl $t0, $a0, 8 # put green into lowest byte
  andi $t0, $t0, 0xFF # and mask for green
  mul $t0, $t0, 9 # 9g
  addu $v0, $v0, $t0 # v0 = 5r + 9g
  andi $t0, $a0, 0xFF # and mask for blue
  mul $t0, $t0, 2 # 2b
  addu $v0, $v0, $t0 # v0 = 5r + 9g + 2b 
subEnd:
  divu $v0, $v0, 16  # (5r + 9g + 2b) / 16. this is the value we want in each channel
  mul $v0, $v0, 0x00010101 # specific word multiple will copy y across all three colour channels
  addu $v0, $v0, 0xFF000000 # add FF alpha
  jr $ra             # return after subroutine end

# YOUR CODE ENDS HERE
# ----------------------------------------------------------------

.include "Lab-7b-Tests.asm"
