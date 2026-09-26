# --------------------------------
# CS106 Practical 7(a) Test Data
# Blending ARGB colours
# --------------------------------

.data

.eqv	NUMTESTS	5	# number of tests
.eqv	NUMMEMARGS	0	# number of arguments in memory
.eqv	MEMARGLOC	0	# location of arguments in memory
.eqv	MEMARGSIZE	0	# size of memory argument
.eqv	NUMREGARGS	2	# number of arguments in $aN registers
.eqv	NUMREGRES	1	# number of results in $vN registers (0: result in memory)
.eqv	ARGFORMAT	-8	# 8 hex digits
.eqv	RESFORMAT	-8	# 8 hex digits
.eqv	FUNTEST	1	# testing subroutine?
.eqv	CodeToTest	BlendARGB

Z_Buffer:	.word		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0

Z_TestStr0:	.asciiz 	"Blending "
Z_TestStr1:	.asciiz	" with "
Z_TestStr2:	.asciiz	" ...\n"
Z_TestStrs:	.word 	Z_TestStr0 Z_TestStr1 Z_TestStr2


Z_TestData:			# arguments followed by results

	.word	0xFF000000 0xFFFEDCBA 0xFF7F6E5D
	.word	0xFF012345 0xFFFFFFFF 0xFF8091A2
	.word	0xFF000080 0xFF7F0000 0xFF3F0040
	.word	0xFFFFFF00 0xFF007F00 0xFF7FBF00
	.word	0xFFEDCBA9 0xFF345678 0xFF909090
	
.include "RunTest.asm"
