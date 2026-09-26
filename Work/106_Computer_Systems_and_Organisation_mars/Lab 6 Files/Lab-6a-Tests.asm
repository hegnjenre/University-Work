# --------------------------------
# CS106 Practical 6(a) Test Data
# Multiplication by shifting and adding
# --------------------------------

.data

.eqv	NUMTESTS	5	# number of tests
.eqv	NUMMEMARGS	0	# number of arguments in memory
.eqv	MEMARGLOC	0	# location of arguments in memory
.eqv	MEMARGSIZE	0	# size of memory argument
.eqv	NUMREGARGS	2	# number of arguments in $aN registers
.eqv	NUMREGRES	1	# number of results in $vN registers (0: result in memory)
.eqv	ARGFORMAT	21	# pointer to halfword
.eqv	RESFORMAT	1	# decimal
.eqv	FUNTEST	0	# testing subroutine?

Z_Buffer:	.word		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0

Z_TestStr0:	.asciiz 	"Multiplying "
Z_TestStr1:	.asciiz	" by "
Z_TestStr2:	.asciiz	"  ...\n"
Z_TestStrs:	.word 	Z_TestStr0 Z_TestStr1 Z_TestStr2


Z_TestData:			# arguments followed by results

	.word	Z_TestNum3 Z_TestNum5 
	.word 15				# 3 * 5
	.word	Z_TestNeg1000 Z_TestNum22222 
	.word -22222000			# -1000 * 22222
	.word	Z_TestNum11111 Z_TestNeg11111 
	.word -123454321			# 11111 * -11111
	.word	Z_TestNum9999 Z_TestNum0 
	.word 0				# 9999 * 0
	.word	Z_TestNum0 Z_TestNeg32768
	.word 0				# 0 * -32768

Z_TestNum22222:	.half 22222
Z_TestNum11111:	.half 11111 
Z_TestNum9999:	.half 9999 
Z_TestNum5:		.half 5
Z_TestNum3:		.half 3
Z_TestNum0:		.half 0
Z_TestNeg1000:	.half -1000 
Z_TestNeg11111:	.half -11111
Z_TestNeg32768:	.half -32768

.include "RunTest.asm"
