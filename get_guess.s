.data

.text
.globl get_guess
get_guess:
addiu	$sp,$sp,-20	#allocate space on the stack
sw	$ra,16($sp)	#save the return address
sw	$a0,20($sp)	#save the min
sw	$a1,24($sp)	#save the max
sw	$a2,28($sp)	#save the *question ??





jr	$ra	#return to guess_main