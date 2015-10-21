#Alex Gaesser
#Hand of the King
#Dragonkin
#True Lord in the North
#Undefeated Champion of the Realm
.data
hintLow: 	.asciiz "Guess is too low, try again"
hintHigh: 	.asciiz "Guess is too high, guess again"
winStatement: 	.asciiz "You got it hombre!"

offset:		.word 3312
min: 		.word 1
max: 		.word 100

.text
.globl main
main:
addiu $sp,$sp,-128	#create stack (I have not calculated stack size this is a placeholder)
la $a0,min		#load min into $a0
la $a1,max		#load max into $a1
sw $ra,124($sp)		#save return address

#create the question
jal create_question

#get the RandomIntRange
jal RandomIntRange

#jump to get_guess
jal get_guess

#add $s0,$t0,$zero	#store random generated number into $s0 for comparison
beq $s1,$s0,winState	#if user input == chosen random, goto winState and exit
blt $s1,$s0,tooLow	#goto tooLow
bgt $s1,$s0,tooHigh	#goto tooHigh

#beq winCondition,winState (to be completed)
b get_guess		#branch to getGuess

tooLow:
la $a0,hintLow		#load address of low hint string in prep for MessageDialog
jal MessageDialog	#display hint

tooHigh:
la $a0,hintHigh		#load address of high hint string in prep for MessageDialog
jal MessageDialog	#display hint

winState:
la $a0,winStatement	#load win message into $a0 in prep for function call
jal MessageDialog	#jump to MessageDialog to display winStatement popup

jr $ra			#return from main

.include "./util.s"
.include "./create_question.s"
.include "./RandomIntRange.s"
.include "./get_guess.s"
