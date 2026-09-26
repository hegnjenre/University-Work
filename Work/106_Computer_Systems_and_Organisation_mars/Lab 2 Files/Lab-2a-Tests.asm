# --------------------------------
# CS106 Practical 2(a) Test Data
# Pointers
# --------------------------------

.data

.eqv	NUMTESTS	5	# number of tests
.eqv	NUMMEMARGS	0	# number of arguments in memory
.eqv	MEMARGLOC	0	# location of arguments in memory
.eqv	MEMARGSIZE	0	# size of memory argument
.eqv	NUMREGARGS	2	# number of arguments in $aN registers
.eqv	NUMREGRES	0	# number of results in $vN registers (0: result in memory)
.eqv	ARGFORMAT	31	# pointer to word
.eqv	RESFORMAT	31	# pointer to word
.eqv	FUNTEST	0	# testing subroutine?

Z_Buffer:	.word		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0

Z_TestStr0:	.asciiz 	"value in 1st address = "
Z_TestStr1:	.asciiz	"; value in 2nd address = "
Z_TestStr2:	.asciiz	"\n"
Z_TestStrs:	.word 	Z_TestStr0 Z_TestStr1 Z_TestStr2


Z_TestData:			# arguments followed by results

	.word	Z_TestP1 Z_TestQ1 Z_TestR1
	.word	Z_TestP2 Z_TestQ2 Z_TestR2
	.word	Z_TestP3 Z_TestP3 Z_TestR3
	.word	Z_TestP4 Z_TestQ4 Z_TestR4
	.word	Z_TestP5 Z_TestQ5 Z_TestR5
	
Z_TestP1:	.word	6
Z_TestQ1:	.word	7
Z_TestR1:	.word	42
Z_TestP2:	.word	666
Z_TestQ2:	.word	777
Z_TestR2:	.word	517482
Z_TestP3:	.word	-1
Z_TestR3:	.word	1
Z_TestP4:	.word	999999
Z_TestQ4:	.word	0
Z_TestR4:	.word	0
Z_TestP5:	.word	31416
Z_TestQ5:	.word	-27183
Z_TestR5:	.word	-853981128

.include "RunTest.asm"
