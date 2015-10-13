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
    addiu  $sp,$sp,-40
    sw  $a0,40($sp)
    sw  $a1,44($sp)
    sw  $a2,48($sp)
    sw  $ra,36($sp)
#  int len1, len2, len3, len ;
#  char * question;
    # question - s0
    # len1 - s1
    # len2 - s2
    # len3 - s3
    # len - s4
    sw  $s4,32($sp)
    sw  $s3,28($sp)
    sw  $s2,24($sp)
    sw  $s1,20($sp)
    sw  $s0,16($sp)
#
#  len1 = strlen(first);
#  len2 = strlen(second);
#  len3 = strlen(third);
#  len = len1 + len2 + len3;
# 
#  question = sbrk (len + 1);
#  strcpy(question,first);
#  strcpy(question+len1, second);
#  strcpy(question+len1+len2,third);
#
#  return(question);
    move $v0,$s0
    lw  $s4,32($sp)
    lw  $s3,28($sp)
    lw  $s2,24($sp)
    lw  $s1,20($sp)
    lw  $s0,16($sp)
    lw  $ra,36($sp)
    addiu  $sp,$sp,40
    jr  $ra
# }
