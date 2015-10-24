.data

.text
.globl get_guess
get_guess:
	addiu	$sp,$sp,-32		#allocate space on the stack
	sw	$ra,12($sp)		#save the return address
	sw	$a0,16($sp)		#save the min
	sw	$a1,20($sp)		#save the max
	sw	$s0,24($sp)		#save the *question
	sw	$s1,28($sp)		#save the target number	
 
beginGuess: 
	la	$a0,14($sp)		#$s0 = cat'd question
 	jal	MessageDialog
 	jal	InputDialogString
 	move	$a0,$v0			#user input stored here as string
 	jal	axtoi			#convert returned string to integer
 	move	$a0,$v0			#string converted to integer stored here
 	#beq	if $a0 == int value of "q" - branch to exitMain
 	#beq	if $a0 == int value of "Q" - branch to exitMain
	
	la	$t0,28($sp)		#load the target number for comparison
	beq 	$a0,$t0,winState	#if user input == chosen random, goto winState and exit
	blt 	$a0,$t0,tooLow		#goto tooLow
	bgt 	$a0,$t0,tooHigh		#goto tooHigh

tooLow:
	la	$a0,hintLow		#load address of low hint string in prep for MessageDialog
	jal 	MessageDialog		#display hint
	b	beginGuess

tooHigh:
	la 	$a0,hintHigh		#load address of high hint string in prep for MessageDialog
	jal 	MessageDialog		#display hint
	b	beginGuess

winState:
	la 	$a0,winStatement	#load win message into $a0 in prep for function call
	jal 	MessageDialog		#jump to MessageDialog to display winStatement popup

endGuess:
	lw	$a2,28($sp)
	lw	$a1,24($sp)
	lw	$a0,20($sp)
	lw	$ra,16($sp)
	addiu	$sp,$sp,20

	jr	$ra			#return to guess_main
