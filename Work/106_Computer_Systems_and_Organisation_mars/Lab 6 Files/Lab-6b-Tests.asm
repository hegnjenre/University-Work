# --------------------------------
# CS106 Practical 6(b) Test Data
# Vector dot product by shifting and adding
# --------------------------------

.data

.eqv	NUMTESTS	5	# number of tests
.eqv	NUMMEMARGS	0	# number of arguments in memory
.eqv	MEMARGLOC	0	# location of arguments in memory
.eqv	MEMARGSIZE	0	# size of memory argument
.eqv	NUMREGARGS	3	# number of arguments in $aN registers
.eqv	NUMREGRES	1	# number of results in $vN registers (0: result in memory)
.eqv	ARGFORMAT	121	# array of halfwords (length in $a2)
.eqv	RESFORMAT	1	# decimal
.eqv	FUNTEST	0	# testing subroutine?

Z_Buffer:	.word		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0

Z_TestStr0:	.asciiz 	"Input: "
Z_TestStr1:	.asciiz	" . "
Z_TestStr2:	.asciiz	". Length = "
Z_TestStr3:	.asciiz	".\n"
Z_TestStrs:	.word 	Z_TestStr0 Z_TestStr1 Z_TestStr2 Z_TestStr3


Z_TestData:			# arguments followed by results

	.word	Z_Test1A1 Z_Test1A2 8
	.word 16
	.word	Z_Test2A1 Z_Test2A2 5
	.word 54321
	.word	Z_Test3A1 Z_Test3A2 8
	.word 163
	.word	Z_Test4A1 Z_Test4A2 4
	.word -65534
	.word	Z_Test5A1 Z_Test5A2 11
	.word 0

Z_Test1A1:	.half 1 0 1 0 1 0 1 0
Z_Test1A2:	.half 1 2 3 4 5 6 7 8
Z_Test2A1:	.half 1 4 15 80 250
Z_Test2A2:	.half 1 5 20 50 200
Z_Test3A1:	.half  2 -3   5  -7 11 -13  17 -19
Z_Test3A2:	.half 23 29 -31 -37 41  43 -47 -53
Z_Test4A1:	.half 32767 -32768  32767 32767
Z_Test4A2:	.half 32767  32767 -32768 32767
Z_Test5A1:	.half 25 -3 -93 -16 -39  19 91 32 34   9 -54
Z_Test5A2:	.half 61 50  97  -4  -2 -21 23 13 30 -84 -95

.include "RunTest.asm"
