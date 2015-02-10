.data   #Variable declarations below this line
	nums:		.word	0,0,0,0,0
	out_string:	.asciiz	"\nPlease enter your integer: "

	partf:		.asciiz "\nThe hexadecimal value of the decimal integer "
	partm:		.asciiz " is: "
	partl:		.asciiz ".\n"
	
	hex:		.space	8

.text   #Commands below this line
main:   #Program starts after this line

	li $t0, 0			#Counter for get_ints
get_ints:
	li $v0, 4
	la $a0, out_string		#Moves the out_string to $a0 for printing
	syscall				#Prints the out_string

	li $v0, 5			#Call to read from console
	syscall				#System call
	sw   $v0, nums($s0)		#Stores the read value to nums position $s0

	addi $s0, $s0, 4		#Increments $s0 by 4
	addi $t0, $t0, 1		#Increments $t0 by 1
	ble  $t0, 4, get_ints		#If $t0 <= to 5, get_ints
	move $s0, $zero			#Reinitializes $s0 to zero for the next

check_ints:
	lw   $t2, nums($s0)		#Loads the number in position $s0
	ble  $t2, 0, get_ints		#If the int < 0, get_ints
	slti $t3, $t2, 32767		#Sets $t3 to 1 if $t2 less than 32768
	beq  $t3, $zero, get_ints	#If the int is more than 32768, get_ints

	addi $s0, $s0, 4		#Increments $s0 by 4
	addi $t0, $t0, 1		#Increments $t0 by 1
	ble  $t0, 4, check_ints		#If $t0 <= 5, check_ints

	move $s0, $zero			#Reinitializes $s0 to zero for the next

to_hex:
	move $s1, $zero			#Sets loop counter to zero
	la   $s2, hex			#Sets address counter to hex

	lw   $t0, nums($s0)  		#Loads number at positon $s0 into the t0 registry

	li   $v0, 4			#Load system call to v0
	la   $a0, partf   		#Moves partf to a0 for printing
        syscall         		#System call

	li   $v0, 1			#Load system call to v0
	move $a0, $t0   		#Moves $t0 to a0 for printing
        syscall         		#System call

	li   $v0, 4			#Load system call to v0
	la   $a0, partm   		#Moves partm to a0 for printing
        syscall         		#System call

	jal  to_hex_sub

	li   $v0, 4			#Load system call to v0
	la   $a0, hex  			#Moves return to a0 for printing
	syscall         		#System call

	li   $v0, 4			#Load system call to v0
	la   $a0, partl   		#Moves partl to a0 for printing
        syscall         		#System call

	addi $s0, $s0, 4		#Increments $s0 by 4
	ble  $s0, 16, to_hex		#If $s1 <= 4, to_hex
	j done

to_hex_sub:
	and  $t1, $t0, 15               #Logical AND with 15
        ble  $t1, 9, add_val_main
        addi $t1, $t1, 55               #if greater than nine, add 55
        b    add_val                    #Branches to add_val
 
	add_val_main:
		addi $t1, $t1, 48

        add_val:
                sb   $t1, 0($s2)        # store hex digit into result
                addi $s1, $s1, 1        # increment loop counter
                addi $s2, $s2, 1        # increment address counter
                srl  $t0, $t0, 4        # rotate 4 bits to the right
                bne  $t0, 0, to_hex_sub # While $t0 is not zero, to_hex_sub
		la   $s2, hex		# Reset $s2
		j    $ra 		# Else, go back to_hex

done:
        li $v0, 10      	#Exit
        syscall         	#System call
