# assume a word is given in $a0 and a bit position in $a1
extractionSR:
  li $a2, 0x00000001 # original mask
extract:
  bgtu $a1, 31, outRange  # branch to outRange if greater than largest bit position
  bltu $a1, 0, outRange   # branch to outRange if less than smallest bit position
  sllv $a2, $a2, $a1      # shift default mask left 
  and $a0, $a0, $a2       # and mask to extract bit in that shifted position and place back in a0
  j inRange               # jump to fall off to avoid break

outRange:
  break                   # break if out of range, error

inRange:
  j exitSR