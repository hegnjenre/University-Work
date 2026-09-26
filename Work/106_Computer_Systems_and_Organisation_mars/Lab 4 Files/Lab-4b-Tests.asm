# --------------------------------
# CS106 Practical 4(b) Test Data
# Making a string uppercase
# --------------------------------

.data

.eqv	NUMTESTS	5	# number of tests
.eqv	NUMMEMARGS	0	# number of arguments in memory
.eqv	MEMARGLOC	0	# location of arguments in memory
.eqv	MEMARGSIZE	0	# size of memory argument
.eqv	NUMREGARGS	1	# number of arguments in $aN registers
.eqv	NUMREGRES	0	# number of results in $vN registers (0: result in memory)
.eqv	ARGFORMAT	4	# pointer to string
.eqv	RESFORMAT	4	# pointer to string
.eqv	FUNTEST	0	# testing subroutine?

Z_Buffer:	.word		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0

Z_TestStr0:	.asciiz 	"Input \""
Z_TestStr1:	.asciiz	"\"\n"
Z_TestStrs:	.word 	Z_TestStr0 Z_TestStr1


Z_TestData:			# arguments followed by results

	.word	Z_TestA1 Z_TestR1
	.word	Z_TestA2 Z_TestR2
	.word	Z_TestA3 Z_TestR3
	.word	Z_TestA4 Z_TestR4
	.word	Z_TestA5 Z_TestR5
	
Z_TestA1:	.asciiz	"\"To be, or not to be, that is the question.\""
Z_TestR1:	.asciiz	"\"TO BE, OR NOT TO BE, THAT IS THE QUESTION.\""
Z_TestA2:	.asciiz	"0123456789 TEN !#$%&'()*+,-./:<=>?@[]^_`{|}~"
Z_TestR2:	.asciiz	"0123456789 TEN !#$%&'()*+,-./:<=>?@[]^_`{|}~"
Z_TestA3:	.asciiz	"oo110011OO11ii00OOooiiII11"
Z_TestR3:	.asciiz	"OO110011OO11II00OOOOIIII11"
Z_TestA4:	.asciiz	""
Z_TestR4:	.asciiz	""
Z_TestA5:	.asciiz	"x^2 > 0 for all real x != 0."
Z_TestR5:	.asciiz	"X^2 > 0 FOR ALL REAL X != 0."

.include "RunTest.asm"
