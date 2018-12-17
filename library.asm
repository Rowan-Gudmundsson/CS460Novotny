
printInt1:
lw		$a0, -8($sp)		#
li		$v0, 1
syscall
jr		$ra					# jump to $ra

printFloat1:
s.s		$f12, -12($sp)		# Store $f12 just in case we're using it
l.s		$f12, -8($sp)		# Load output
li		$v0, 2
syscall
l.s		$f12, -12($sp)      # Then restore $f12 if it was used
jr		$ra					# jump to $ra


# TODO: printString1

printChar1:
lw		$a0, -8($sp)		#
li		$v0, 11
syscall
jr		$ra					# jump to $ra

readInt1:
li		$v0, 5
syscall
sw		$v0, -4($sp)
jr		$ra

readFloat1:
s.s		$f0, -12($sp)		# Store $f0 just in case we're using it
li		$v0, 6
syscall
s.s		$f0, -4($sp)
l.s		$f0, -12($sp)
jr		$ra

# TODO: readString1

readChar1:
li		$v0, 12
syscall
sw		$v0, -4($sp)
jr		$ra
