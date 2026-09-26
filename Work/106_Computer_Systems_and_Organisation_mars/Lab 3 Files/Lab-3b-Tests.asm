# --------------------------------
# CS106 Practical 3(b) Test Data
# Bitfields: Modifying data
# --------------------------------

.data

.eqv	NUMTESTS	5	# number of tests
.eqv	NUMMEMARGS	6	# number of arguments in memory
.eqv	MEMARGLOC	A	# location of arguments in memory
.eqv	MEMARGSIZE	2	# size of memory argument
.eqv	NUMREGARGS	0	# number of arguments in $aN registers
.eqv	NUMREGRES	1	# number of results in $vN registers (0: result in memory)
.eqv	ARGFORMAT	-4	# 4 hex digits
.eqv	RESFORMAT	-8	# 8 hex digits
.eqv	FUNTEST	0	# testing subroutine?

Z_Buffer:	.word		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0

Z_TestStr0:	.asciiz 	"A[] = "
Z_TestStr1:	
Z_TestStr2:	
Z_TestStr3:	
Z_TestStr4:	
Z_TestStr5:	.asciiz 	" "
Z_TestStr6:	.asciiz 	"\n"
Z_TestStrs:	.word 	Z_TestStr0 Z_TestStr1 Z_TestStr2 Z_TestStr3 
				Z_TestStr4 Z_TestStr5 Z_TestStr6


Z_TestData:			# arguments followed by results

	.half	0x6573 0x3AA2 0x73B4 0x682C 0x0B0E 0x3EEF
	.word	0x3ABA 
	.half 0x0011 0x57A3 0x736F 0x7AA5 0x1ACE 0x6B54
	.word 0x5453 
	.half	0x748F 0x6807 0x4872 0x68B3 0x3FFF 0x641F
	.word	0x6EFF 
	.half	0x0000 0x0FF8 0x1AAA 0x6666 0x3333 0x1111
	.word 0x0898 
	.half	0x07F8 0x189A 0x6CDD 0x7634 0x6535 0x7807	
	.word 0x189A 

.include "RunTest.asm"
