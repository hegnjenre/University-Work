.data
   Array: .half 0xBEED, 0xFEED, 0X3E00, 0X0DCA, 0x0007, 0x0012
   i: .byte 4
   # general stores:      A[i] = t1,   x = a0,   i = s0
.text
  la $t0, Array # t0 -> Array
  lbu $s0, i # s0 = i
main:
  add $t0, $t0, $s0 # t1 = t1 + s0, pointer = pointer + i. t1 = A[i]
  lhu $a0, ($t0) # x = A[i], i(t0). a0 = x
  li $s1, 0x00000001 # loading and mask to check if even
  and $s1, $a0, $s1 # and masking to check if even, if s1 = 0x00000001 then a0 is odd
  beq $s1, 0x0000001, odd # branch to odd if not even
  subiu $a1, $a0, 1 # loading x - 1
  sh $a1, ($t0) # storing x - 1 in A[i], A[i] = x-1
  j end # for the else part of else if you can't continue to the other if statements, so jumos to end
  
odd:
  bgtu $a0, 10, moreThan # jump to morethan if x > 10
  li $a1, 0 # loading 0
  sh $a1, ($t0) # store 0 in A[i], A[i] = 0
  j end # else if
  
moreThan:
  add $t0, $t0, 2 # incrementing for A[i+1], the +1 in high level means the next entry, which for a half word array means adding 2
  mul $a1, $a0, 2 # loading x*2
  sh $a1, ($t0) # store 0 in A[i], A[i] = 0

end:
li $v0, 10 # terminate syscall
syscall
