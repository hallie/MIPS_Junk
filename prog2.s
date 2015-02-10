.data   #Variable declarations below this line
	nums:		.word	0,0,0,0,0
	out_string:	.asciiz	"\nPlease enter your integer: "

.text   #Commands below this line
main:   #Program starts after this line

	li $t0, 0

get_ints:
	li $v0, 4
	la $a0, out_string		#Moves the out_string to $a0 for printing
	syscall				#Prints the out_string

	li $v0, 5			#Call to read from console
	syscall				#System call
	sw   $v0, nums($s0)		#Stores the read value to nums position $s0

	addi $s0, $s0, 4		#Increments $s0 by 4
	addi $t0, $t0, 1		#Increments $t0 by 1
	ble  $t0, 4, get_ints		#If $t0 is less than or equal to 5, get_ints
	move $s0, $zero			#Reinitializes $s0 to zero for the next

check_ints:
	lw   $t2, nums($s0)		#Loads the number in position $s0
	ble  $t2, 0, get_ints		#If the int is less than 0, calls for new ints
	slti $t3, $t2, 32767		#Sets $t3 to 1 if $t2 less than 32768
	beq  $t3, $zero, get_ints	#If the int is more than 32768, calls for new ints

	addi $s0, $s0, 4		#Increments $s0 by 4
	addi $t0, $t0, 1		#Increments $t0 by 1
	ble  $t0, 4, check_ints		#If $t0 is less than or equal to 5, check_ints
	move $s0, $zero			#Reinitializes $s0 to zero for the next

do_calc:
        lw   $t0, nums($s0)  	#Loads number at positon $s0 into the t0 registry
	addi $s0, $s0, 4	#Increments $s0 by 4
        lw   $t1, nums($s0) 	#Loads number at positon $s0 into the t1 registry
	addi $s0, $s0, 4	#Increments $s0 by 4
        lw   $t2, nums($s0) 	#Loads number at positon $s0 into the t2 registry
	addi $s0, $s0, 4	#Increments $s0 by 4
        lw   $t3, nums($s0)  	#Loads number at positon $s0 into the t3 registry
	addi $s0, $s0, 4	#Increments $s0 by 4

        lw   $t4, nums($s0)  	#Loads number at positon $s0 into the t4 registry
        mul  $s1, $t3, $t4   	#Multiplies t3 and t4 (C * D) and stores to s1
        sub  $s2, $t2, $s1   	#Subtracts t2 from s1 (C- D*E) and stores to s2
        sub  $s3, $t1, $s2   	#Subtracts t1 from s2 (B- (C-D*E) and stores to s3
        add  $s4, $t0, $s3   	#Adds t0 and s3 (A+ B-(C-D*E)) and stores to s4

	li $v0, 1		#Load system call to v0
	move $a0, $s4   	#Moves s4 (the value of the computed equation) to a0 for printing
        syscall         	#System call

	

        li $v0, 10      	#Exit
        syscall         	#System call
