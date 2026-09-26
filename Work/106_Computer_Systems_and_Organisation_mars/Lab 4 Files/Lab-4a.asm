# --------------------------------
# CS106 Practical Assignment 4(a)
# Making a character uppercase
# --------------------------------

# sample input data

.data
X:    .asciiz "x"
.text
      la    $a0, X

CodeToTest:                   # label for running tests
# ----------------------------------------------------------------
# The address of an ASCII character will be in $a0. If the
# character is a lower case letter, replace it (in memory) with
# its upper case version. Otherwise don't change it.
# ----------------------------------------------------------------
# YOUR CODE STARTS HERE
li $s0, 97  #lower limit
li $s1, 124 #upper limit
lbu $t0, ($a0) # get unconverted value

bltu $t0, $s0, END # if t0 < s0 -> END
bgtu $t0, $s1, END # if t0 > s1 -> END

addi $t0, $t0, -32 # convert to uppercase
sb $t0, ($a0)      # store converted value back into a0

END:

# YOUR CODE ENDS HERE
# ----------------------------------------------------------------

# UNCOMMENT THE FOLLOWING LINE TO TEST YOUR CODE
.include "Lab-4a-Tests.asm"
