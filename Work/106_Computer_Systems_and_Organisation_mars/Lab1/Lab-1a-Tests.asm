# --------------------------------
# CS106 Practical 1(a) Test Data
# a + 2b + 3c
# --------------------------------

.data

.eqv	NUMTESTS	5	# number of tests
.eqv	NUMMEMARGS	3	# number of arguments in memory
.eqv	MEMARGLOC	A	# location of arguments in memory
.eqv	MEMARGSIZE	4	# size of memory argument
.eqv	NUMREGARGS	0	# number of arguments in $aN registers
.eqv	NUMREGRES	1	# number of results in $vN registers (0: result in memory)
.eqv	ARGFORMAT	1	# decimal number
.eqv	RESFORMAT	1	# decimal number
.eqv	FUNTEST	0	# testing subroutine?

Z_Buffer:	.word		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0

Z_TestStr0:	.asciiz 	"Evaluating "
Z_TestStr1:	.asciiz 	" + 2*"
Z_TestStr2:	.asciiz 	" + 3*"
Z_TestStr3:	.asciiz 	" ...\n"
Z_TestStrs:	.word 	Z_TestStr0 Z_TestStr1 Z_TestStr2 Z_TestStr3

Z_TestData:			# arguments followed by results

	.word 1, 2, 3, 14
	.word -6, 1, 1, -1
	.word 123, -234, 345, 690
	.word -9876, 8765, -7654, -15308
	.word 1000, -350, -100, 0
	
.include "RunTest.asm"
