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
# * int main() {
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * LABEL             (LABEL main1)                                         
main1:
# * PROCENTRY         (ICONS 64)        (ICONS 0)                           
subi	$sp, $sp, 64
sw	$ra, 60($sp)
# ----------------------------
# | Original source          |
# ----------------------------
# * 	a[0][0] = 7;
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * MULT              (ICONS 0)         (ICONS 8)         (ITemp 0)         
li	 $t0, 0
li	 $t1, 8
mul	 $t0, $t0, $t1
# * MULT              (ICONS 0)         (ICONS 4)         (ITemp 1)         
li	 $t1, 0
li	 $t2, 4
mul	 $t1, $t1, $t2
# * ADD               (ITemp 0)         (ITemp 1)         (ITemp 2)         
add	 $t0, $t0, $t1
# * ADD               (ICONS 0)         (ITemp 2)         (ITemp 3)         
li	 $t1, 0
add	 $t0, $t1, $t0
# * OFFSET            (ITemp 3)                                             
add	 $t0, $t0, $sp
# * ASSIGN            (ICONS 7)                           (IINDR 3)         
li	 $t1, 7

sw	 $t1, ($t0)
# ----------------------------
# | Original source          |
# ----------------------------
# * 	a[0][1] = 3;
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * MULT              (ICONS 0)         (ICONS 8)         (ITemp 4)         
li	 $t0, 0
li	 $t1, 8
mul	 $t0, $t0, $t1
# * MULT              (ICONS 1)         (ICONS 4)         (ITemp 5)         
li	 $t1, 1
li	 $t2, 4
mul	 $t1, $t1, $t2
# * ADD               (ITemp 4)         (ITemp 5)         (ITemp 6)         
add	 $t0, $t0, $t1
# * ADD               (ICONS 0)         (ITemp 6)         (ITemp 7)         
li	 $t1, 0
add	 $t0, $t1, $t0
# * OFFSET            (ITemp 7)                                             
add	 $t0, $t0, $sp
# * ASSIGN            (ICONS 3)                           (IINDR 7)         
li	 $t1, 3

sw	 $t1, ($t0)
# ----------------------------
# | Original source          |
# ----------------------------
# * 	a[1][0] = 5;
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * MULT              (ICONS 1)         (ICONS 8)         (ITemp 8)         
li	 $t0, 1
li	 $t1, 8
mul	 $t0, $t0, $t1
# * MULT              (ICONS 0)         (ICONS 4)         (ITemp 9)         
li	 $t1, 0
li	 $t2, 4
mul	 $t1, $t1, $t2
# * ADD               (ITemp 8)         (ITemp 9)         (ITemp 10)        
add	 $t0, $t0, $t1
# * ADD               (ICONS 0)         (ITemp 10)        (ITemp 11)        
li	 $t1, 0
add	 $t0, $t1, $t0
# * OFFSET            (ITemp 11)                                            
add	 $t0, $t0, $sp
# * ASSIGN            (ICONS 5)                           (IINDR 11)        
li	 $t1, 5

sw	 $t1, ($t0)
# ----------------------------
# | Original source          |
# ----------------------------
# * 	a[1][1] = 1;
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * MULT              (ICONS 1)         (ICONS 8)         (ITemp 12)        
li	 $t0, 1
li	 $t1, 8
mul	 $t0, $t0, $t1
# * MULT              (ICONS 1)         (ICONS 4)         (ITemp 13)        
li	 $t1, 1
li	 $t2, 4
mul	 $t1, $t1, $t2
# * ADD               (ITemp 12)        (ITemp 13)        (ITemp 14)        
add	 $t0, $t0, $t1
# * ADD               (ICONS 0)         (ITemp 14)        (ITemp 15)        
li	 $t1, 0
add	 $t0, $t1, $t0
# * OFFSET            (ITemp 15)                                            
add	 $t0, $t0, $sp
# * ASSIGN            (ICONS 1)                           (IINDR 15)        
li	 $t1, 1

sw	 $t1, ($t0)
# ----------------------------
# | Original source          |
# ----------------------------
# * 	b[0][0] = 2;
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * MULT              (ICONS 0)         (ICONS 8)         (ITemp 16)        
li	 $t0, 0
li	 $t1, 8
mul	 $t0, $t0, $t1
# * MULT              (ICONS 0)         (ICONS 4)         (ITemp 17)        
li	 $t1, 0
li	 $t2, 4
mul	 $t1, $t1, $t2
# * ADD               (ITemp 16)        (ITemp 17)        (ITemp 18)        
add	 $t0, $t0, $t1
# * ADD               (ICONS 16)        (ITemp 18)        (ITemp 19)        
li	 $t1, 16
add	 $t0, $t1, $t0
# * OFFSET            (ITemp 19)                                            
add	 $t0, $t0, $sp
# * ASSIGN            (ICONS 2)                           (IINDR 19)        
li	 $t1, 2

sw	 $t1, ($t0)
# ----------------------------
# | Original source          |
# ----------------------------
# * 	b[0][1] = 6;
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * MULT              (ICONS 0)         (ICONS 8)         (ITemp 20)        
li	 $t0, 0
li	 $t1, 8
mul	 $t0, $t0, $t1
# * MULT              (ICONS 1)         (ICONS 4)         (ITemp 21)        
li	 $t1, 1
li	 $t2, 4
mul	 $t1, $t1, $t2
# * ADD               (ITemp 20)        (ITemp 21)        (ITemp 22)        
add	 $t0, $t0, $t1
# * ADD               (ICONS 16)        (ITemp 22)        (ITemp 23)        
li	 $t1, 16
add	 $t0, $t1, $t0
# * OFFSET            (ITemp 23)                                            
add	 $t0, $t0, $sp
# * ASSIGN            (ICONS 6)                           (IINDR 23)        
li	 $t1, 6

sw	 $t1, ($t0)
# ----------------------------
# | Original source          |
# ----------------------------
# * 	b[1][0] = 9;
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * MULT              (ICONS 1)         (ICONS 8)         (ITemp 24)        
li	 $t0, 1
li	 $t1, 8
mul	 $t0, $t0, $t1
# * MULT              (ICONS 0)         (ICONS 4)         (ITemp 25)        
li	 $t1, 0
li	 $t2, 4
mul	 $t1, $t1, $t2
# * ADD               (ITemp 24)        (ITemp 25)        (ITemp 26)        
add	 $t0, $t0, $t1
# * ADD               (ICONS 16)        (ITemp 26)        (ITemp 27)        
li	 $t1, 16
add	 $t0, $t1, $t0
# * OFFSET            (ITemp 27)                                            
add	 $t0, $t0, $sp
# * ASSIGN            (ICONS 9)                           (IINDR 27)        
li	 $t1, 9

sw	 $t1, ($t0)
# ----------------------------
# | Original source          |
# ----------------------------
# * 	b[1][1] = 2;
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * MULT              (ICONS 1)         (ICONS 8)         (ITemp 28)        
li	 $t0, 1
li	 $t1, 8
mul	 $t0, $t0, $t1
# * MULT              (ICONS 1)         (ICONS 4)         (ITemp 29)        
li	 $t1, 1
li	 $t2, 4
mul	 $t1, $t1, $t2
# * ADD               (ITemp 28)        (ITemp 29)        (ITemp 30)        
add	 $t0, $t0, $t1
# * ADD               (ICONS 16)        (ITemp 30)        (ITemp 31)        
li	 $t1, 16
add	 $t0, $t1, $t0
# * OFFSET            (ITemp 31)                                            
add	 $t0, $t0, $sp
# * ASSIGN            (ICONS 2)                           (IINDR 31)        
li	 $t1, 2

sw	 $t1, ($t0)
# ----------------------------
# | Original source          |
# ----------------------------
# * 	for (i = 0; i < 2; i++) {
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ASSIGN            (ICONS 0)                           (ILocal 48)       
li	 $t0, 0

sw	 $t0, 48($sp)
# * LABEL             (LABEL LL00000)                                       
LL00000:
# * LT                (ILocal 48)       (ICONS 2)         (ITemp 32)        
lw	 $s0, 48($sp)
li	 $t0, 2
slt	 $t0, $s0, $t0
# * BREQ              (ITemp 32)        (ICONS 0)         (LABEL LL00001)   
li	 $t1, 0
beq	 $t0, $t1, LL00001
# ----------------------------
# | Original source          |
# ----------------------------
# * 		for (j = 0; j < 2; j++) { c[i][j] = 0; }
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ASSIGN            (ICONS 0)                           (ILocal 52)       
li	 $t0, 0

sw	 $t0, 52($sp)
# * LABEL             (LABEL LL00002)                                       
LL00002:
# * LT                (ILocal 52)       (ICONS 2)         (ITemp 33)        
lw	 $s0, 52($sp)
li	 $t0, 2
slt	 $t0, $s0, $t0
# * BREQ              (ITemp 33)        (ICONS 0)         (LABEL LL00003)   
li	 $t1, 0
beq	 $t0, $t1, LL00003
# * MULT              (ILocal 48)       (ICONS 8)         (ITemp 34)        
lw	 $s1, 48($sp)
li	 $t0, 8
mul	 $t0, $s1, $t0
# * MULT              (ILocal 52)       (ICONS 4)         (ITemp 35)        
li	 $t1, 4
mul	 $t1, $s0, $t1
# * ADD               (ITemp 34)        (ITemp 35)        (ITemp 36)        
add	 $t0, $t0, $t1
# * ADD               (ICONS 32)        (ITemp 36)        (ITemp 37)        
li	 $t1, 32
add	 $t0, $t1, $t0
# * OFFSET            (ITemp 37)                                            
add	 $t0, $t0, $sp
# * ASSIGN            (ICONS 0)                           (IINDR 37)        
li	 $t1, 0

sw	 $t1, ($t0)
# * ADD               (ILocal 52)       (ICONS 1)         (ILocal 52)       
li	 $t0, 1
add	 $s0, $s0, $t0
sw	 $s0, 52($sp)
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
# * 	for (i = 0; i < 2; i++) {
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ADD               (ILocal 48)       (ICONS 1)         (ILocal 48)       
lw	 $s0, 48($sp)
li	 $t0, 1
add	 $s0, $s0, $t0
sw	 $s0, 48($sp)
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
# * 	for (i = 0; i < 2; i++) {
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ASSIGN            (ICONS 0)                           (ILocal 48)       
li	 $t0, 0

sw	 $t0, 48($sp)
# * LABEL             (LABEL LL00004)                                       
LL00004:
# * LT                (ILocal 48)       (ICONS 2)         (ITemp 38)        
lw	 $s0, 48($sp)
li	 $t0, 2
slt	 $t0, $s0, $t0
# * BREQ              (ITemp 38)        (ICONS 0)         (LABEL LL00005)   
li	 $t1, 0
beq	 $t0, $t1, LL00005
# ----------------------------
# | Original source          |
# ----------------------------
# * 		for (j = 0; j < 2; j++) {
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ASSIGN            (ICONS 0)                           (ILocal 52)       
li	 $t0, 0

sw	 $t0, 52($sp)
# * LABEL             (LABEL LL00006)                                       
LL00006:
# * LT                (ILocal 52)       (ICONS 2)         (ITemp 39)        
lw	 $s0, 52($sp)
li	 $t0, 2
slt	 $t0, $s0, $t0
# * BREQ              (ITemp 39)        (ICONS 0)         (LABEL LL00007)   
li	 $t1, 0
beq	 $t0, $t1, LL00007
# ----------------------------
# | Original source          |
# ----------------------------
# * 			for (k = 0; k < 2; k++) { c[i][j] += a[i][k] * b[k][j]; }
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ASSIGN            (ICONS 0)                           (ILocal 56)       
li	 $t0, 0

sw	 $t0, 56($sp)
# * LABEL             (LABEL LL00008)                                       
LL00008:
# * LT                (ILocal 56)       (ICONS 2)         (ITemp 40)        
lw	 $s0, 56($sp)
li	 $t0, 2
slt	 $t0, $s0, $t0
# * BREQ              (ITemp 40)        (ICONS 0)         (LABEL LL00009)   
li	 $t1, 0
beq	 $t0, $t1, LL00009
# * MULT              (ILocal 48)       (ICONS 8)         (ITemp 41)        
lw	 $s1, 48($sp)
li	 $t0, 8
mul	 $t0, $s1, $t0
# * MULT              (ILocal 52)       (ICONS 4)         (ITemp 42)        
lw	 $s2, 52($sp)
li	 $t1, 4
mul	 $t1, $s2, $t1
# * ADD               (ITemp 41)        (ITemp 42)        (ITemp 43)        
add	 $t0, $t0, $t1
# * ADD               (ICONS 32)        (ITemp 43)        (ITemp 44)        
li	 $t1, 32
add	 $t0, $t1, $t0
# * OFFSET            (ITemp 44)                                            
add	 $t0, $t0, $sp
# * MULT              (ILocal 48)       (ICONS 8)         (ITemp 45)        
li	 $t1, 8
mul	 $t1, $s1, $t1
# * MULT              (ILocal 56)       (ICONS 4)         (ITemp 46)        
li	 $t2, 4
mul	 $t2, $s0, $t2
# * ADD               (ITemp 45)        (ITemp 46)        (ITemp 47)        
add	 $t1, $t1, $t2
# * ADD               (ICONS 0)         (ITemp 47)        (ITemp 48)        
li	 $t2, 0
add	 $t1, $t2, $t1
# * OFFSET            (ITemp 48)                                            
add	 $t1, $t1, $sp
# * MULT              (ILocal 56)       (ICONS 8)         (ITemp 49)        
li	 $t2, 8
mul	 $t2, $s0, $t2
# * MULT              (ILocal 52)       (ICONS 4)         (ITemp 50)        
li	 $t3, 4
mul	 $t3, $s2, $t3
# * ADD               (ITemp 49)        (ITemp 50)        (ITemp 51)        
add	 $t2, $t2, $t3
# * ADD               (ICONS 16)        (ITemp 51)        (ITemp 52)        
li	 $t3, 16
add	 $t2, $t3, $t2
# * OFFSET            (ITemp 52)                                            
add	 $t2, $t2, $sp
# * MULT              (IINDR 48)        (IINDR 52)        (ITemp 53)        
lw	 $t3, ($t1)
lw	 $t4, ($t2)
mul	 $t3, $t3, $t4
# * ADD               (IINDR 44)        (ITemp 53)        (IINDR 44)        
lw	 $t4, ($t0)
add	 $t3, $t4, $t3
sw	 $t3, ($t0)
# * ADD               (ILocal 56)       (ICONS 1)         (ILocal 56)       
li	 $t0, 1
add	 $s0, $s0, $t0
sw	 $s0, 56($sp)
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
# * 		for (j = 0; j < 2; j++) {
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ADD               (ILocal 52)       (ICONS 1)         (ILocal 52)       
lw	 $s0, 52($sp)
li	 $t0, 1
add	 $s0, $s0, $t0
sw	 $s0, 52($sp)
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
# * 	for (i = 0; i < 2; i++) {
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ADD               (ILocal 48)       (ICONS 1)         (ILocal 48)       
lw	 $s0, 48($sp)
li	 $t0, 1
add	 $s0, $s0, $t0
sw	 $s0, 48($sp)
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
# * }
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * RETURN            (ICONS 60)        (ICONS 64)                          
lw	 $ra, 60($sp)
add	 $sp, $sp, 64
jr	 $ra
