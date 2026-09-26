# --------------------------------
# CS106 Practical 1(b) Test Data
# a^2 + bx + c
# --------------------------------

.data

.eqv	NUMTESTS	5	# number of tests
.eqv	NUMMEMARGS	3	# number of arguments in memory
.eqv	MEMARGLOC	A	# location of arguments in memory
.eqv	MEMARGSIZE	4	# size of memory argument
.eqv	NUMREGARGS	1	# number of arguments in $aN registers
.eqv	NUMREGRES	1	# number of results in $vN registers (0: result in memory)
.eqv	ARGFORMAT	1	# decimal number
.eqv	RESFORMAT	1	# decimal number
.eqv	FUNTEST	0	# testing subroutine?

Z_Buffer:	.word		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0

Z_TestStr0:	.asciiz 	"Evaluating "
Z_TestStr1:	.asciiz 	"x^2 + "
Z_TestStr2:	.asciiz 	"x + "
Z_TestStr3:	.asciiz 	" at x = "
Z_TestStr4:	.asciiz 	" ...\n"
Z_TestStrs:	.word 	Z_TestStr0 Z_TestStr1 Z_TestStr2 Z_TestStr3 Z_TestStr4

Z_TestData:			# arguments followed by results

	.word 3, 2, 1, 4, 57
	.word -6, -4, 1, -1, -1
	.word 123, -234, 345, 5, 2250
	.word -1111, -4321, -3210, -3, -246
	.word 100, -600, -700, 7, 0
	
.include "RunTest.asm"
