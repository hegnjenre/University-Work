# --------------------------------
# CS106 Practical Assignment 4(b)
# Making a string uppercase
# --------------------------------

# sample input data

.data
S:    .asciiz "Convert this string from lower to upper case!"
.text
      la    $a0, S

CodeToTest:                   # label for running tests
# ----------------------------------------------------------------
# The address of the first character of a null-terminated string
# will be in $a0. Convert the string to uppercase.
# ----------------------------------------------------------------
# YOUR CODE STARTS HERE

li $s0, 97  # lower limit
li $s1, 122 # upper limit

LOOP:
lbu $t0, ($a0) # get unconverted value
beqz $t0, END # go to end if current value is 0, because that is null terminate of string

bltu $t0, $s0, NONUPPER # if t0 < s0 -> NONUPPER
bgtu $t0, $s1, NONUPPER # if t0 > s1 -> NONUPPER

addi $t0, $t0, -32 # convert to uppercase
sb $t0, ($a0)      # store converted value back into a0
addi $a0, $a0, 1   # increment the current character in the address
j LOOP             # continue loop

NONUPPER: # if the character can't become uppercase: already uppercase, symbols, etc
addi $a0, $a0, 1   # increment the current character in the address
j LOOP             # continue loop

END:

# YOUR CODE ENDS HERE
# ----------------------------------------------------------------

# UNCOMMENT THE FOLLOWING LINE TO TEST YOUR CODE
.include "Lab-4b-Tests.asm"
