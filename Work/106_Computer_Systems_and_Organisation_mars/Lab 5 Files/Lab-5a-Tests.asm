# --------------------------------
# CS106 Practical 5(a) Test Data
# Unsigned overflow
# --------------------------------

.data

.eqv	NUMTESTS	5	# number of tests
.eqv	NUMMEMARGS	0	# number of arguments in memory
.eqv	MEMARGLOC	0	# location of arguments in memory
.eqv	MEMARGSIZE	0	# size of memory argument
.eqv	NUMREGARGS	2	# number of arguments in $aN registers
.eqv	NUMREGRES	1	# number of results in $vN registers (0: result in memory)
.eqv	ARGFORMAT	22	# pointer to unsigned halfword
.eqv	RESFORMAT	1	# decimal
.eqv	FUNTEST	0	# testing subroutine?

Z_Buffer:	.word		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0

Z_TestStr0:	.asciiz 	"Adding "
Z_TestStr1:	.asciiz	" to "
Z_TestStr2:	.asciiz	"  ...\n"
Z_TestStrs:	.word 	Z_TestStr0 Z_TestStr1 Z_TestStr2


Z_TestData:			# arguments followed by results

	.word	Z_TestNum3 Z_TestNum5 
	.word 8				# 3 + 5 = 8
	.word	Z_TestNum32767 Z_TestNum32768
	.word 65535				# 32767 + 32768 = 65535
	.word	Z_TestNum32768 Z_TestNum32768
	.word 0x80000000			# 32768 + 32768 overflows
	.word	Z_TestNum32768 Z_TestNum0
	.word 32768			      # 32768 + 0 = 32768
	.word	Z_TestNum1 Z_TestNum65535
	.word 0x80000000			# 1 + 65535 overflows

Z_TestNum0:		.half 0
Z_TestNum1:		.half 1
Z_TestNum3:		.half 3
Z_TestNum5:		.half 5
Z_TestNum32767:	.half 32767
Z_TestNum32768:	.half -32768
Z_TestNum65535:	.half -1

.include "RunTest.asm"
