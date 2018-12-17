	.data
something: .word 4
	.text
# * CALL                                                  (LABEL main1)     
jal	 main1
# * END                                                                     
li	 $v0, 10
syscall
# ----------------------------
# | Original source          |
# ----------------------------
# * int main() {
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * LABEL             (LABEL main1)                                         
main1:
# * PROCENTRY         (ICONS 908)       (ICONS 0)                           
subi	$sp, $sp, 908
sw	$ra, 904($sp)
# ----------------------------
# | Original source          |
# ----------------------------
# * 	char z  = 's';
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ASSIGN            (ICONS 115)                         (ILocal 900)      
li	 $t0, 115

sw	 $t0, 900($sp)
# ----------------------------
# | Original source          |
# ----------------------------
# * 	short x = 0, y = 2;
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ASSIGN            (ICONS 0)                           (ILocal 892)      
li	 $t0, 0

sw	 $t0, 892($sp)
# * ASSIGN            (ICONS 2)                           (ILocal 896)      
li	 $t0, 2

sw	 $t0, 896($sp)
# ----------------------------
# | Original source          |
# ----------------------------
# * 	t.s = 2;
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ASSIGN            (ICONS 2)                           (ILocal 872)      
li	 $t0, 2

sw	 $t0, 872($sp)
# ----------------------------
# | Original source          |
# ----------------------------
# * 	t.s = t.y[1] + g.d;
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * MULT              (ICONS 1)         (ICONS 4)         (ITemp 1)         
li	 $t0, 1
li	 $t1, 4
mul	 $t0, $t0, $t1
# * ADD               (ICONS 876)       (ITemp 1)         (ITemp 2)         
li	 $t1, 876
add	 $t0, $t1, $t0
# * OFFSET            (ITemp 2)                                             
add	 $t0, $t0, $sp
# * ASSIGN            (ILocal 8)                          (FTemp 3)         
lw	 $s0, 8($sp)
mtc1	 $s0, $f0
# * ADD               (FINDR 2)         (FTemp 3)         (FTemp 4)         
l.s	 $f2, ($t0)
add.s	 $f0, $f2, $f0
# * ASSIGN            (FTemp 4)                           (ITemp 0)         
mfc1	 $t1, $f0
# * ASSIGN            (ITemp 0)                           (ILocal 872)      

sw	 $t1, 872($sp)
# ----------------------------
# | Original source          |
# ----------------------------
# * 	something = 3;
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ASSIGN            (ICONS 3)                           (Global something)
li	 $t1, 3
move	 $s1, $t1
# ----------------------------
# | Original source          |
# ----------------------------
# * 	x = x + y / 2;
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * DIV               (ILocal 896)      (ICONS 2)         (ITemp 5)         
lw	 $s2, 896($sp)
li	 $t1, 2
div	 $t1, $s2, $t1
# * ADD               (ILocal 892)      (ITemp 5)         (ITemp 6)         
lw	 $s3, 892($sp)
add	 $t1, $s3, $t1
# * ASSIGN            (ITemp 6)                           (ILocal 892)      

sw	 $t1, 892($sp)
# ----------------------------
# | Original source          |
# ----------------------------
# * 	y *= 3 % z;
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * MOD               (ICONS 3)         (ILocal 900)      (ITemp 7)         
li	 $t1, 3
lw	 $s3, 900($sp)
rem	 $t1, $t1, $s3
# * MULT              (ILocal 896)      (ITemp 7)         (ILocal 896)      
mul	 $s2, $s2, $t1
sw	 $s2, 896($sp)
# ----------------------------
# | Original source          |
# ----------------------------
# * 	if (x == 2 || y > z / 2) {
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * EQ                (ILocal 892)      (ICONS 2)         (ITemp 8)         
lw	 $s2, 892($sp)
li	 $t1, 2
seq	 $t1, $s2, $t1
# * DIV               (ILocal 900)      (ICONS 2)         (ITemp 9)         
li	 $t2, 2
div	 $t2, $s3, $t2
# * GT                (ILocal 896)      (ITemp 9)         (ITemp 10)        
lw	 $s4, 896($sp)
sgt	 $t2, $s4, $t2
# * LOR               (ITemp 8)         (ITemp 10)        (ITemp 11)        
or	 $t1, $t1, $t2
# * BREQ              (ITemp 11)        (ICONS 0)         (LABEL if0)       
li	 $t2, 0
beq	 $t1, $t2, if0
# ----------------------------
# | Original source          |
# ----------------------------
# * 		z = 3;
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ASSIGN            (ICONS 3)                           (ILocal 900)      
li	 $t1, 3

sw	 $t1, 900($sp)
# ----------------------------
# | Original source          |
# ----------------------------
# * 	if (x == 2 || y > z / 2) {
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * BR                                                    (LABEL if1)       
b	 if1
# ----------------------------
# | Original source          |
# ----------------------------
# * 	}
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * LABEL             (LABEL if0)                                           
if0:
# ----------------------------
# | Original source          |
# ----------------------------
# * 	} else if (1) {
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * BREQ              (ICONS 1)         (ICONS 0)         (LABEL if2)       
li	 $t0, 1
li	 $t1, 0
beq	 $t0, $t1, if2
# ----------------------------
# | Original source          |
# ----------------------------
# * 		y = 3;
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ASSIGN            (ICONS 3)                           (ILocal 896)      
li	 $t0, 3

sw	 $t0, 896($sp)
# ----------------------------
# | Original source          |
# ----------------------------
# * 	} else if (1) {
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * BR                                                    (LABEL if3)       
b	 if3
# ----------------------------
# | Original source          |
# ----------------------------
# * 	}
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * LABEL             (LABEL if2)                                           
if2:
# ----------------------------
# | Original source          |
# ----------------------------
# * 		x = 2;
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ASSIGN            (ICONS 2)                           (ILocal 892)      
li	 $t0, 2

sw	 $t0, 892($sp)
# ----------------------------
# | Original source          |
# ----------------------------
# * 	}
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * LABEL             (LABEL if3)                                           
if3:
# * LABEL             (LABEL if1)                                           
if1:
# ----------------------------
# | Original source          |
# ----------------------------
# * 	if (x % y > q[y + z]) { q[x * y] = 42; }
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * MOD               (ILocal 892)      (ILocal 896)      (ITemp 12)        
lw	 $s0, 892($sp)
lw	 $s1, 896($sp)
rem	 $t0, $s0, $s1
# * ADD               (ILocal 896)      (ILocal 900)      (ITemp 13)        
lw	 $s2, 900($sp)
add	 $t1, $s1, $s2
# * MULT              (ITemp 13)        (ICONS 4)         (ITemp 13)        
li	 $t2, 4
mul	 $t1, $t1, $t2
# * ADD               (ICONS 664)       (ITemp 13)        (ITemp 15)        
li	 $t2, 664
add	 $t1, $t2, $t1
# * OFFSET            (ITemp 15)                                            
add	 $t1, $t1, $sp
# * GT                (ITemp 12)        (IINDR 15)        (ITemp 16)        
lw	 $t2, ($t1)
sgt	 $t0, $t0, $t2
# * BREQ              (ITemp 16)        (ICONS 0)         (LABEL if4)       
li	 $t2, 0
beq	 $t0, $t2, if4
# * MULT              (ILocal 892)      (ILocal 896)      (ITemp 17)        
mul	 $t0, $s0, $s1
# * MULT              (ITemp 17)        (ICONS 4)         (ITemp 17)        
li	 $t2, 4
mul	 $t0, $t0, $t2
# * ADD               (ICONS 664)       (ITemp 17)        (ITemp 19)        
li	 $t2, 664
add	 $t0, $t2, $t0
# * OFFSET            (ITemp 19)                                            
add	 $t0, $t0, $sp
# * ASSIGN            (ICONS 42)                          (IINDR 19)        
li	 $t2, 42

sw	 $t2, ($t0)
# * BR                                                    (LABEL if5)       
b	 if5
# ----------------------------
# | Original source          |
# ----------------------------
# * 	}
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * LABEL             (LABEL if4)                                           
if4:
# * LABEL             (LABEL if5)                                           
if5:
# ----------------------------
# | Original source          |
# ----------------------------
# * 	m[2][3]          = 3;
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * MULT              (ICONS 2)         (ICONS 20)        (ITemp 20)        
li	 $t0, 2
li	 $t1, 20
mul	 $t0, $t0, $t1
# * MULT              (ICONS 3)         (ICONS 4)         (ITemp 21)        
li	 $t1, 3
li	 $t2, 4
mul	 $t1, $t1, $t2
# * ADD               (ITemp 20)        (ITemp 21)        (ITemp 22)        
add	 $t0, $t0, $t1
# * ADD               (ICONS 16)        (ITemp 22)        (ITemp 23)        
li	 $t1, 16
add	 $t0, $t1, $t0
# * OFFSET            (ITemp 23)                                            
add	 $t0, $t0, $sp
# * ASSIGN            (ICONS 3)                           (IINDR 23)        
li	 $t1, 3

sw	 $t1, ($t0)
# ----------------------------
# | Original source          |
# ----------------------------
# * 	n[x + y][2][z]   = 4;
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ADD               (ILocal 892)      (ILocal 896)      (ITemp 24)        
lw	 $s0, 892($sp)
lw	 $s1, 896($sp)
add	 $t0, $s0, $s1
# * MULT              (ITemp 24)        (ICONS 96)        (ITemp 24)        
li	 $t1, 96
mul	 $t0, $t0, $t1
# * MULT              (ICONS 2)         (ICONS 16)        (ITemp 26)        
li	 $t1, 2
li	 $t2, 16
mul	 $t1, $t1, $t2
# * ADD               (ITemp 24)        (ITemp 26)        (ITemp 27)        
add	 $t0, $t0, $t1
# * MULT              (ILocal 900)      (ICONS 4)         (ITemp 28)        
lw	 $s2, 900($sp)
li	 $t1, 4
mul	 $t1, $s2, $t1
# * ADD               (ITemp 27)        (ITemp 28)        (ITemp 29)        
add	 $t0, $t0, $t1
# * ADD               (ICONS 56)        (ITemp 29)        (ITemp 30)        
li	 $t1, 56
add	 $t0, $t1, $t0
# * OFFSET            (ITemp 30)                                            
add	 $t0, $t0, $sp
# * ASSIGN            (ICONS 4)                           (IINDR 30)        
li	 $t1, 4

sw	 $t1, ($t0)
# ----------------------------
# | Original source          |
# ----------------------------
# * 	o[0][1][x][0][1] = o[1][1][x][y][1];
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * MULT              (ICONS 0)         (ICONS 64)        (ITemp 31)        
li	 $t0, 0
li	 $t1, 64
mul	 $t0, $t0, $t1
# * MULT              (ICONS 1)         (ICONS 32)        (ITemp 32)        
li	 $t1, 1
li	 $t2, 32
mul	 $t1, $t1, $t2
# * ADD               (ITemp 31)        (ITemp 32)        (ITemp 33)        
add	 $t0, $t0, $t1
# * MULT              (ILocal 892)      (ICONS 16)        (ITemp 34)        
li	 $t1, 16
mul	 $t1, $s0, $t1
# * ADD               (ITemp 33)        (ITemp 34)        (ITemp 35)        
add	 $t0, $t0, $t1
# * MULT              (ICONS 0)         (ICONS 8)         (ITemp 36)        
li	 $t1, 0
li	 $t2, 8
mul	 $t1, $t1, $t2
# * ADD               (ITemp 35)        (ITemp 36)        (ITemp 37)        
add	 $t0, $t0, $t1
# * MULT              (ICONS 1)         (ICONS 4)         (ITemp 38)        
li	 $t1, 1
li	 $t2, 4
mul	 $t1, $t1, $t2
# * ADD               (ITemp 37)        (ITemp 38)        (ITemp 39)        
add	 $t0, $t0, $t1
# * ADD               (ICONS 536)       (ITemp 39)        (ITemp 40)        
li	 $t1, 536
add	 $t0, $t1, $t0
# * OFFSET            (ITemp 40)                                            
add	 $t0, $t0, $sp
# * MULT              (ICONS 1)         (ICONS 64)        (ITemp 41)        
li	 $t1, 1
li	 $t2, 64
mul	 $t1, $t1, $t2
# * MULT              (ICONS 1)         (ICONS 32)        (ITemp 42)        
li	 $t2, 1
li	 $t3, 32
mul	 $t2, $t2, $t3
# * ADD               (ITemp 41)        (ITemp 42)        (ITemp 43)        
add	 $t1, $t1, $t2
# * MULT              (ILocal 892)      (ICONS 16)        (ITemp 44)        
li	 $t2, 16
mul	 $t2, $s0, $t2
# * ADD               (ITemp 43)        (ITemp 44)        (ITemp 45)        
add	 $t1, $t1, $t2
# * MULT              (ILocal 896)      (ICONS 8)         (ITemp 46)        
li	 $t2, 8
mul	 $t2, $s1, $t2
# * ADD               (ITemp 45)        (ITemp 46)        (ITemp 47)        
add	 $t1, $t1, $t2
# * MULT              (ICONS 1)         (ICONS 4)         (ITemp 48)        
li	 $t2, 1
li	 $t3, 4
mul	 $t2, $t2, $t3
# * ADD               (ITemp 47)        (ITemp 48)        (ITemp 49)        
add	 $t1, $t1, $t2
# * ADD               (ICONS 536)       (ITemp 49)        (ITemp 50)        
li	 $t2, 536
add	 $t1, $t2, $t1
# * OFFSET            (ITemp 50)                                            
add	 $t1, $t1, $sp
# * ASSIGN            (IINDR 50)                          (IINDR 40)        
lw	 $t2, ($t1)

sw	 $t2, ($t0)
# ----------------------------
# | Original source          |
# ----------------------------
# * 	for (x = 0; x < 4; x++) { q[x] = y * x; }
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ASSIGN            (ICONS 0)                           (ILocal 892)      
li	 $t0, 0

sw	 $t0, 892($sp)
# * LABEL             (LABEL LL00006)                                       
LL00006:
# * LT                (ILocal 892)      (ICONS 4)         (ITemp 51)        
lw	 $s0, 892($sp)
li	 $t0, 4
slt	 $t0, $s0, $t0
# * BREQ              (ITemp 51)        (ICONS 0)         (LABEL LL00007)   
li	 $t1, 0
beq	 $t0, $t1, LL00007
# * MULT              (ILocal 892)      (ICONS 4)         (ITemp 52)        
li	 $t0, 4
mul	 $t0, $s0, $t0
# * ADD               (ICONS 664)       (ITemp 52)        (ITemp 53)        
li	 $t1, 664
add	 $t0, $t1, $t0
# * OFFSET            (ITemp 53)                                            
add	 $t0, $t0, $sp
# * MULT              (ILocal 896)      (ILocal 892)      (ITemp 54)        
lw	 $s1, 896($sp)
mul	 $t1, $s1, $s0
# * ASSIGN            (ITemp 54)                          (IINDR 53)        

sw	 $t1, ($t0)
# * ADD               (ILocal 892)      (ICONS 1)         (ILocal 892)      
li	 $t0, 1
add	 $s0, $s0, $t0
sw	 $s0, 892($sp)
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
# * 	blah(q[2] + 3 * 4);
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * MULT              (ICONS 2)         (ICONS 4)         (ITemp 55)        
li	 $t0, 2
li	 $t1, 4
mul	 $t0, $t0, $t1
# * ADD               (ICONS 664)       (ITemp 55)        (ITemp 56)        
li	 $t1, 664
add	 $t0, $t1, $t0
# * OFFSET            (ITemp 56)                                            
add	 $t0, $t0, $sp
# * MULT              (ICONS 3)         (ICONS 4)         (ITemp 57)        
li	 $t1, 3
li	 $t2, 4
mul	 $t1, $t1, $t2
# * ADD               (IINDR 56)        (ITemp 57)        (ITemp 58)        
lw	 $t2, ($t0)
add	 $t1, $t2, $t1
# * ASSIGN            (ITemp 58)                          (ILocal -8)       

sw	 $t1, -8($sp)
# * CALL                                                  (LABEL blah2)     
jal	 blah2
# ----------------------------
# | Original source          |
# ----------------------------
# * 	blah(z);
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ASSIGN            (ILocal 900)                        (ILocal -8)       
lw	 $s0, 900($sp)

sw	 $s0, -8($sp)
# * CALL                                                  (LABEL blah3)     
jal	 blah3
# ----------------------------
# | Original source          |
# ----------------------------
# * 	blah();
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * CALL                                                  (LABEL blah1)     
jal	 blah1
# ----------------------------
# | Original source          |
# ----------------------------
# * }
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * RETURN            (ICONS 904)       (ICONS 908)                         
lw	 $ra, 904($sp)
add	 $sp, $sp, 908
jr	 $ra
# ----------------------------
# | Original source          |
# ----------------------------
# * void blah(int y) {
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * LABEL             (LABEL blah2)                                         
blah2:
# * PROCENTRY         (ICONS 8)         (ICONS 0)                           
subi	$sp, $sp, 8
sw	$ra, 4($sp)
# ----------------------------
# | Original source          |
# ----------------------------
# * 	int x = y * 2;
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * MULT              (ILocal 0)        (ICONS 2)         (ITemp 59)        
lw	 $s0, 0($sp)
li	 $t0, 2
mul	 $t0, $s0, $t0
# * ASSIGN            (ITemp 59)                          (ILocal 4)        

sw	 $t0, 4($sp)
# ----------------------------
# | Original source          |
# ----------------------------
# * 	blah(x);
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ASSIGN            (ILocal 4)                          (ILocal -8)       
lw	 $s1, 4($sp)

sw	 $s1, -8($sp)
# * CALL                                                  (LABEL blah2)     
sw	 $s0, 0($sp)
jal	 blah2
# ----------------------------
# | Original source          |
# ----------------------------
# * 	blah(y);
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ASSIGN            (ILocal 0)                          (ILocal -8)       
lw	 $s0, 0($sp)

sw	 $s0, -8($sp)
# * CALL                                                  (LABEL blah2)     
jal	 blah2
# ----------------------------
# | Original source          |
# ----------------------------
# * }
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * RETURN            (ICONS 4)         (ICONS 8)                           
lw	 $ra, 4($sp)
add	 $sp, $sp, 8
jr	 $ra
# ----------------------------
# | Original source          |
# ----------------------------
# * void blah(char y) {
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * LABEL             (LABEL blah3)                                         
blah3:
# * PROCENTRY         (ICONS 8)         (ICONS 0)                           
subi	$sp, $sp, 8
sw	$ra, 4($sp)
# ----------------------------
# | Original source          |
# ----------------------------
# * 	char x = 0;
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ASSIGN            (ICONS 0)                           (ILocal 4)        
li	 $t0, 0

sw	 $t0, 4($sp)
# ----------------------------
# | Original source          |
# ----------------------------
# * }
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * RETURN            (ICONS 4)         (ICONS 8)                           
lw	 $ra, 4($sp)
add	 $sp, $sp, 8
jr	 $ra
