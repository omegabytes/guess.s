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

    .text
    .globl create_question
create_question:
    addiu  	$sp,$sp,-40	#allocated stack space
    sw  	$a0,40($sp)	#promptOne
    sw  	$a1,44($sp)	#max (after itoax conversion
    sw  	$a2,48($sp)	#promptTwo
    sw  	$ra,36($sp)	#store return address
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
    la		$a0,promptOne	#load address of promptOne in prep for strlen()
    jal		strlen		#call strlen()
    sw		$v0,20($sp)	#store length of promptOne into $s1
   
#  len2 = strlen(second);    
    move	$a1,$a0		#move max into $a0 in prep for strlen
    jal		strlen		#call strlen()
    sw		$v0,24($sp)	#store length of max value in $s2

#  len3 = strlen(third);       
    la		$a0,promptTwo	#load address of promptTwo in prep
    jal		strlen		#call strlen()
    sw		$v0,28($sp)	#save length of promptTwo into $s3
    
#  len = len1 + len2 + len3;
    add		$s4,$s3,$s2	#len = len3+len2
    add		$s4,$s4,$s1	#len = (len3+len2)+len1

#  question = sbrk (len + 1);
    add		$a0,$s4,1	#$a0 = len + 1
    jal		sbrk		#call sbrk for len +1
    move	$s0,$v0 	#$s0 = question (= sbrk(len+1)) 
    
#  strcpy(question,first);    
    move	$a0,$s0		#$a0 = question
    lw		$a1,40($sp)	#$a1 = promptOne
    jal		strcpy
    move	$s0,$v0		#store question in $s0
    
#  strcpy(question+len1, second);
    move	$a0,$s0		#$a0 = question
    lw		$t0,20($sp)	#$t0 = len1
    add		$a0,$a0,$t0	#$a0 = question+len1
    lw		$a1,44($sp)	#$a1 = max (post-conversion)
    jal		srtcpy		
    move	$s0,$v0		#store question in $s0
          
#  strcpy(question+len1+len2,third);
    move	$a0,$s0		#$a0 = question+len1
    lw		$t0,24($sp)	#$t0 = len2
    add		$a0,$a0,$t0	#$a0 = question+len1+len2
    lw		$a1,48($sp)	#$a1 = promptTwo
    jal		strcpy
    sw		$v0,16($sp)	#store cat'd question in 16($sp) f

#  return(question);
    #move 	$v0,$s0
    lw  	$s4,32($sp)
    lw  	$s3,28($sp)
    lw  	$s2,24($sp)
    lw  	$s1,20($sp)
    lw  	$s0,16($sp)
    lw  	$ra,36($sp)
    addiu  	$sp,$sp,40
    jr  	$ra
# }
