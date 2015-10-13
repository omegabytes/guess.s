.text
.globl RandomIntRange
RandomIntRange:
#add $t0,$zero,5	#placeholder "random number" 
addiu 	$sp,$sp,-20	#allocate stack
sw	$ra,16($sp)	#save the return address to guess_main.s
sw	$a0,20($sp)	#offset
sw	$a1,24($sp)	#low
sw	$a3,28($sp)	#high

#time()
jal time	#$v0 now contains time

#srandom()
#$v0 should already hold the seed
lw	$t0,20($sp)	#load offset into $t0
add	$v0,$v0,$t0	#add offset to time (in $v0)
jal srandom

#random()
jal random	#random number now in $v0

lw	$t1,28($sp)	#load high from stack
lw	$t2,24($sp)	#load low from stack
sub	$t0,$t1,$t2	#$t0= high-low
addi	$t0,$t0,1	#$t0= (high-low)+1
divu	$v0,$t0		#divide random number by (high-low)+1,qotient in lo, rem in hi
mfhi	$v0		#move remainder from hi into $v0
add	$v0,$v0,$t2	#add low to remainder

lw	$ra,16($sp)
addiu	$sp,$sp,20

jr	$ra