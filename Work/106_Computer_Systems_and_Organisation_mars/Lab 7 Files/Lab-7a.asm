# --------------------------------
# CS106 Practical Assignment 7(a)
# Blending ARGB colours
# --------------------------------

.text

      j     Z_StartTests      # run tests

# ----------------------------------------------------------------
# BlendARGB
# Input:   a0 and a1: two ARGB colours
# Returns: v0: the blend of the input colours
# ----------------------------------------------------------------
# YOUR CODE STARTS HERE

BlendARGB:
  li $t3, 0          # loop index
  li $t0, 0x00FF0000 # t0 = and mask for red channel
  li $v0, 0xFF000000 # alpha FF
extractLoop:
  addi $t3, $t3, 1        # i++
  and $t1, $t0, $a0  # t1 = and-masked a0
  and $t2, $t0, $a1  # t2 = and-masked a1
  addu $t2, $t1, $t2 # t2 = added values
  divu $t2, $t2, 2   # v0 = average of two ARGB colours / the blend
  and $t2, $t2, $t0  # ensure no overflow to other channels
  addu $v0, $v0, $t2 # add average of channel to v0
  srl $t0, $t0, 8   # shift and mask for next channel
  bltu $t3, 4, extractLoop # loop if index < 4, 4 because it adds 1 at beginning of loop
subEnd:
  jr $ra             # return after subroutine end

# YOUR CODE ENDS HERE
# ----------------------------------------------------------------

.include "Lab-7a-Tests.asm"
