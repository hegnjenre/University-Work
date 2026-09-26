# --------------------------------
# CS106 Practical 7(b) Test Data
# Converting ARGB to greyscale
# --------------------------------

.data

.eqv	NUMTESTS	5	# number of tests
.eqv	NUMMEMARGS	0	# number of arguments in memory
.eqv	MEMARGLOC	0	# location of arguments in memory
.eqv	MEMARGSIZE	0	# size of memory argument
.eqv	NUMREGARGS	1	# number of arguments in $aN registers
.eqv	NUMREGRES	1	# number of results in $vN registers (0: result in memory)
.eqv	ARGFORMAT	-8	# 8 hex digits
.eqv	RESFORMAT	-8	# 8 hex digits
.eqv	FUNTEST	1	# testing subroutine?
.eqv	CodeToTest	GreyFromARGB

Z_Buffer:	.word		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0

Z_TestStr0:	.asciiz 	"Converting "
Z_TestStr1:	.asciiz	" to greyscale ...\n"
Z_TestStrs:	.word 	Z_TestStr0 Z_TestStr1


Z_TestData:			# arguments followed by results

	.word 0xFFABABAB 0xFFABABAB
	.word 0xFF00007F 0xFF0F0F0F
	.word 0xFFFFFF00 0xFFDFDFDF
	.word 0xFF123456 0xFF2D2D2D
	.word 0xFFF1A5C0 0xFFC0C0C0
	
.include "RunTest.asm"
