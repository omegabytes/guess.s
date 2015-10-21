#
#
# create_question.s
# implements a function to assemble a question string from three parts
#
#   char * create_question(char * first, char * second, char * third);
#
# allocates space for a new string on the heap large enough to hold the 
# question, then fills the space by copying first, second and third, creating
# the concatenated question.
#
#  char * create_question( char * first, char * second, char * third) {
.data
promptOne:	.ascii "Please enter a hexadecimal number between one and "
promptTwo:	.ascii ". Enter your guess (q to quit)"
    .text
    .globl create_question
create_question:
    addiu  	$sp,$sp,-40	#allocated stack space
    sw  	$a0,40($sp)	#
    sw  	$a1,44($sp)	#
    sw  	$a2,48($sp)	#
    sw  	$ra,36($sp)	#
#  int len1, len2, len3, len ;
#  char * question;
    # question - s0
    # len1 - s1
    # len2 - s2
    # len3 - s3
    # len - s4
    sw  	$s4,32($sp)	#len
    sw  	$s3,28($sp)	#len3
    sw  	$s2,24($sp)	#len2
    sw  	$s1,20($sp)	#len1
    sw  	$s0,16($sp)	#question
#
#  len1 = strlen(first);
#  len2 = strlen(second);
#  len3 = strlen(third);
#  len = len1 + len2 + len3;
    la		$a0,promptOne	#load address of promptOne in prep for strlen()
    #jal		strlen		#call strlen()
    sw		$v0,20($sp)	#store length of promptOne into $s1
    
    #where is the max value? We need to load it and pass it to strlen() here before continuing
    add		$a0,$zero,$a0	#I'm assuming max value will be in $a0
    #jal		strlen		#call strlen()
    sw		$v0,24($sp)	#store length of max value in $s2
    
    la		$a0,promptTwo	#load address of promptTwo in prep
    #jal		strlen		#call strlen()
    sw		$v0,28($sp)	#save length of promptTwo into $s3
    
    #are we concatenating all three lens into len? what is the purpose of this value?
    add		$s4,$s3,$s2	#len = len3+len2
    add		$s4,$s4,$s1	#len = (len3+len2)+len1

#  question = sbrk (len + 1);
#  strcpy(question,first);
#  strcpy(question+len1, second);
#  strcpy(question+len1+len2,third);

    add		$a0,$s4,1	#$a0 = len + 1
    jal		strcpy		#call strcpy for len +1
    move	$t1,$v0		#move 




#  return(question);
    move 	$v0,$s0
    lw  	$s4,32($sp)
    lw  	$s3,28($sp)
    lw  	$s2,24($sp)
    lw  	$s1,20($sp)
    lw  	$s0,16($sp)
    lw  	$ra,36($sp)
    addiu  	$sp,$sp,40
    jr  	$ra
# }
