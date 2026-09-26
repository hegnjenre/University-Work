# --------------------------------
# CS106 Practical 2(b) Test Data
# Array indexing
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

Z_TestStr0:	.asciiz 	"A = "
Z_TestStr1:	.asciiz	"\n         B = "
Z_TestStr2:	.asciiz	"   [Length = "
Z_TestStr3:	.asciiz	"]\n"
Z_TestStrs:	.word 	Z_TestStr0 Z_TestStr1 Z_TestStr2 Z_TestStr3


Z_TestData:			# arguments followed by results

	.word	Z_Test1A1 Z_Test1A2 8
	.word 6
	.word	Z_Test2A1 Z_Test2A2 5
	.word 200
	.word	Z_Test3A1 Z_Test3A2 8
	.word 37
	.word	Z_Test4A1 Z_Test4A2 4
	.word 32767
	.word	Z_Test5A1 Z_Test5A2 11
	.word 0

Z_Test1A1:	.half 7 6 5 4 3 2 1 0
Z_Test1A2:	.half 0 1 2 3 4 5 6 7
Z_Test2A1:	.half 1 4 15 80 250
Z_Test2A2:	.half 1 5 20 50 200
Z_Test3A1:	.half  2  3  5  7 11 13 17 19
Z_Test3A2:	.half 23 29 31 37 41 43 47 53
Z_Test4A1:	.half     1     0     1     0
Z_Test4A2:	.half 32767 32766 32765 32764
Z_Test5A1:	.half 25 10 93 16 39 19 91 32 34  9 54
Z_Test5A2:	.half 61 50 97  4  2 21 23 13 30 84  0

.include "RunTest.asm"
