.data   #Variable declarations below this line
        A:      .word   10       #Stores 1 into the integer A
        B:      .word   20       #Stores 2 into the integer B
        C:      .word   30       #Stores 3 into the integer C
        D:      .word   40       #Stores 4 into the integer D
        E:      .word   50       #Stores 5 into the integer E

.text   #Commands below this line
main:   #Program starts after this line
        lw      $t0, A  #Loads A into the t0 registry
        lw      $t1, B  #Loads B into the t1 registry
        lw      $t2, C  #Loads C into the t2 registry
        lw      $t3, D  #Loads D into the t3 registry
        lw      $t4, E  #Loads E into the t4 registry
        mul     $s1, $t3, $t4   #Multiplies t3 and t4 (C * D) and stores to s1
        sub     $s2, $t2, $s1   #Subtracts t2 from s1 (C- D*E) and stores to s2
        sub     $s3, $t1, $s2   #Subtracts t1 from s2 (B- (C-D*E) and stores to s3
        add     $s4, $t0, $s3   #Adds t0 and s3 (A+ B-(C-D*E)) and stores to s4

        li $v0, 1       #Load system call to v0
        move $a0, $s4   #Moves s4 (the value of the computed equation) to a0 for printing
        syscall         #System call

        li $v0, 10      #Exit
        syscall         #System call
