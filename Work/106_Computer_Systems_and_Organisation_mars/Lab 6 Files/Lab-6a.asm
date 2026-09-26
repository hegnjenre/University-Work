# --------------------------------
# CS106 Practical Assignment 6(a)
# Multiplication by shifting and adding
# --------------------------------

# sample input data

.data
A:    .half 99 101
.text
      la    $a0, A
      la    $a1, A+2

CodeToTest:                   # label for running tests
# ----------------------------------------------------------------
# Multiply the 16-bit numbers at the addresses in $a0 and $a1.
# Place the result in $v0.
# Do not use mul or div.
# ----------------------------------------------------------------
# YOUR CODE STARTS HERE

la $s0, A      # s0 -> A
lh $a0, ($s0)  # a0 = 99 (M)
lh $a1, 2($s0) # a1 = 101 (Q)
# v0 = 0 (A)

mulLoop:
  beqz $a1, end # (a1 == 0) -> end
  and $a2, $a1, 0x0000000F # a2 = lsb of a1
  beq $a2, 1, Adding # (a2 == 00000001) -> Adding
  j endAdd
Adding:
  addu $v0, $v0, $a0 # A = A + M
endAdd:
  sll $a0, $a0, 1    # shift M left by 1
  srl $a1, $a1, 1    # shift q right by 1
  j mulLoop
end:
move $a0, $v0
li $v0, 1
syscall 


# YOUR CODE ENDS HERE
# ----------------------------------------------------------------

# UNCOMMENT THE FOLLOWING LINE TO TEST YOUR CODE
#.include "Lab-6a-Tests.asm"
