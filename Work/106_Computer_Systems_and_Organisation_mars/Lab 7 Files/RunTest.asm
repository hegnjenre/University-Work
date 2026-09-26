# --------------------------------
# CS106 Practical Assignment Test Harness
# David Bevan - December 2019
# --------------------------------

# --------------------------------
# terminate cleanly
# --------------------------------
.macro Done()
      li    $v0, 10
      syscall
.end_macro

# --------------------------------
# exit cleanly with return value
# --------------------------------
.macro Exit(%retval)
      li    $a0, %retval
      li    $v0, 17
      syscall
.end_macro

# --------------------------------
# save temporaries
# --------------------------------
.macro BeforeCall()
      add   $sp, $sp, -20
      sw    $t0, 0($sp)
      sw    $t1, 4($sp)
      sw    $t2, 8($sp)
      sw    $a0, 12($sp)
      sw    $ra, 16($sp)
.end_macro

# --------------------------------
# restore temporaries
# --------------------------------
.macro AfterCall()
      lw    $t0, 0($sp)
      lw    $t1, 4($sp)
      lw    $t2, 8($sp)
      lw    $a0, 12($sp)
      lw    $ra, 16($sp)
      add   $sp, $sp, 20
.end_macro

# --------------------------------
# save syscall temporaries
# --------------------------------
.macro BeforeSyscall()
      add   $sp, $sp, -8
      sw    $a0, 0($sp)
      sw    $v0, 4($sp)
.end_macro

# --------------------------------
# restore syscall temporaries
# --------------------------------
.macro AfterSyscall()
      lw    $a0, 0($sp)
      lw    $v0, 4($sp)
      add   $sp, $sp, 8
.end_macro

# --------------------------------
# data formats
# --------------------------------
.eqv  HEXA8       -8    # 8 hex digits
.eqv  HEXA4       -4    # 4 hex digits
.eqv  HEXA2       -2    # 2 hex digits
.eqv  BOOLE       0     # Boolean
.eqv  DECIM       1     # decimal integer
.eqv  PSTRZ       4     # zero-terminated string (or character)
.eqv  PCHAR       11    # pointer to character
.eqv  PHALF       21    # pointer to halfword
.eqv  PUHLF       22    # pointer to unsigned halfword
.eqv	PWORD		31	# pointer to word
.eqv  AHALF       121   # array of halfwords (length in $a2)
.eqv  BTREE       124   # binary tree
.eqv  POIN3       333   # array of three points
.eqv  POIN9       999   # array of nine points

# --------------------------------
# print data item
# format as above
# --------------------------------
.macro PrintFmt(%n, %format)
      BeforeSyscall()
      add   $a0, $zero, %n                # a0 contains the object
      li    $v0, %format                  # v0 is its format
      BeforeCall()
      jal   Z_PrintFmt
      AfterCall()
      AfterSyscall()
.end_macro

# --------------------------------
# print decimal integer
# --------------------------------
.macro PrintInt(%n)
      BeforeSyscall()
      add   $a0, $zero, %n
      li    $v0, DECIM
      syscall
      AfterSyscall()
.end_macro

# --------------------------------
# print literal string
# --------------------------------
.macro PrintString(%s)
.data
Z_PrintString: .asciiz %s
.text
      BeforeSyscall()
      la    $a0, Z_PrintString
      li    $v0, PSTRZ
      syscall
      AfterSyscall()
.end_macro

# --------------------------------
# print string from memory at (%reg)
# --------------------------------
.macro PrintASCIIZ(%reg)
      BeforeSyscall()
      lw    $a0, (%reg)
      li    $v0, PSTRZ
      syscall
      AfterSyscall()
.end_macro

# --------------------------------
# put random number in %reg
# won't work for a0 or v0
# --------------------------------
.macro rand(%reg)
      BeforeSyscall()
      li    $v0, 41
      syscall
      move  %reg, $a0
      AfterSyscall()
.end_macro

# --------------------------------
# put random number in a0
# *** also clobbers v0 ***
# --------------------------------
.macro randa0()
      li    $v0, 41
      syscall
      xori  $v0, $a0, 0xBADC0DE5
.end_macro

.data
# stores for clobber check values
Z_ClobGP:   .word 0
Z_ClobSP:   .word 0
Z_ClobFP:   .word 0
Z_ClobSN:   .word 0
.text
# --------------------------------
# clobber registers
# --------------------------------
.macro clobber()
      rand($v1)
      rand($t0)
      rand($t1)
      rand($t2)
      rand($t3)
      rand($t4)
      rand($t5)
      rand($t6)
      rand($t7)
      rand($t8)
      rand($t9)
      rand($s0)
      sw    $s0, Z_ClobSN
      lw    $s1, 20($sp)            # trash expected results on stack
      lw    $s2, 12($sp)
      xor   $s1, $s1, $s0           # using random value in Z_ClobSN
      xor   $s2, $s2, $s1
      sw    $s2, 20($sp)
      sw    $s1, 12($sp)
      move  $s1, $s0
      move  $s2, $s0
      move  $s3, $s0
      move  $s4, $s0
      move  $s5, $s0
      move  $s6, $s0
      move  $s7, $s0
      sw    $gp, Z_ClobGP           # save pointer register values
      sw    $sp, Z_ClobSP
      sw    $fp, Z_ClobFP
.end_macro

.data
Z_RegNames: .asciiz     "$s0" "$s1" "$s2" "$s3" "$s4" "$s5" "$s6" "$s7" "$gp" "$sp" "$fp" "$ra"
.text
# --------------------------------
# check whether register clobbered
# reg name is placed in $t4
# --------------------------------
.macro ClobberCheck(%retaddr)
      li    $t8, FUNTEST            # if not testing a function, don't check $sN
      beqz  $t8, Z_ClobberCheckPtrs
      lw    $t8, Z_ClobSN
      la    $t4, Z_RegNames
      bne   $s0, $t8, Z_FunOverwrite
      add   $t4, $t4, 4
      bne   $s1, $t8, Z_FunOverwrite
      add   $t4, $t4, 4
      bne   $s2, $t8, Z_FunOverwrite
      add   $t4, $t4, 4
      bne   $s3, $t8, Z_FunOverwrite
      add   $t4, $t4, 4
      bne   $s4, $t8, Z_FunOverwrite
      add   $t4, $t4, 4
      bne   $s5, $t8, Z_FunOverwrite
      add   $t4, $t4, 4
      bne   $s6, $t8, Z_FunOverwrite
      add   $t4, $t4, 4
      bne   $s7, $t8, Z_FunOverwrite
Z_ClobberCheckPtrs:
      la    $t4, Z_RegNames
      add   $t4, $t4, 32
      lw    $t8, Z_ClobGP
      bne   $gp, $t8, Z_FunOverwrite
      add   $t4, $t4, 4
      lw    $t8, Z_ClobSP
      bne   $sp, $t8, Z_FunOverwrite
      add   $t4, $t4, 4
      lw    $t8, Z_ClobFP
      bne   $fp, $t8, Z_FunOverwrite
      add   $t4, $t4, 4
      la    $t8, %retaddr
      bne   $ra, $t8, Z_FunOverwrite
      lw    $s0, Z_ClobSN
      lw    $s1, 20($sp)            # untrash expected results on stack
      lw    $s2, 12($sp)
      xor   $s1, $s1, $s2
      xor   $s2, $s2, $s0
      sw    $s2, 20($sp)
      sw    $s1, 12($sp)
.end_macro

.data
Z_Count:    .word 0                 # count
.text
# --------------------------------
# counter
# --------------------------------
.macro counter()
      lw    $t0, Z_Count            # increment count
      add   $t0, $t0, 1
      sw    $t0, Z_Count
      rand($v1)
      rand($a1)
      rand($a2)
      rand($a3)
      rand($t0)
      rand($t1)
      rand($t2)
      rand($t3)
      rand($t4)
      rand($t5)
      rand($t6)
      rand($t7)
      rand($t8)
      rand($t9)
      randa0()
.end_macro

.data
Z_InTests:  .word 0                 # are tests running?
.text

# **********************************
# TEST HARNESS EXECUTION STARTS HERE
# **********************************

      li    $t0, FUNTEST            # if testing a function, we shouldn't be here!
      bnez  $t0, Z_FunNoReturn
      lw    $t0, Z_InTests          # otherwise, it's OK
      li    $t1, 1
      sw    $t1, Z_InTests          # InTests = true
      beqz  $t0, Z_StartTests       # if first time, start tests
      jr    $ra                     # else return from CodeToTest

Z_StartTests:

# START OF TEST LOOP

      PrintString("CS106 Practical Assignment Test Harness\n\nRunning ")
      PrintInt(NUMTESTS)
      PrintString(" tests ...\n\n")

      li    $t0, 1                  # t0: test number (1 .. NUMTESTS)
      la    $t2, Z_TestData         # t2: address of test data arg or result
      li    $t6, 0                  # t6: score

Z_NextTest:

      # show test number
      PrintString("Test ")
      PrintInt($t0)
      PrintString(":  ")

# START OF MEM ARG LOOP

      # copy and show arguments
      li    $t1, 0                  # t1: mem arg num (0 .. NUMMEMARGS - 1)
      la    $t3, MEMARGLOC          # t3: address for arg
      la    $t4, Z_TestStrs         # t4: address for message string pointers

      # show initial string
      PrintASCIIZ($t4)
      add   $t4, $t4, 4

Z_NextMemArg:

      # exit loop if done
      beq   $t1, NUMMEMARGS, Z_MemArgsDone

      # copy arg
      li    $t8, MEMARGSIZE         # t8: offset into jump table
      and   $t8, $t8, 0x06          #   1 -> 0, 2 -> 2, 4 -> 4
      mul   $t8, $t8, 6             #   1 -> 0, 2 -> 12, 4 -> 24
      la    $t9, Z_CopyArg          # t9: jump address
      add   $t9, $t9, $t8
      jr    $t9

Z_CopyArg:

      lbu   $t5, ($t2)              # t5 = copy byte from ($t2)
      sb    $t5, ($t3)              # copy to ($t3)
      j     Z_ArgCopied
      lhu   $t5, ($t2)              # t5 = copy half from ($t2)
      sh    $t5, ($t3)              # copy to ($t3)
      j     Z_ArgCopied
      lw    $t5, ($t2)              # t5 = copy word from ($t2)
      sw    $t5, ($t3)              # copy to ($t3)

Z_ArgCopied:

      add   $t2, $t2, MEMARGSIZE
      add   $t3, $t3, MEMARGSIZE

      # show arg and next string
      PrintFmt($t5, ARGFORMAT)
      PrintASCIIZ($t4)
      add   $t4, $t4, 4

      add   $t1, $t1, 1             # increment arg num
      j     Z_NextMemArg            # loop

# END OF MEM ARG LOOP

Z_MemArgsDone:

      # handle register arguments
      randa0()
      rand($a1)
      rand($a2)
      rand($a3)
      li    $t1, NUMREGARGS
      blt   $t1, 3, Z_RegArgs
      lw    $a2, 8($t2)             # load AHALF array length before array pointers

Z_RegArgs:

      beq   $t1, 0, Z_RegArgsDone   # done if no register args
      lw    $a0, ($t2)              # a0 = arg1
      add   $t2, $t2, 4
      PrintFmt($a0, ARGFORMAT)      # show arg and next string
      PrintASCIIZ($t4)
      add   $t4, $t4, 4
      beq   $t1, 1, Z_RegArgsDone   # done if only 1 register arg
      lw    $a1, ($t2)              # a1 = arg2
      add   $t2, $t2, 4
      PrintFmt($a1, ARGFORMAT)      # show arg and next string
      PrintASCIIZ($t4)
      add   $t4, $t4, 4
      beq   $t1, 2, Z_RegArgsDone   # done if only 2 register args
      lw    $a2, ($t2)              # a2 = arg3
      add   $t2, $t2, 4
      PrintInt($a2)                 # show arg (always decimal) and next string
      PrintASCIIZ($t4)
      add   $t4, $t4, 4

Z_RegArgsDone:

      # show expected result
      PrintString("Expected result ")
      lw    $t5, ($t2)              # t5: expected result 1
      rand($t3)                     # trash it in memory (so student code can't find it)
      sw    $t3, ($t2)
      add   $t2, $t2, 4
      PrintFmt($t5, RESFORMAT)

      li    $t1, NUMREGRES          # t1: number of register results
      ble   $t1, 1, Z_ExpecResDone  # done if only one result

      lw    $t7, ($t2)              # t7: expected result 2
      rand($t3)                     # trash it in memory
      sw    $t3, ($t2)
      add   $t2, $t2, 4
      PrintString(" ")
      li    $t8, FUNTEST
      bne   $t8, -1, Z_ExpecRes2
      PrintString("count=")

Z_ExpecRes2:

      PrintFmt($t7, RESFORMAT)

Z_ExpecResDone:

      PrintString(".  ")
      li    $t9, RESFORMAT          # t9: result format
      bne   $t9, PSTRZ, Z_CallCode  # add newline after string
      PrintString("\n")

Z_CallCode:

      sw    $0, Z_Count             # reset count

      # ----------------------------------------------------------------
      # call routine to test
      move  $fp, $sp                # set $fp for clobber check
      li    $gp, 0x10010000         # set $gp for clobber check
      add   $sp, $sp, -32           # save registers
      sw    $t0, 0($sp)             # -- test number
      sw    $t1, 4($sp)             # -- number of register results
      sw    $t2, 8($sp)             # -- test data pointer
      sw    $t5, 12($sp)            # -- expected result 1
      sw    $t6, 16($sp)            # -- score
      sw    $t7, 20($sp)            # -- expected result 2
      sw    $t9, 24($sp)            # -- result format
      sw    $a0, 28($sp)            # -- result address if in memory
      clobber()
      jal   CodeToTest
Z_Return:
      ClobberCheck(Z_Return)
      lw    $t0, 0($sp)             # restore registers
      lw    $t1, 4($sp)
      lw    $t2, 8($sp)
      lw    $t5, 12($sp)
      lw    $t6, 16($sp)
      lw    $t7, 20($sp)
      lw    $t9, 24($sp)
      lw    $a0, 28($sp)
      add   $sp, $sp, 32
      # ----------------------------------------------------------------

      bnez  $t1, Z_ShowRes          # if result in memory,
      move  $v0, $a0                #   load result address

Z_ShowRes:

      # show actual result
      PrintString("Received result ")
      PrintFmt($v0, RESFORMAT)

      ble   $t1, 1, Z_ShowResDone   # done if only one result
      PrintString(" ")

      li    $t8, FUNTEST
      bne   $t8, -1, Z_ShowRes2     # if FUNTEST == -1
      lw    $v1, Z_Count            #   load counter into v1
      PrintString("count=")

Z_ShowRes2:

      PrintFmt($v1, RESFORMAT)

Z_ShowResDone:

      PrintString(".  ")

      # compare expected and actual result
      beq   $t9, PSTRZ, Z_CheckStr  # if result format is PSTRZ, compare strings
      bne   $t9, PCHAR, Z_CheckPWrd # if result format is PCHAR,
      lbu   $t5, ($t5)              #   load expected result byte
      lbu   $v0, ($v0)              #   load result byte

Z_CheckPWrd:

      bne   $t9, PWORD, Z_CheckWord # if result format is PWORD,
      lw    $t5, ($t5)              #   load expected result word
      lw    $v0, ($v0)              #   load result word

Z_CheckWord:

      bne   $v0, $t5, Z_CheckBad    # branch if 1st result incorrect
      ble   $t1, 1, Z_CheckGood     # done if only one result
      bne   $v1, $t7, Z_CheckBad    # branch if 2nd result incorrect

Z_CheckGood:

      add   $t6, $t6, 1             # increment score
      PrintString("CORRECT!\n")
      j     Z_CheckDone

Z_CheckStr:

      move  $a0, $v0                # move strings
      move  $a1, $t5
      BeforeCall()
      jal   Z_StrCmp
      AfterCall()
      beqz  $v0, Z_CheckGood        # v0 is zero if strings match

Z_CheckBad:

      PrintString("Incorrect.\n")

Z_CheckDone:

      # if not last test, loop
      add   $t0, $t0, 1             # increment test number
      ble   $t0, NUMTESTS, Z_NextTest

# END OF TEST LOOP

      # show score
      PrintString("\nTOTAL SCORE: ")
      PrintInt($t6)
      PrintString(" out of ")
      PrintInt(NUMTESTS)
      PrintString(".  ")

      # show success
      bne   $t6, NUMTESTS, Z_NoSuccess
      PrintString("Congratulations!")

Z_NoSuccess:

      PrintString("\n")
      Done()

Z_FunNoReturn:

      PrintString("\n\n\tERROR: No return from subroutine at ")
      j     Z_ErrExit

Z_FunOverwrite:

      PrintString("\n\n\tERROR: Register ")
      move  $a0, $t4
      li    $v0, PSTRZ
      syscall
      PrintString(" overwritten by subroutine at ")

Z_ErrExit:

      la    $a0, CodeToTest         # show address
      li    $v0, 34
      syscall
      PrintString(". Execution aborted.\n")
      Exit(-1)

# --------------------------------
# Z_PrintHex
# print -$v0 digits of $a0 in hex
# --------------------------------
Z_PrintHex:

      move  $t0, $a0                # t0 = n
      neg   $t2, $v0                # calculate mask shift in t2
      sub   $t2, $t2, 1
      sll   $t2, $t2, 2
      li    $t1, 0x0F               # t1 = mask
      sllv  $t1, $t1, $t2           # shift mask left

Z_HexLoop:

      and   $a0, $t0, $t1           # apply mask in a0
      srlv  $a0, $a0, $t2           # and shift
      add   $a0, $a0, 0x30          # determine hex digit
      blt   $a0, 0x3A, Z_HexDigitShow
      add   $a0, $a0, 0x07

Z_HexDigitShow:

      li    $v0, PCHAR              # print digit
      syscall

      srl   $t1, $t1, 4             # shift mask right
      sub   $t2, $t2, 4             # and decrement mask shift
      bnez  $t1, Z_HexLoop          # loop if not done

      jr    $ra                     # return

# --------------------------------
# Z_PrintAHalf
# print an array of $a2 halfwords from $a0
# --------------------------------
Z_PrintAHalf:

      move  $t0, $a2                # t0 = length
      PrintString("(")
      beqz  $t0, Z_AHalfDone        # handle length zero

Z_AHalfLoop:

      lh    $t1, ($a0)              # t1 = halfword
      add   $a0, $a0, 2
      PrintInt($t1)
      sub   $t0, $t0, 1             # decrement count and break if done
      beqz  $t0, Z_AHalfDone
      PrintString(", ")
      j     Z_AHalfLoop             # loop

Z_AHalfDone:

      PrintString(")")
      jr    $ra

# --------------------------------
# Z_PrintTriang
# print a triangle from $a0
# --------------------------------
Z_PrintTriang:

      li    $t0, 3            # number of points

Z_TriangLoop:

      PrintString("(")
      lw    $t1, ($a0)
      PrintInt($t1)           # x-coord
      PrintString(",")
      lw    $t1, 4($a0)
      PrintInt($t1)           # y-coord
      PrintString(") ")
      add   $a0, $a0, 8       # advance to next point
      sub   $t0, $t0, 1       # decrement count
      bnez  $t0, Z_TriangLoop # loop
      jr    $ra               # return

.data
Z_OpNames:  .asciiz     "+-*/"
.text
# --------------------------------
# Z_PrintBTree
# print binary expression tree from $a0
# --------------------------------
Z_PrintBTree:

      lw    $t1, 4($a0)             # t1: left
      beqz  $t1, Z_BTreeInt         # if left is NULL, op is integer

      add   $sp, $sp, -8
      sw    $ra, ($sp)
      sw    $a0, 4($sp)

      PrintString("(")
      move  $a0, $t1
      jal   Z_PrintBTree            # print left
      lw    $a0, 4($sp)             # restore a0
      lw    $t0, ($a0)              # t0: op
      la    $t2, Z_OpNames
      add   $t2, $t2, $t0
      PrintString(" ")
      PrintFmt($t2, PCHAR)
      PrintString(" ")
      lw    $a0, 8($a0)
      jal   Z_PrintBTree            # print right
      PrintString(")")

      lw    $ra, ($sp)
      lw    $a0, 4($sp)
      add   $sp, $sp, 8
      jr    $ra

Z_BTreeInt:

      lw    $t0, ($a0)              # t0: integer
      PrintInt($t0)
      jr    $ra

# --------------------------------
# Z_PrintFmt
# print object $a0 with format $v0
# --------------------------------
Z_PrintFmt:

      bltz  $v0, Z_PrintFmtHex            # if HEXAk, print k hex digits
      beq   $v0, AHALF, Z_PrintFmtAHalf   # if AHALF, print array of halfwords
      beq   $v0, BTREE, Z_PrintFmtBTree   # if BTREE, print binary expression tree
      beq   $v0, POIN3, Z_PrintFmtTriang  # if POIN3, print triangle
      beq   $v0, POIN9, Z_PrintFmtTriang3 # if POIN9, print three triangles
      beq   $v0, BOOLE, Z_PrintFmtBool    # if BOOLE, print "FALSE" or "TRUE"
      beq   $v0, PSTRZ, Z_PrintFmtPStr    # if PSTRZ, handle CHAR
	blt	$v0, PCHAR, Z_PrintFmtNow	# go for it if not PCHAR/PHALF/PUHLF/PWORD
	beq	$v0, PCHAR, Z_PrintFmtPChar	# if PCHAR, load character and print
	beq	$v0, PWORD, Z_PrintFmtWord    # if PWORD, load word
	beq	$v0, PUHLF, Z_PrintFmtUHalf   # if PUHLF, load unsigned halfword
	lh	$a0, ($a0)				# PHALF: load signed halfword
	j	Z_PrintFmtAsDecim
Z_PrintFmtUHalf:
	lhu	$a0, ($a0)				# PUHLF: load unsigned halfword	
	j	Z_PrintFmtAsDecim
Z_PrintFmtWord:
	lw	$a0, ($a0)				# PWORD: load word	
Z_PrintFmtAsDecim:
      li    $v0, DECIM                    #   and print as decimal
      j     Z_PrintFmtNow
Z_PrintFmtBool:
      beqz  $a0, Z_PrintFmtFalse
      PrintString("TRUE")
      j     Z_PrintFmtDone
Z_PrintFmtFalse:
      PrintString("FALSE")
      j     Z_PrintFmtDone
Z_PrintFmtPStr:
      bgtu  $a0, 0x7F, Z_PrintFmtNow      # it really is a string
      li    $v0, PCHAR                    # it's actually a character
      j     Z_PrintFmtNow
Z_PrintFmtPChar:
      lbu   $a0, ($a0)                    # PCHAR: load character
Z_PrintFmtNow:
      syscall
      j     Z_PrintFmtDone
Z_PrintFmtHex:
      BeforeCall()
      jal   Z_PrintHex
      AfterCall()
      j     Z_PrintFmtDone
Z_PrintFmtAHalf:
      BeforeCall()
      jal   Z_PrintAHalf
      AfterCall()
      j     Z_PrintFmtDone
Z_PrintFmtBTree:
      BeforeCall()
      jal   Z_PrintBTree
      AfterCall()
      j     Z_PrintFmtDone
Z_PrintFmtTriang3:
      BeforeCall()
      jal   Z_PrintTriang
      AfterCall()
      PrintString("; ")
      add   $a0, $a0, 24
      BeforeCall()
      jal   Z_PrintTriang
      AfterCall()
      PrintString("; ")
      add   $a0, $a0, 24                  # fall through to print third triangle
Z_PrintFmtTriang:
      BeforeCall()
      jal   Z_PrintTriang
      AfterCall()
Z_PrintFmtDone:
      jr    $ra

# --------------------------------
# Z_StrCmp
# Compare null-terminated strings at addresses a0 and a1.
# Return 0 in v0 if they match.
# --------------------------------
Z_StrCmp:

      lbu   $t0, ($a0)              # read characters
      lbu   $t1, ($a1)
      or    $v0, $t0, $t1           # are they both zero?
      beqz  $v0, Z_StrCmpDone       # succeed if so
      bne   $t0, $t1, Z_StrCmpDone  # fail if they differ
      add   $a0, $a0, 1             # loop for next char
      add   $a1, $a1, 1
      j     Z_StrCmp

Z_StrCmpDone:

      jr    $ra

# --------------------------------
# END OF FILE
# --------------------------------
