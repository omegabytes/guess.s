#Alex Gaesser
#Hand of the King
#Dragonkin
#True Lord in the North
#Undefeated Champion of the Realm
.data
hintLow: 	.asciiz "Guess is too low, try again"
hintHigh: 	.asciiz "Guess is too high, guess again"
winStatement: 	.asciiz "You got it hombre!"
promptOne:	.ascii 	"Please enter a hexadecimal number between one and "
promptTwo:	.ascii 	". Enter your guess (q to quit)"
offset:		.word 3312
min: 		.word 1
max: 		.word 10
randomInt:	.word 0

.text
.globl main
main:
addiu 	$sp,$sp,-128		#create stack (I have not calculated stack size this is a placeholder)
sw	$a0,16($sp)		#int min
sw	$a1,20($sp)		#int max
sw 	$ra,124($sp)		#save return address

sw	$s0,24($sp)		#concatenated question

#convert max from integer to hex with itoax(int, *string)
la	$a0,max			#pointer to max
jal	itoax			#call itoax
sw	$v0,20($sp)		#max (hexadecimal) in $s1

#create the question
jal 	create_question
sw	$v0,24($sp)		#save cat'd question

#get the RandomIntRange
jal 	RandomIntRange
sw	$v0,randomInt		#store randomInt

#jump to get_guess
jal 	get_guess

#add $s0,$t0,$zero		#store random generated number into $s0 for comparison
beq 	$s1,$s0,winState	#if user input == chosen random, goto winState and exit
blt 	$s1,$s0,tooLow		#goto tooLow
bgt 	$s1,$s0,tooHigh		#goto tooHigh

#beq winCondition,winState (to be completed)
b 	get_guess		#branch to getGuess

tooLow:
la 	$a0,hintLow		#load address of low hint string in prep for MessageDialog
jal 	MessageDialog		#display hint

tooHigh:
la 	$a0,hintHigh		#load address of high hint string in prep for MessageDialog
jal 	MessageDialog		#display hint

winState:
la 	$a0,winStatement	#load win message into $a0 in prep for function call
jal 	MessageDialog		#jump to MessageDialog to display winStatement popup

jr 	$ra			#return from main

.include "./util.s"
.include "./create_question.s"
.include "./RandomIntRange.s"
.include "./get_guess.s"
