	.data
	.text
# * CALL                                                  (LABEL main1)     
jal	 main1
# * END                                                                     
li	 $v0, 10
syscall
# ----------------------------
# | Original source          |
# ----------------------------
# * void main(void) {
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * LABEL             (LABEL main1)                                         
main1:
# * PROCENTRY         (ICONS 1236)      (ICONS 0)                           
subi	$sp, $sp, 1236
sw	$ra, 1232($sp)
# ----------------------------
# | Original source          |
# ----------------------------
# * 	mat1 = readMatrix();
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * CALL                                                  (LABEL readMatrix1)
jal	 readMatrix1
# * STRUCT_OUT        (ILocal -408)     (ICONS 408)       (ILocal 8)        
li	$t2, -408
add	$t2, $t2, $sp
li	$t3, 8
add	$t3, $t3, $sp
li	$t1, 0
li	$t0, 408
loopl20:
bge	 $t1, $t0, loopl21
lw	 $t4, ($t2)
sw	 $t4, ($t3)
addi	 $t2, $t2, 4
addi	 $t3, $t3, 4
addi	 $t1, $t1, 4
b	 loopl20
loopl21:
# ----------------------------
# | Original source          |
# ----------------------------
# * 	printMatrix(mat1);
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * STRUCT_OUT        (ILocal 8)        (ICONS 408)       (ILocal -420)     
li	$t3, 8
add	$t3, $t3, $sp
li	$t4, -420
add	$t4, $t4, $sp
li	$t2, 0
li	$t0, 408
loopl22:
bge	 $t2, $t0, loopl23
lw	 $t5, ($t3)
sw	 $t5, ($t4)
addi	 $t3, $t3, 4
addi	 $t4, $t4, 4
addi	 $t2, $t2, 4
b	 loopl22
loopl23:
# * CALL                                                  (LABEL printMatrix1)
jal	 printMatrix1
# ----------------------------
# | Original source          |
# ----------------------------
# * 	printChar((char) 10);
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ASSIGN            (ICONS 10)                          (ILocal -8)       
li	 $t0, 10

sw	 $t0, -8($sp)
# * CALL                                                  (LABEL printChar1)
jal	 printChar1
# * ASSIGN            (ICONS 10)                          (ILocal -8)       
li	 $t0, 10

sw	 $t0, -8($sp)
# * CALL                                                  (LABEL printChar1)
jal	 printChar1
# ----------------------------
# | Original source          |
# ----------------------------
# * 	mat2 = readMatrix();
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * CALL                                                  (LABEL readMatrix1)
jal	 readMatrix1
# * STRUCT_OUT        (ILocal -408)     (ICONS 408)       (ILocal 416)      
li	$t2, -408
add	$t2, $t2, $sp
li	$t3, 416
add	$t3, $t3, $sp
li	$t1, 0
li	$t0, 408
loopl24:
bge	 $t1, $t0, loopl25
lw	 $t4, ($t2)
sw	 $t4, ($t3)
addi	 $t2, $t2, 4
addi	 $t3, $t3, 4
addi	 $t1, $t1, 4
b	 loopl24
loopl25:
# ----------------------------
# | Original source          |
# ----------------------------
# * 	printMatrix(mat2);
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * STRUCT_OUT        (ILocal 416)      (ICONS 408)       (ILocal -420)     
li	$t3, 416
add	$t3, $t3, $sp
li	$t4, -420
add	$t4, $t4, $sp
li	$t2, 0
li	$t0, 408
loopl26:
bge	 $t2, $t0, loopl27
lw	 $t5, ($t3)
sw	 $t5, ($t4)
addi	 $t3, $t3, 4
addi	 $t4, $t4, 4
addi	 $t2, $t2, 4
b	 loopl26
loopl27:
# * CALL                                                  (LABEL printMatrix1)
jal	 printMatrix1
# ----------------------------
# | Original source          |
# ----------------------------
# * 	printChar((char) 10);
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ASSIGN            (ICONS 10)                          (ILocal -8)       
li	 $t0, 10

sw	 $t0, -8($sp)
# * CALL                                                  (LABEL printChar1)
jal	 printChar1
# * ASSIGN            (ICONS 10)                          (ILocal -8)       
li	 $t0, 10

sw	 $t0, -8($sp)
# * CALL                                                  (LABEL printChar1)
jal	 printChar1
# ----------------------------
# | Original source          |
# ----------------------------
# * 	printMatrix(multiplyMatrices(mat1, mat2));
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * STRUCT_OUT        (ILocal 8)        (ICONS 408)       (ILocal -1648)    
li	$t2, 8
add	$t2, $t2, $sp
li	$t3, -1648
add	$t3, $t3, $sp
li	$t1, 0
li	$t0, 408
loopl28:
bge	 $t1, $t0, loopl29
lw	 $t4, ($t2)
sw	 $t4, ($t3)
addi	 $t2, $t2, 4
addi	 $t3, $t3, 4
addi	 $t1, $t1, 4
b	 loopl28
loopl29:
# * STRUCT_OUT        (ILocal 416)      (ICONS 408)       (ILocal -1240)    
li	$t3, 416
add	$t3, $t3, $sp
li	$t4, -1240
add	$t4, $t4, $sp
li	$t2, 0
li	$t0, 408
loopl30:
bge	 $t2, $t0, loopl31
lw	 $t5, ($t3)
sw	 $t5, ($t4)
addi	 $t3, $t3, 4
addi	 $t4, $t4, 4
addi	 $t2, $t2, 4
b	 loopl30
loopl31:
# * CALL                                                  (LABEL multiplyMatrices1)
jal	 multiplyMatrices1
# * STRUCT_OUT        (ILocal -408)     (ICONS 408)       (ILocal -420)     
li	$t2, -408
add	$t2, $t2, $sp
li	$t3, -420
add	$t3, $t3, $sp
li	$t1, 0
li	$t0, 408
loopl32:
bge	 $t1, $t0, loopl33
lw	 $t4, ($t2)
sw	 $t4, ($t3)
addi	 $t2, $t2, 4
addi	 $t3, $t3, 4
addi	 $t1, $t1, 4
b	 loopl32
loopl33:
# * CALL                                                  (LABEL printMatrix1)
jal	 printMatrix1
# ----------------------------
# | Original source          |
# ----------------------------
# * }
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * RETURN            (ICONS 1232)      (ICONS 1236)                        
lw	 $ra, 1232($sp)
add	 $sp, $sp, 1236
jr	 $ra
# ----------------------------
# | Original source          |
# ----------------------------
# * struct Matrix readMatrix() {
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * LABEL             (LABEL readMatrix1)                                    
readMatrix1:
# * PROCENTRY         (ICONS 832)       (ICONS 408)                         
subi	$sp, $sp, 832
sw	$ra, 420($sp)
# ----------------------------
# | Original source          |
# ----------------------------
# * 	printChar('E');
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ASSIGN            (ICONS 69)                          (ILocal -8)       
li	 $t0, 69

sw	 $t0, -8($sp)
# * CALL                                                  (LABEL printChar1)
jal	 printChar1
# ----------------------------
# | Original source          |
# ----------------------------
# * 	printChar('N');
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ASSIGN            (ICONS 78)                          (ILocal -8)       
li	 $t0, 78

sw	 $t0, -8($sp)
# * CALL                                                  (LABEL printChar1)
jal	 printChar1
# ----------------------------
# | Original source          |
# ----------------------------
# * 	printChar('T');
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ASSIGN            (ICONS 84)                          (ILocal -8)       
li	 $t0, 84

sw	 $t0, -8($sp)
# * CALL                                                  (LABEL printChar1)
jal	 printChar1
# ----------------------------
# | Original source          |
# ----------------------------
# * 	printChar('E');
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ASSIGN            (ICONS 69)                          (ILocal -8)       
li	 $t0, 69

sw	 $t0, -8($sp)
# * CALL                                                  (LABEL printChar1)
jal	 printChar1
# ----------------------------
# | Original source          |
# ----------------------------
# * 	printChar('R');
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ASSIGN            (ICONS 82)                          (ILocal -8)       
li	 $t0, 82

sw	 $t0, -8($sp)
# * CALL                                                  (LABEL printChar1)
jal	 printChar1
# ----------------------------
# | Original source          |
# ----------------------------
# * 	printChar(' ');
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ASSIGN            (ICONS 32)                          (ILocal -8)       
li	 $t0, 32

sw	 $t0, -8($sp)
# * CALL                                                  (LABEL printChar1)
jal	 printChar1
# ----------------------------
# | Original source          |
# ----------------------------
# * 	printChar('D');
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ASSIGN            (ICONS 68)                          (ILocal -8)       
li	 $t0, 68

sw	 $t0, -8($sp)
# * CALL                                                  (LABEL printChar1)
jal	 printChar1
# ----------------------------
# | Original source          |
# ----------------------------
# * 	printChar('I');
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ASSIGN            (ICONS 73)                          (ILocal -8)       
li	 $t0, 73

sw	 $t0, -8($sp)
# * CALL                                                  (LABEL printChar1)
jal	 printChar1
# ----------------------------
# | Original source          |
# ----------------------------
# * 	printChar('M');
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ASSIGN            (ICONS 77)                          (ILocal -8)       
li	 $t0, 77

sw	 $t0, -8($sp)
# * CALL                                                  (LABEL printChar1)
jal	 printChar1
# ----------------------------
# | Original source          |
# ----------------------------
# * 	printChar('E');
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ASSIGN            (ICONS 69)                          (ILocal -8)       
li	 $t0, 69

sw	 $t0, -8($sp)
# * CALL                                                  (LABEL printChar1)
jal	 printChar1
# ----------------------------
# | Original source          |
# ----------------------------
# * 	printChar('N');
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ASSIGN            (ICONS 78)                          (ILocal -8)       
li	 $t0, 78

sw	 $t0, -8($sp)
# * CALL                                                  (LABEL printChar1)
jal	 printChar1
# ----------------------------
# | Original source          |
# ----------------------------
# * 	printChar('S');
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ASSIGN            (ICONS 83)                          (ILocal -8)       
li	 $t0, 83

sw	 $t0, -8($sp)
# * CALL                                                  (LABEL printChar1)
jal	 printChar1
# ----------------------------
# | Original source          |
# ----------------------------
# * 	printChar('I');
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ASSIGN            (ICONS 73)                          (ILocal -8)       
li	 $t0, 73

sw	 $t0, -8($sp)
# * CALL                                                  (LABEL printChar1)
jal	 printChar1
# ----------------------------
# | Original source          |
# ----------------------------
# * 	printChar('O');
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ASSIGN            (ICONS 79)                          (ILocal -8)       
li	 $t0, 79

sw	 $t0, -8($sp)
# * CALL                                                  (LABEL printChar1)
jal	 printChar1
# ----------------------------
# | Original source          |
# ----------------------------
# * 	printChar('N');
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ASSIGN            (ICONS 78)                          (ILocal -8)       
li	 $t0, 78

sw	 $t0, -8($sp)
# * CALL                                                  (LABEL printChar1)
jal	 printChar1
# ----------------------------
# | Original source          |
# ----------------------------
# * 	printChar('S');
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ASSIGN            (ICONS 83)                          (ILocal -8)       
li	 $t0, 83

sw	 $t0, -8($sp)
# * CALL                                                  (LABEL printChar1)
jal	 printChar1
# ----------------------------
# | Original source          |
# ----------------------------
# * 	printChar(':');
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ASSIGN            (ICONS 58)                          (ILocal -8)       
li	 $t0, 58

sw	 $t0, -8($sp)
# * CALL                                                  (LABEL printChar1)
jal	 printChar1
# ----------------------------
# | Original source          |
# ----------------------------
# * 	printChar((char) 10);
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ASSIGN            (ICONS 10)                          (ILocal -8)       
li	 $t0, 10

sw	 $t0, -8($sp)
# * CALL                                                  (LABEL printChar1)
jal	 printChar1
# ----------------------------
# | Original source          |
# ----------------------------
# * 	re.rows = readInt();
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * CALL                                                  (LABEL readInt1)  
jal	 readInt1
# * ASSIGN            (ILocal -4)                         (ILocal 416)      
lw	 $s0, -4($sp)

sw	 $s0, 416($sp)
# ----------------------------
# | Original source          |
# ----------------------------
# * 	printChar('X');
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ASSIGN            (ICONS 88)                          (ILocal -8)       
li	 $t0, 88

sw	 $t0, -8($sp)
# * CALL                                                  (LABEL printChar1)
jal	 printChar1
# ----------------------------
# | Original source          |
# ----------------------------
# * 	printChar((char) 10);
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ASSIGN            (ICONS 10)                          (ILocal -8)       
li	 $t0, 10

sw	 $t0, -8($sp)
# * CALL                                                  (LABEL printChar1)
jal	 printChar1
# ----------------------------
# | Original source          |
# ----------------------------
# * 	re.columns = readInt();
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * CALL                                                  (LABEL readInt1)  
jal	 readInt1
# * ASSIGN            (ILocal -4)                         (ILocal 12)       
lw	 $s0, -4($sp)

sw	 $s0, 12($sp)
# ----------------------------
# | Original source          |
# ----------------------------
# * 	printChar((char) 10);
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ASSIGN            (ICONS 10)                          (ILocal -8)       
li	 $t0, 10

sw	 $t0, -8($sp)
# * CALL                                                  (LABEL printChar1)
jal	 printChar1
# ----------------------------
# | Original source          |
# ----------------------------
# * 	printChar('E');
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ASSIGN            (ICONS 69)                          (ILocal -8)       
li	 $t0, 69

sw	 $t0, -8($sp)
# * CALL                                                  (LABEL printChar1)
jal	 printChar1
# ----------------------------
# | Original source          |
# ----------------------------
# * 	printChar('N');
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ASSIGN            (ICONS 78)                          (ILocal -8)       
li	 $t0, 78

sw	 $t0, -8($sp)
# * CALL                                                  (LABEL printChar1)
jal	 printChar1
# ----------------------------
# | Original source          |
# ----------------------------
# * 	printChar('T');
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ASSIGN            (ICONS 84)                          (ILocal -8)       
li	 $t0, 84

sw	 $t0, -8($sp)
# * CALL                                                  (LABEL printChar1)
jal	 printChar1
# ----------------------------
# | Original source          |
# ----------------------------
# * 	printChar('E');
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ASSIGN            (ICONS 69)                          (ILocal -8)       
li	 $t0, 69

sw	 $t0, -8($sp)
# * CALL                                                  (LABEL printChar1)
jal	 printChar1
# ----------------------------
# | Original source          |
# ----------------------------
# * 	printChar('R');
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ASSIGN            (ICONS 82)                          (ILocal -8)       
li	 $t0, 82

sw	 $t0, -8($sp)
# * CALL                                                  (LABEL printChar1)
jal	 printChar1
# ----------------------------
# | Original source          |
# ----------------------------
# * 	printChar(' ');
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ASSIGN            (ICONS 32)                          (ILocal -8)       
li	 $t0, 32

sw	 $t0, -8($sp)
# * CALL                                                  (LABEL printChar1)
jal	 printChar1
# ----------------------------
# | Original source          |
# ----------------------------
# * 	printChar('E');
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ASSIGN            (ICONS 69)                          (ILocal -8)       
li	 $t0, 69

sw	 $t0, -8($sp)
# * CALL                                                  (LABEL printChar1)
jal	 printChar1
# ----------------------------
# | Original source          |
# ----------------------------
# * 	printChar('N');
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ASSIGN            (ICONS 78)                          (ILocal -8)       
li	 $t0, 78

sw	 $t0, -8($sp)
# * CALL                                                  (LABEL printChar1)
jal	 printChar1
# ----------------------------
# | Original source          |
# ----------------------------
# * 	printChar('T');
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ASSIGN            (ICONS 84)                          (ILocal -8)       
li	 $t0, 84

sw	 $t0, -8($sp)
# * CALL                                                  (LABEL printChar1)
jal	 printChar1
# ----------------------------
# | Original source          |
# ----------------------------
# * 	printChar('R');
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ASSIGN            (ICONS 82)                          (ILocal -8)       
li	 $t0, 82

sw	 $t0, -8($sp)
# * CALL                                                  (LABEL printChar1)
jal	 printChar1
# ----------------------------
# | Original source          |
# ----------------------------
# * 	printChar('I');
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ASSIGN            (ICONS 73)                          (ILocal -8)       
li	 $t0, 73

sw	 $t0, -8($sp)
# * CALL                                                  (LABEL printChar1)
jal	 printChar1
# ----------------------------
# | Original source          |
# ----------------------------
# * 	printChar('E');
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ASSIGN            (ICONS 69)                          (ILocal -8)       
li	 $t0, 69

sw	 $t0, -8($sp)
# * CALL                                                  (LABEL printChar1)
jal	 printChar1
# ----------------------------
# | Original source          |
# ----------------------------
# * 	printChar('S');
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ASSIGN            (ICONS 83)                          (ILocal -8)       
li	 $t0, 83

sw	 $t0, -8($sp)
# * CALL                                                  (LABEL printChar1)
jal	 printChar1
# ----------------------------
# | Original source          |
# ----------------------------
# * 	printChar(' ');
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ASSIGN            (ICONS 32)                          (ILocal -8)       
li	 $t0, 32

sw	 $t0, -8($sp)
# * CALL                                                  (LABEL printChar1)
jal	 printChar1
# ----------------------------
# | Original source          |
# ----------------------------
# * 	printChar('(');
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ASSIGN            (ICONS 40)                          (ILocal -8)       
li	 $t0, 40

sw	 $t0, -8($sp)
# * CALL                                                  (LABEL printChar1)
jal	 printChar1
# ----------------------------
# | Original source          |
# ----------------------------
# * 	for (m = 1; m < re.rows * re.columns; m *= 10) {}
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ASSIGN            (ICONS 1)                           (ILocal 8)        
li	 $t0, 1

sw	 $t0, 8($sp)
# * LABEL             (LABEL LL00000)                                       
LL00000:
# * MULT              (ILocal 416)      (ILocal 12)       (ITemp 0)         
lw	 $s0, 416($sp)
lw	 $s1, 12($sp)
mul	 $t0, $s0, $s1
# * LT                (ILocal 8)        (ITemp 0)         (ITemp 1)         
lw	 $s2, 8($sp)
slt	 $t0, $s2, $t0
# * BREQ              (ITemp 1)         (ICONS 0)         (LABEL LL00001)   
li	 $t1, 0
beq	 $t0, $t1, LL00001
# * MULT              (ILocal 8)        (ICONS 10)        (ILocal 8)        
li	 $t0, 10
mul	 $s2, $s2, $t0
sw	 $s2, 8($sp)
# ----------------------------
# | Original source          |
# ----------------------------
# * 	}
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * BR                                                    (LABEL LL00000)   
b	 LL00000
# ----------------------------
# | Original source          |
# ----------------------------
# * 
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * LABEL             (LABEL LL00001)                                       
LL00001:
# ----------------------------
# | Original source          |
# ----------------------------
# * 	while (m > 1) {
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * LABEL             (LABEL LL00002)                                       
LL00002:
# * GT                (ILocal 8)        (ICONS 1)         (ITemp 2)         
lw	 $s0, 8($sp)
li	 $t0, 1
sgt	 $t0, $s0, $t0
# * BREQ              (ITemp 2)         (ICONS 0)         (LABEL LL00003)   
li	 $t1, 0
beq	 $t0, $t1, LL00003
# ----------------------------
# | Original source          |
# ----------------------------
# * 		printChar(((char) ('0' + ((re.rows * re.columns) % m) / (m / 10))));
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * MULT              (ILocal 416)      (ILocal 12)       (ITemp 3)         
lw	 $s1, 416($sp)
lw	 $s2, 12($sp)
mul	 $t0, $s1, $s2
# * MOD               (ITemp 3)         (ILocal 8)        (ITemp 4)         
rem	 $t0, $t0, $s0
# * DIV               (ILocal 8)        (ICONS 10)        (ITemp 5)         
li	 $t1, 10
div	 $t1, $s0, $t1
# * DIV               (ITemp 4)         (ITemp 5)         (ITemp 6)         
div	 $t0, $t0, $t1
# * ADD               (ICONS 48)        (ITemp 6)         (ITemp 7)         
li	 $t1, 48
add	 $t0, $t1, $t0
# * ASSIGN            (ITemp 7)                           (ILocal -8)       

sw	 $t0, -8($sp)
# * CALL                                                  (LABEL printChar1)
sw	 $s0, 8($sp)
sw	 $s1, 416($sp)
sw	 $s2, 12($sp)
jal	 printChar1
# ----------------------------
# | Original source          |
# ----------------------------
# * 		m /= 10;
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * DIV               (ILocal 8)        (ICONS 10)        (ILocal 8)        
lw	 $s0, 8($sp)
li	 $t0, 10
div	 $s0, $s0, $t0
sw	 $s0, 8($sp)
# ----------------------------
# | Original source          |
# ----------------------------
# * 	}
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * BR                                                    (LABEL LL00002)   
b	 LL00002
# ----------------------------
# | Original source          |
# ----------------------------
# * 
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * LABEL             (LABEL LL00003)                                       
LL00003:
# ----------------------------
# | Original source          |
# ----------------------------
# * 	printChar(')');
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ASSIGN            (ICONS 41)                          (ILocal -8)       
li	 $t0, 41

sw	 $t0, -8($sp)
# * CALL                                                  (LABEL printChar1)
jal	 printChar1
# ----------------------------
# | Original source          |
# ----------------------------
# * 	printChar(':');
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ASSIGN            (ICONS 58)                          (ILocal -8)       
li	 $t0, 58

sw	 $t0, -8($sp)
# * CALL                                                  (LABEL printChar1)
jal	 printChar1
# ----------------------------
# | Original source          |
# ----------------------------
# * 	printChar((char) 10);
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ASSIGN            (ICONS 10)                          (ILocal -8)       
li	 $t0, 10

sw	 $t0, -8($sp)
# * CALL                                                  (LABEL printChar1)
jal	 printChar1
# ----------------------------
# | Original source          |
# ----------------------------
# * 	for (i = 0; i < re.rows && i < 10; i++) {
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ASSIGN            (ICONS 0)                           (ILocal 0)        
li	 $t0, 0

sw	 $t0, 0($sp)
# * LABEL             (LABEL LL00004)                                       
LL00004:
# * LT                (ILocal 0)        (ILocal 416)      (ITemp 8)         
lw	 $s0, 0($sp)
lw	 $s1, 416($sp)
slt	 $t0, $s0, $s1
# * LT                (ILocal 0)        (ICONS 10)        (ITemp 9)         
li	 $t1, 10
slt	 $t1, $s0, $t1
# * LAND              (ITemp 8)         (ITemp 9)         (ITemp 10)        
and	 $t0, $t0, $t1
# * BREQ              (ITemp 10)        (ICONS 0)         (LABEL LL00005)   
li	 $t1, 0
beq	 $t0, $t1, LL00005
# ----------------------------
# | Original source          |
# ----------------------------
# * 		for (j = 0; j < re.columns && j < 10; j++) { re.elements[i][j] = readInt(); }
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ASSIGN            (ICONS 0)                           (ILocal 4)        
li	 $t0, 0

sw	 $t0, 4($sp)
# * LABEL             (LABEL LL00006)                                       
LL00006:
# * LT                (ILocal 4)        (ILocal 12)       (ITemp 11)        
lw	 $s0, 4($sp)
lw	 $s1, 12($sp)
slt	 $t0, $s0, $s1
# * LT                (ILocal 4)        (ICONS 10)        (ITemp 12)        
li	 $t1, 10
slt	 $t1, $s0, $t1
# * LAND              (ITemp 11)        (ITemp 12)        (ITemp 13)        
and	 $t0, $t0, $t1
# * BREQ              (ITemp 13)        (ICONS 0)         (LABEL LL00007)   
li	 $t1, 0
beq	 $t0, $t1, LL00007
# * CALL                                                  (LABEL readInt1)  
sw	 $s0, 4($sp)
sw	 $s1, 12($sp)
jal	 readInt1
# * MULT              (ILocal 0)        (ICONS 40)        (ITemp 14)        
lw	 $s0, 0($sp)
li	 $t0, 40
mul	 $t0, $s0, $t0
# * MULT              (ILocal 4)        (ICONS 4)         (ITemp 15)        
lw	 $s1, 4($sp)
li	 $t1, 4
mul	 $t1, $s1, $t1
# * ADD               (ITemp 14)        (ITemp 15)        (ITemp 16)        
add	 $t0, $t0, $t1
# * ADD               (ICONS 16)        (ITemp 16)        (ITemp 17)        
li	 $t1, 16
add	 $t0, $t1, $t0
# * OFFSET            (ITemp 17)                                            
add	 $t0, $t0, $sp
# * ASSIGN            (ILocal -4)                         (IINDR 17)        
lw	 $s2, -4($sp)
move	 $t1, $s2
sw	 $t1, ($t0)
# * ADD               (ILocal 4)        (ICONS 1)         (ILocal 4)        
li	 $t0, 1
add	 $s1, $s1, $t0
sw	 $s1, 4($sp)
# ----------------------------
# | Original source          |
# ----------------------------
# * 	}
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * BR                                                    (LABEL LL00006)   
b	 LL00006
# ----------------------------
# | Original source          |
# ----------------------------
# * 
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * LABEL             (LABEL LL00007)                                       
LL00007:
# ----------------------------
# | Original source          |
# ----------------------------
# * 	for (i = 0; i < re.rows && i < 10; i++) {
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ADD               (ILocal 0)        (ICONS 1)         (ILocal 0)        
lw	 $s0, 0($sp)
li	 $t0, 1
add	 $s0, $s0, $t0
sw	 $s0, 0($sp)
# ----------------------------
# | Original source          |
# ----------------------------
# * 	}
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * BR                                                    (LABEL LL00004)   
b	 LL00004
# ----------------------------
# | Original source          |
# ----------------------------
# * 
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * LABEL             (LABEL LL00005)                                       
LL00005:
# ----------------------------
# | Original source          |
# ----------------------------
# * 	return re;
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * STRUCT_OUT        (ILocal 12)       (ICONS 408)       (ILocal 424)      
li	$t2, 12
add	$t2, $t2, $sp
li	$t3, 424
add	$t3, $t3, $sp
li	$t1, 0
li	$t0, 408
loopl34:
bge	 $t1, $t0, loopl35
lw	 $t4, ($t2)
sw	 $t4, ($t3)
addi	 $t2, $t2, 4
addi	 $t3, $t3, 4
addi	 $t1, $t1, 4
b	 loopl34
loopl35:
# * RETURN            (ICONS 420)       (ICONS 832)                         
lw	 $ra, 420($sp)
add	 $sp, $sp, 832
jr	 $ra
# ----------------------------
# | Original source          |
# ----------------------------
# * }
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * RETURN            (ICONS 420)       (ICONS 832)                         
lw	 $ra, 420($sp)
add	 $sp, $sp, 832
jr	 $ra
# ----------------------------
# | Original source          |
# ----------------------------
# * void printMatrix(struct Matrix m) {
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * LABEL             (LABEL printMatrix1)                                    
printMatrix1:
# * PROCENTRY         (ICONS 420)       (ICONS 0)                           
subi	$sp, $sp, 420
sw	$ra, 416($sp)
# ----------------------------
# | Original source          |
# ----------------------------
# * 	for (i = 0; i < m.rows && i < 10; i++) {
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ASSIGN            (ICONS 0)                           (ILocal 408)      
li	 $t0, 0

sw	 $t0, 408($sp)
# * LABEL             (LABEL LL00008)                                       
LL00008:
# * LT                (ILocal 408)      (ILocal 404)      (ITemp 18)        
lw	 $s0, 408($sp)
lw	 $s1, 404($sp)
slt	 $t0, $s0, $s1
# * LT                (ILocal 408)      (ICONS 10)        (ITemp 19)        
li	 $t1, 10
slt	 $t1, $s0, $t1
# * LAND              (ITemp 18)        (ITemp 19)        (ITemp 20)        
and	 $t0, $t0, $t1
# * BREQ              (ITemp 20)        (ICONS 0)         (LABEL LL00009)   
li	 $t1, 0
beq	 $t0, $t1, LL00009
# ----------------------------
# | Original source          |
# ----------------------------
# * 		for (j = 0; j < m.columns && j < 10; j++) {
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ASSIGN            (ICONS 0)                           (ILocal 412)      
li	 $t0, 0

sw	 $t0, 412($sp)
# * LABEL             (LABEL LL00010)                                       
LL00010:
# * LT                (ILocal 412)      (ILocal 0)        (ITemp 21)        
lw	 $s0, 412($sp)
lw	 $s1, 0($sp)
slt	 $t0, $s0, $s1
# * LT                (ILocal 412)      (ICONS 10)        (ITemp 22)        
li	 $t1, 10
slt	 $t1, $s0, $t1
# * LAND              (ITemp 21)        (ITemp 22)        (ITemp 23)        
and	 $t0, $t0, $t1
# * BREQ              (ITemp 23)        (ICONS 0)         (LABEL LL00011)   
li	 $t1, 0
beq	 $t0, $t1, LL00011
# ----------------------------
# | Original source          |
# ----------------------------
# * 			printInt(m.elements[i][j]);
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * MULT              (ILocal 408)      (ICONS 40)        (ITemp 24)        
lw	 $s2, 408($sp)
li	 $t0, 40
mul	 $t0, $s2, $t0
# * MULT              (ILocal 412)      (ICONS 4)         (ITemp 25)        
li	 $t1, 4
mul	 $t1, $s0, $t1
# * ADD               (ITemp 24)        (ITemp 25)        (ITemp 26)        
add	 $t0, $t0, $t1
# * ADD               (ICONS 4)         (ITemp 26)        (ITemp 27)        
li	 $t1, 4
add	 $t0, $t1, $t0
# * OFFSET            (ITemp 27)                                            
add	 $t0, $t0, $sp
# * ASSIGN            (IINDR 27)                          (ILocal -8)       
lw	 $t1, ($t0)

sw	 $t1, -8($sp)
# * CALL                                                  (LABEL printInt1) 
sw	 $s0, 412($sp)
sw	 $s1, 0($sp)
sw	 $s2, 408($sp)
jal	 printInt1
# ----------------------------
# | Original source          |
# ----------------------------
# * 			printChar((char) 9);
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ASSIGN            (ICONS 9)                           (ILocal -8)       
li	 $t0, 9

sw	 $t0, -8($sp)
# * CALL                                                  (LABEL printChar1)
jal	 printChar1
# ----------------------------
# | Original source          |
# ----------------------------
# * 		for (j = 0; j < m.columns && j < 10; j++) {
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ADD               (ILocal 412)      (ICONS 1)         (ILocal 412)      
lw	 $s0, 412($sp)
li	 $t0, 1
add	 $s0, $s0, $t0
sw	 $s0, 412($sp)
# ----------------------------
# | Original source          |
# ----------------------------
# * 	}
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * BR                                                    (LABEL LL00010)   
b	 LL00010
# ----------------------------
# | Original source          |
# ----------------------------
# * 
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * LABEL             (LABEL LL00011)                                       
LL00011:
# ----------------------------
# | Original source          |
# ----------------------------
# * 		printChar((char) 10);
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ASSIGN            (ICONS 10)                          (ILocal -8)       
li	 $t0, 10

sw	 $t0, -8($sp)
# * CALL                                                  (LABEL printChar1)
jal	 printChar1
# ----------------------------
# | Original source          |
# ----------------------------
# * 	for (i = 0; i < m.rows && i < 10; i++) {
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ADD               (ILocal 408)      (ICONS 1)         (ILocal 408)      
lw	 $s0, 408($sp)
li	 $t0, 1
add	 $s0, $s0, $t0
sw	 $s0, 408($sp)
# ----------------------------
# | Original source          |
# ----------------------------
# * 	}
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * BR                                                    (LABEL LL00008)   
b	 LL00008
# ----------------------------
# | Original source          |
# ----------------------------
# * 
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * LABEL             (LABEL LL00009)                                       
LL00009:
# ----------------------------
# | Original source          |
# ----------------------------
# * }
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * RETURN            (ICONS 416)       (ICONS 420)                         
lw	 $ra, 416($sp)
add	 $sp, $sp, 420
jr	 $ra
# ----------------------------
# | Original source          |
# ----------------------------
# * struct Matrix multiplyMatrices(struct Matrix m1, struct Matrix m2) {
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * LABEL             (LABEL multiplyMatrices1)                                    
multiplyMatrices1:
# * PROCENTRY         (ICONS 1648)      (ICONS 408)                         
subi	$sp, $sp, 1648
sw	$ra, 1236($sp)
# ----------------------------
# | Original source          |
# ----------------------------
# * 	if (m1.columns != m2.rows) {
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * NE                (ILocal 0)        (ILocal 812)      (ITemp 28)        
lw	 $s0, 0($sp)
lw	 $s1, 812($sp)
sne	 $t0, $s0, $s1
# * BREQ              (ITemp 28)        (ICONS 0)         (LABEL if12)      
li	 $t1, 0
beq	 $t0, $t1, if12
# ----------------------------
# | Original source          |
# ----------------------------
# * 		printChar('E');
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ASSIGN            (ICONS 69)                          (ILocal -8)       
li	 $t0, 69

sw	 $t0, -8($sp)
# * CALL                                                  (LABEL printChar1)
sw	 $s0, 0($sp)
sw	 $s1, 812($sp)
jal	 printChar1
# ----------------------------
# | Original source          |
# ----------------------------
# * 		printChar('R');
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ASSIGN            (ICONS 82)                          (ILocal -8)       
li	 $t0, 82

sw	 $t0, -8($sp)
# * CALL                                                  (LABEL printChar1)
jal	 printChar1
# * ASSIGN            (ICONS 82)                          (ILocal -8)       
li	 $t0, 82

sw	 $t0, -8($sp)
# * CALL                                                  (LABEL printChar1)
jal	 printChar1
# ----------------------------
# | Original source          |
# ----------------------------
# * 		printChar('O');
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ASSIGN            (ICONS 79)                          (ILocal -8)       
li	 $t0, 79

sw	 $t0, -8($sp)
# * CALL                                                  (LABEL printChar1)
jal	 printChar1
# ----------------------------
# | Original source          |
# ----------------------------
# * 		printChar('R');
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ASSIGN            (ICONS 82)                          (ILocal -8)       
li	 $t0, 82

sw	 $t0, -8($sp)
# * CALL                                                  (LABEL printChar1)
jal	 printChar1
# ----------------------------
# | Original source          |
# ----------------------------
# * 		printChar(':');
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ASSIGN            (ICONS 58)                          (ILocal -8)       
li	 $t0, 58

sw	 $t0, -8($sp)
# * CALL                                                  (LABEL printChar1)
jal	 printChar1
# ----------------------------
# | Original source          |
# ----------------------------
# * 		printChar(' ');
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ASSIGN            (ICONS 32)                          (ILocal -8)       
li	 $t0, 32

sw	 $t0, -8($sp)
# * CALL                                                  (LABEL printChar1)
jal	 printChar1
# ----------------------------
# | Original source          |
# ----------------------------
# * 		printChar('D');
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ASSIGN            (ICONS 68)                          (ILocal -8)       
li	 $t0, 68

sw	 $t0, -8($sp)
# * CALL                                                  (LABEL printChar1)
jal	 printChar1
# ----------------------------
# | Original source          |
# ----------------------------
# * 		printChar('I');
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ASSIGN            (ICONS 73)                          (ILocal -8)       
li	 $t0, 73

sw	 $t0, -8($sp)
# * CALL                                                  (LABEL printChar1)
jal	 printChar1
# ----------------------------
# | Original source          |
# ----------------------------
# * 		printChar('M');
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ASSIGN            (ICONS 77)                          (ILocal -8)       
li	 $t0, 77

sw	 $t0, -8($sp)
# * CALL                                                  (LABEL printChar1)
jal	 printChar1
# ----------------------------
# | Original source          |
# ----------------------------
# * 		printChar('E');
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ASSIGN            (ICONS 69)                          (ILocal -8)       
li	 $t0, 69

sw	 $t0, -8($sp)
# * CALL                                                  (LABEL printChar1)
jal	 printChar1
# ----------------------------
# | Original source          |
# ----------------------------
# * 		printChar('N');
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ASSIGN            (ICONS 78)                          (ILocal -8)       
li	 $t0, 78

sw	 $t0, -8($sp)
# * CALL                                                  (LABEL printChar1)
jal	 printChar1
# ----------------------------
# | Original source          |
# ----------------------------
# * 		printChar('S');
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ASSIGN            (ICONS 83)                          (ILocal -8)       
li	 $t0, 83

sw	 $t0, -8($sp)
# * CALL                                                  (LABEL printChar1)
jal	 printChar1
# ----------------------------
# | Original source          |
# ----------------------------
# * 		printChar('I');
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ASSIGN            (ICONS 73)                          (ILocal -8)       
li	 $t0, 73

sw	 $t0, -8($sp)
# * CALL                                                  (LABEL printChar1)
jal	 printChar1
# ----------------------------
# | Original source          |
# ----------------------------
# * 		printChar('O');
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ASSIGN            (ICONS 79)                          (ILocal -8)       
li	 $t0, 79

sw	 $t0, -8($sp)
# * CALL                                                  (LABEL printChar1)
jal	 printChar1
# ----------------------------
# | Original source          |
# ----------------------------
# * 		printChar('N');
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ASSIGN            (ICONS 78)                          (ILocal -8)       
li	 $t0, 78

sw	 $t0, -8($sp)
# * CALL                                                  (LABEL printChar1)
jal	 printChar1
# ----------------------------
# | Original source          |
# ----------------------------
# * 		printChar('S');
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ASSIGN            (ICONS 83)                          (ILocal -8)       
li	 $t0, 83

sw	 $t0, -8($sp)
# * CALL                                                  (LABEL printChar1)
jal	 printChar1
# ----------------------------
# | Original source          |
# ----------------------------
# * 		printChar((char) 10);
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ASSIGN            (ICONS 10)                          (ILocal -8)       
li	 $t0, 10

sw	 $t0, -8($sp)
# * CALL                                                  (LABEL printChar1)
jal	 printChar1
# ----------------------------
# | Original source          |
# ----------------------------
# * 		return re;
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * STRUCT_OUT        (ILocal 828)      (ICONS 408)       (ILocal 1240)     
li	$t2, 828
add	$t2, $t2, $sp
li	$t3, 1240
add	$t3, $t3, $sp
li	$t1, 0
li	$t0, 408
loopl36:
bge	 $t1, $t0, loopl37
lw	 $t4, ($t2)
sw	 $t4, ($t3)
addi	 $t2, $t2, 4
addi	 $t3, $t3, 4
addi	 $t1, $t1, 4
b	 loopl36
loopl37:
# * RETURN            (ICONS 1236)      (ICONS 1648)                        
lw	 $ra, 1236($sp)
add	 $sp, $sp, 1648
jr	 $ra
# ----------------------------
# | Original source          |
# ----------------------------
# * 	if (m1.columns != m2.rows) {
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * BR                                                    (LABEL if13)      
b	 if13
# ----------------------------
# | Original source          |
# ----------------------------
# * 	}
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * LABEL             (LABEL if12)                                          
if12:
# * LABEL             (LABEL if13)                                          
if13:
# ----------------------------
# | Original source          |
# ----------------------------
# * 	re.rows    = m1.rows;
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ASSIGN            (ILocal 404)                        (ILocal 1232)     
lw	 $s0, 404($sp)

sw	 $s0, 1232($sp)
# ----------------------------
# | Original source          |
# ----------------------------
# * 	re.columns = m2.columns;
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ASSIGN            (ILocal 408)                        (ILocal 828)      
lw	 $s0, 408($sp)

sw	 $s0, 828($sp)
# ----------------------------
# | Original source          |
# ----------------------------
# * 	for (i = 0; i < m1.rows; i++) {
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ASSIGN            (ICONS 0)                           (ILocal 816)      
li	 $t0, 0

sw	 $t0, 816($sp)
# * LABEL             (LABEL LL00014)                                       
LL00014:
# * LT                (ILocal 816)      (ILocal 404)      (ITemp 29)        
lw	 $s0, 816($sp)
lw	 $s1, 404($sp)
slt	 $t0, $s0, $s1
# * BREQ              (ITemp 29)        (ICONS 0)         (LABEL LL00015)   
li	 $t1, 0
beq	 $t0, $t1, LL00015
# ----------------------------
# | Original source          |
# ----------------------------
# * 		for (j = 0; j < m2.columns; j++) {
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ASSIGN            (ICONS 0)                           (ILocal 820)      
li	 $t0, 0

sw	 $t0, 820($sp)
# * LABEL             (LABEL LL00016)                                       
LL00016:
# * LT                (ILocal 820)      (ILocal 408)      (ITemp 30)        
lw	 $s0, 820($sp)
lw	 $s1, 408($sp)
slt	 $t0, $s0, $s1
# * BREQ              (ITemp 30)        (ICONS 0)         (LABEL LL00017)   
li	 $t1, 0
beq	 $t0, $t1, LL00017
# ----------------------------
# | Original source          |
# ----------------------------
# * 			re.elements[i][j] = 0;
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * MULT              (ILocal 816)      (ICONS 40)        (ITemp 31)        
lw	 $s2, 816($sp)
li	 $t0, 40
mul	 $t0, $s2, $t0
# * MULT              (ILocal 820)      (ICONS 4)         (ITemp 32)        
li	 $t1, 4
mul	 $t1, $s0, $t1
# * ADD               (ITemp 31)        (ITemp 32)        (ITemp 33)        
add	 $t0, $t0, $t1
# * ADD               (ICONS 832)       (ITemp 33)        (ITemp 34)        
li	 $t1, 832
add	 $t0, $t1, $t0
# * OFFSET            (ITemp 34)                                            
add	 $t0, $t0, $sp
# * ASSIGN            (ICONS 0)                           (IINDR 34)        
li	 $t1, 0
move	 $t1, $t1
sw	 $t1, ($t0)
# ----------------------------
# | Original source          |
# ----------------------------
# * 			for (k = 0; k < m2.rows; k++) {
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ASSIGN            (ICONS 0)                           (ILocal 824)      
li	 $t0, 0

sw	 $t0, 824($sp)
# * LABEL             (LABEL LL00018)                                       
LL00018:
# * LT                (ILocal 824)      (ILocal 812)      (ITemp 35)        
lw	 $s0, 824($sp)
lw	 $s1, 812($sp)
slt	 $t0, $s0, $s1
# * BREQ              (ITemp 35)        (ICONS 0)         (LABEL LL00019)   
li	 $t1, 0
beq	 $t0, $t1, LL00019
# ----------------------------
# | Original source          |
# ----------------------------
# * 				re.elements[i][j] += m1.elements[i][k] * m2.elements[k][j];
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * MULT              (ILocal 816)      (ICONS 40)        (ITemp 36)        
lw	 $s2, 816($sp)
li	 $t0, 40
mul	 $t0, $s2, $t0
# * MULT              (ILocal 820)      (ICONS 4)         (ITemp 37)        
lw	 $s3, 820($sp)
li	 $t1, 4
mul	 $t1, $s3, $t1
# * ADD               (ITemp 36)        (ITemp 37)        (ITemp 38)        
add	 $t0, $t0, $t1
# * ADD               (ICONS 832)       (ITemp 38)        (ITemp 39)        
li	 $t1, 832
add	 $t0, $t1, $t0
# * OFFSET            (ITemp 39)                                            
add	 $t0, $t0, $sp
# * MULT              (ILocal 816)      (ICONS 40)        (ITemp 40)        
li	 $t1, 40
mul	 $t1, $s2, $t1
# * MULT              (ILocal 824)      (ICONS 4)         (ITemp 41)        
li	 $t2, 4
mul	 $t2, $s0, $t2
# * ADD               (ITemp 40)        (ITemp 41)        (ITemp 42)        
add	 $t1, $t1, $t2
# * ADD               (ICONS 4)         (ITemp 42)        (ITemp 43)        
li	 $t2, 4
add	 $t1, $t2, $t1
# * OFFSET            (ITemp 43)                                            
add	 $t1, $t1, $sp
# * MULT              (ILocal 824)      (ICONS 40)        (ITemp 44)        
li	 $t2, 40
mul	 $t2, $s0, $t2
# * MULT              (ILocal 820)      (ICONS 4)         (ITemp 45)        
li	 $t3, 4
mul	 $t3, $s3, $t3
# * ADD               (ITemp 44)        (ITemp 45)        (ITemp 46)        
add	 $t2, $t2, $t3
# * ADD               (ICONS 412)       (ITemp 46)        (ITemp 47)        
li	 $t3, 412
add	 $t2, $t3, $t2
# * OFFSET            (ITemp 47)                                            
add	 $t2, $t2, $sp
# * MULT              (IINDR 43)        (IINDR 47)        (ITemp 48)        
lw	 $t3, ($t1)
lw	 $t4, ($t2)
mul	 $t3, $t3, $t4
# * ADD               (IINDR 39)        (ITemp 48)        (IINDR 39)        
lw	 $t4, ($t0)
add	 $t3, $t4, $t3
sw	 $t3, ($t0)
# ----------------------------
# | Original source          |
# ----------------------------
# * 			for (k = 0; k < m2.rows; k++) {
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ADD               (ILocal 824)      (ICONS 1)         (ILocal 824)      
li	 $t0, 1
add	 $s0, $s0, $t0
sw	 $s0, 824($sp)
# ----------------------------
# | Original source          |
# ----------------------------
# * 	}
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * BR                                                    (LABEL LL00018)   
b	 LL00018
# ----------------------------
# | Original source          |
# ----------------------------
# * 
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * LABEL             (LABEL LL00019)                                       
LL00019:
# ----------------------------
# | Original source          |
# ----------------------------
# * 		for (j = 0; j < m2.columns; j++) {
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ADD               (ILocal 820)      (ICONS 1)         (ILocal 820)      
lw	 $s0, 820($sp)
li	 $t0, 1
add	 $s0, $s0, $t0
sw	 $s0, 820($sp)
# ----------------------------
# | Original source          |
# ----------------------------
# * 	}
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * BR                                                    (LABEL LL00016)   
b	 LL00016
# ----------------------------
# | Original source          |
# ----------------------------
# * 
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * LABEL             (LABEL LL00017)                                       
LL00017:
# ----------------------------
# | Original source          |
# ----------------------------
# * 	for (i = 0; i < m1.rows; i++) {
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ADD               (ILocal 816)      (ICONS 1)         (ILocal 816)      
lw	 $s0, 816($sp)
li	 $t0, 1
add	 $s0, $s0, $t0
sw	 $s0, 816($sp)
# ----------------------------
# | Original source          |
# ----------------------------
# * 	}
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * BR                                                    (LABEL LL00014)   
b	 LL00014
# ----------------------------
# | Original source          |
# ----------------------------
# * 
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * LABEL             (LABEL LL00015)                                       
LL00015:
# ----------------------------
# | Original source          |
# ----------------------------
# * 	return re;
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * STRUCT_OUT        (ILocal 828)      (ICONS 408)       (ILocal 1240)     
li	$t2, 828
add	$t2, $t2, $sp
li	$t3, 1240
add	$t3, $t3, $sp
li	$t1, 0
li	$t0, 408
loopl38:
bge	 $t1, $t0, loopl39
lw	 $t4, ($t2)
sw	 $t4, ($t3)
addi	 $t2, $t2, 4
addi	 $t3, $t3, 4
addi	 $t1, $t1, 4
b	 loopl38
loopl39:
# * RETURN            (ICONS 1236)      (ICONS 1648)                        
lw	 $ra, 1236($sp)
add	 $sp, $sp, 1648
jr	 $ra
# ----------------------------
# | Original source          |
# ----------------------------
# * }
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * RETURN            (ICONS 1236)      (ICONS 1648)                        
lw	 $ra, 1236($sp)
add	 $sp, $sp, 1648
jr	 $ra

printInt1:
lw		$a0, -8($sp)		#
li		$v0, 1
syscall
jr		$ra					# jump to $ra

printFloat1:
s.s		$f12, -12($sp)		# Store $f12 just in case we're using it
l.s		$f12, -8($sp)		# Load output
li		$v0, 2
syscall
l.s		$f12, -12($sp)      # Then restore $f12 if it was used
jr		$ra					# jump to $ra


# TODO: printString1

printChar1:
lw		$a0, -8($sp)		#
li		$v0, 11
syscall
jr		$ra					# jump to $ra

readInt1:
li		$v0, 5
syscall
sw		$v0, -4($sp)
jr		$ra

readFloat1:
s.s		$f0, -12($sp)		# Store $f0 just in case we're using it
li		$v0, 6
syscall
s.s		$f0, -4($sp)
l.s		$f0, -12($sp)
jr		$ra

# TODO: readString1

readChar1:
li		$v0, 12
syscall
sw		$v0, -4($sp)
jr		$ra
