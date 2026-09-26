# --------------------------------
# CS106 Practical 4(a) Test Data
# Making a character uppercase
# --------------------------------

.data

.eqv	NUMTESTS	5	# number of tests
.eqv	NUMMEMARGS	0	# number of arguments in memory
.eqv	MEMARGLOC	0	# location of arguments in memory
.eqv	MEMARGSIZE	0	# size of memory argument
.eqv	NUMREGARGS	1	# number of arguments in $aN registers
.eqv	NUMREGRES	0	# number of results in $vN registers (0: result in memory)
.eqv	ARGFORMAT	11	# pointer to character
.eqv	RESFORMAT	11	# pointer to character
.eqv	FUNTEST	0	# testing subroutine?

Z_Buffer:	.word		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0

Z_TestStr0:	.asciiz 	"input = "
Z_TestStr1:	.asciiz	"\n"
Z_TestStrs:	.word 	Z_TestStr0 Z_TestStr1


Z_TestData:			# arguments followed by results

	.word	Z_TestA1 Z_TestR1
	.word	Z_TestA2 Z_TestR2
	.word	Z_TestA3 Z_TestR3
	.word	Z_TestA4 Z_TestR4
	.word	Z_TestA5 Z_TestR5
	
Z_TestA1:	.asciiz	"a"
Z_TestR1:	.asciiz	"A"
Z_TestA2:	.asciiz	"!"
Z_TestR2:	.asciiz	"!"
Z_TestA3:	.asciiz	"Q"
Z_TestR3:	.asciiz	"Q"
Z_TestA4:	.asciiz	"~"
Z_TestR4:	.asciiz	"~"
Z_TestA5:	.asciiz	"z"
Z_TestR5:	.asciiz	"Z"

.include "RunTest.asm"
