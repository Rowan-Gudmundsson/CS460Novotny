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
# * PROCENTRY         (ICONS 68)        (ICONS 0)                           
subi	$sp, $sp, 68
sw	$ra, 60($sp)
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
# * LT                (ILocal 48)       (ICONS 2)         (ITemp 0)         
lw	 $s0, 48($sp)
li	 $t0, 2
slt	 $t0, $s0, $t0
# * BREQ              (ITemp 0)         (ICONS 0)         (LABEL LL00001)   
li	 $t1, 0
beq	 $t0, $t1, LL00001
# ----------------------------
# | Original source          |
# ----------------------------
# * 		for (j = 0; j < 2; j++) { a[i][j] = readInt(); }
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
# * LT                (ILocal 52)       (ICONS 2)         (ITemp 1)         
lw	 $s0, 52($sp)
li	 $t0, 2
slt	 $t0, $s0, $t0
# * BREQ              (ITemp 1)         (ICONS 0)         (LABEL LL00003)   
li	 $t1, 0
beq	 $t0, $t1, LL00003
# * CALL                                                  (LABEL readInt1)  
sw	 $s0, 52($sp)
jal	 readInt1
# * MULT              (ILocal 48)       (ICONS 8)         (ITemp 2)         
lw	 $s0, 48($sp)
li	 $t0, 8
mul	 $t0, $s0, $t0
# * MULT              (ILocal 52)       (ICONS 4)         (ITemp 3)         
lw	 $s1, 52($sp)
li	 $t1, 4
mul	 $t1, $s1, $t1
# * ADD               (ITemp 2)         (ITemp 3)         (ITemp 4)         
add	 $t0, $t0, $t1
# * ADD               (ICONS 0)         (ITemp 4)         (ITemp 5)         
li	 $t1, 0
add	 $t0, $t1, $t0
# * OFFSET            (ITemp 5)                                             
add	 $t0, $t0, $sp
# * ASSIGN            (PTR -4)                            (IINDR 5)         
lw	 $t1, -4($sp)
lw	 $t1, ($t1)
move	 $t1, $t1
sw	 $t1, ($t0)
# * ADD               (ILocal 52)       (ICONS 1)         (ILocal 52)       
li	 $t0, 1
add	 $s1, $s1, $t0
sw	 $s1, 52($sp)
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
# * 	printChar((char) 10);
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ASSIGN            (ICONS 10)                          (ILocal -12)      
li	 $t0, 10

sw	 $t0, -12($sp)
# * CALL                                                  (LABEL printChar1)
jal	 printChar1
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
# * LT                (ILocal 48)       (ICONS 2)         (ITemp 6)         
lw	 $s0, 48($sp)
li	 $t0, 2
slt	 $t0, $s0, $t0
# * BREQ              (ITemp 6)         (ICONS 0)         (LABEL LL00005)   
li	 $t1, 0
beq	 $t0, $t1, LL00005
# ----------------------------
# | Original source          |
# ----------------------------
# * 		for (j = 0; j < 2; j++) { b[i][j] = readInt(); }
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
# * LT                (ILocal 52)       (ICONS 2)         (ITemp 7)         
lw	 $s0, 52($sp)
li	 $t0, 2
slt	 $t0, $s0, $t0
# * BREQ              (ITemp 7)         (ICONS 0)         (LABEL LL00007)   
li	 $t1, 0
beq	 $t0, $t1, LL00007
# * CALL                                                  (LABEL readInt1)  
sw	 $s0, 52($sp)
jal	 readInt1
# * MULT              (ILocal 48)       (ICONS 8)         (ITemp 8)         
lw	 $s0, 48($sp)
li	 $t0, 8
mul	 $t0, $s0, $t0
# * MULT              (ILocal 52)       (ICONS 4)         (ITemp 9)         
lw	 $s1, 52($sp)
li	 $t1, 4
mul	 $t1, $s1, $t1
# * ADD               (ITemp 8)         (ITemp 9)         (ITemp 10)        
add	 $t0, $t0, $t1
# * ADD               (ICONS 16)        (ITemp 10)        (ITemp 11)        
li	 $t1, 16
add	 $t0, $t1, $t0
# * OFFSET            (ITemp 11)                                            
add	 $t0, $t0, $sp
# * ASSIGN            (PTR -4)                            (IINDR 11)        
lw	 $t1, -4($sp)
lw	 $t1, ($t1)
move	 $t1, $t1
sw	 $t1, ($t0)
# * ADD               (ILocal 52)       (ICONS 1)         (ILocal 52)       
li	 $t0, 1
add	 $s1, $s1, $t0
sw	 $s1, 52($sp)
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
# * 	for (i = 0; i < 2; i++) {
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ASSIGN            (ICONS 0)                           (ILocal 48)       
li	 $t0, 0

sw	 $t0, 48($sp)
# * LABEL             (LABEL LL00008)                                       
LL00008:
# * LT                (ILocal 48)       (ICONS 2)         (ITemp 12)        
lw	 $s0, 48($sp)
li	 $t0, 2
slt	 $t0, $s0, $t0
# * BREQ              (ITemp 12)        (ICONS 0)         (LABEL LL00009)   
li	 $t1, 0
beq	 $t0, $t1, LL00009
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
# * LABEL             (LABEL LL00010)                                       
LL00010:
# * LT                (ILocal 52)       (ICONS 2)         (ITemp 13)        
lw	 $s0, 52($sp)
li	 $t0, 2
slt	 $t0, $s0, $t0
# * BREQ              (ITemp 13)        (ICONS 0)         (LABEL LL00011)   
li	 $t1, 0
beq	 $t0, $t1, LL00011
# * MULT              (ILocal 48)       (ICONS 8)         (ITemp 14)        
lw	 $s1, 48($sp)
li	 $t0, 8
mul	 $t0, $s1, $t0
# * MULT              (ILocal 52)       (ICONS 4)         (ITemp 15)        
li	 $t1, 4
mul	 $t1, $s0, $t1
# * ADD               (ITemp 14)        (ITemp 15)        (ITemp 16)        
add	 $t0, $t0, $t1
# * ADD               (ICONS 32)        (ITemp 16)        (ITemp 17)        
li	 $t1, 32
add	 $t0, $t1, $t0
# * OFFSET            (ITemp 17)                                            
add	 $t0, $t0, $sp
# * ASSIGN            (ICONS 0)                           (IINDR 17)        
li	 $t1, 0
move	 $t1, $t1
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
# * 	for (i = 0; i < 2; i++) {
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ASSIGN            (ICONS 0)                           (ILocal 48)       
li	 $t0, 0

sw	 $t0, 48($sp)
# * LABEL             (LABEL LL00012)                                       
LL00012:
# * LT                (ILocal 48)       (ICONS 2)         (ITemp 18)        
lw	 $s0, 48($sp)
li	 $t0, 2
slt	 $t0, $s0, $t0
# * BREQ              (ITemp 18)        (ICONS 0)         (LABEL LL00013)   
li	 $t1, 0
beq	 $t0, $t1, LL00013
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
# * LABEL             (LABEL LL00014)                                       
LL00014:
# * LT                (ILocal 52)       (ICONS 2)         (ITemp 19)        
lw	 $s0, 52($sp)
li	 $t0, 2
slt	 $t0, $s0, $t0
# * BREQ              (ITemp 19)        (ICONS 0)         (LABEL LL00015)   
li	 $t1, 0
beq	 $t0, $t1, LL00015
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
# * LABEL             (LABEL LL00016)                                       
LL00016:
# * LT                (ILocal 56)       (ICONS 2)         (ITemp 20)        
lw	 $s0, 56($sp)
li	 $t0, 2
slt	 $t0, $s0, $t0
# * BREQ              (ITemp 20)        (ICONS 0)         (LABEL LL00017)   
li	 $t1, 0
beq	 $t0, $t1, LL00017
# * MULT              (ILocal 48)       (ICONS 8)         (ITemp 21)        
lw	 $s1, 48($sp)
li	 $t0, 8
mul	 $t0, $s1, $t0
# * MULT              (ILocal 52)       (ICONS 4)         (ITemp 22)        
lw	 $s2, 52($sp)
li	 $t1, 4
mul	 $t1, $s2, $t1
# * ADD               (ITemp 21)        (ITemp 22)        (ITemp 23)        
add	 $t0, $t0, $t1
# * ADD               (ICONS 32)        (ITemp 23)        (ITemp 24)        
li	 $t1, 32
add	 $t0, $t1, $t0
# * OFFSET            (ITemp 24)                                            
add	 $t0, $t0, $sp
# * MULT              (ILocal 48)       (ICONS 8)         (ITemp 25)        
li	 $t1, 8
mul	 $t1, $s1, $t1
# * MULT              (ILocal 56)       (ICONS 4)         (ITemp 26)        
li	 $t2, 4
mul	 $t2, $s0, $t2
# * ADD               (ITemp 25)        (ITemp 26)        (ITemp 27)        
add	 $t1, $t1, $t2
# * ADD               (ICONS 0)         (ITemp 27)        (ITemp 28)        
li	 $t2, 0
add	 $t1, $t2, $t1
# * OFFSET            (ITemp 28)                                            
add	 $t1, $t1, $sp
# * MULT              (ILocal 56)       (ICONS 8)         (ITemp 29)        
li	 $t2, 8
mul	 $t2, $s0, $t2
# * MULT              (ILocal 52)       (ICONS 4)         (ITemp 30)        
li	 $t3, 4
mul	 $t3, $s2, $t3
# * ADD               (ITemp 29)        (ITemp 30)        (ITemp 31)        
add	 $t2, $t2, $t3
# * ADD               (ICONS 16)        (ITemp 31)        (ITemp 32)        
li	 $t3, 16
add	 $t2, $t3, $t2
# * OFFSET            (ITemp 32)                                            
add	 $t2, $t2, $sp
# * MULT              (IINDR 28)        (IINDR 32)        (ITemp 33)        
lw	 $t3, ($t1)
lw	 $t4, ($t2)
mul	 $t3, $t3, $t4
# * ADD               (IINDR 24)        (ITemp 33)        (IINDR 24)        
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
# * BR                                                    (LABEL LL00012)   
b	 LL00012
# ----------------------------
# | Original source          |
# ----------------------------
# * 
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * LABEL             (LABEL LL00013)                                       
LL00013:
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
# * LABEL             (LABEL LL00018)                                       
LL00018:
# * LT                (ILocal 48)       (ICONS 2)         (ITemp 34)        
lw	 $s0, 48($sp)
li	 $t0, 2
slt	 $t0, $s0, $t0
# * BREQ              (ITemp 34)        (ICONS 0)         (LABEL LL00019)   
li	 $t1, 0
beq	 $t0, $t1, LL00019
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
# * LABEL             (LABEL LL00020)                                       
LL00020:
# * LT                (ILocal 52)       (ICONS 2)         (ITemp 35)        
lw	 $s0, 52($sp)
li	 $t0, 2
slt	 $t0, $s0, $t0
# * BREQ              (ITemp 35)        (ICONS 0)         (LABEL LL00021)   
li	 $t1, 0
beq	 $t0, $t1, LL00021
# ----------------------------
# | Original source          |
# ----------------------------
# * 			printInt(c[i][j]);
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * MULT              (ILocal 48)       (ICONS 8)         (ITemp 36)        
lw	 $s1, 48($sp)
li	 $t0, 8
mul	 $t0, $s1, $t0
# * MULT              (ILocal 52)       (ICONS 4)         (ITemp 37)        
li	 $t1, 4
mul	 $t1, $s0, $t1
# * ADD               (ITemp 36)        (ITemp 37)        (ITemp 38)        
add	 $t0, $t0, $t1
# * ADD               (ICONS 32)        (ITemp 38)        (ITemp 39)        
li	 $t1, 32
add	 $t0, $t1, $t0
# * OFFSET            (ITemp 39)                                            
add	 $t0, $t0, $sp
# * ASSIGN            (IINDR 39)                          (ILocal -12)      
lw	 $t1, ($t0)

sw	 $t1, -12($sp)
# * CALL                                                  (LABEL printInt1) 
sw	 $s0, 52($sp)
sw	 $s1, 48($sp)
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
# * ASSIGN            (ICONS 9)                           (ILocal -12)      
li	 $t0, 9

sw	 $t0, -12($sp)
# * CALL                                                  (LABEL printChar1)
jal	 printChar1
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
# * BR                                                    (LABEL LL00020)   
b	 LL00020
# ----------------------------
# | Original source          |
# ----------------------------
# * 
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * LABEL             (LABEL LL00021)                                       
LL00021:
# ----------------------------
# | Original source          |
# ----------------------------
# * 		printChar((char) 10);
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ASSIGN            (ICONS 10)                          (ILocal -12)      
li	 $t0, 10

sw	 $t0, -12($sp)
# * CALL                                                  (LABEL printChar1)
jal	 printChar1
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
# * }
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * RETURN            (ICONS 60)        (ICONS 68)                          
lw	 $ra, 60($sp)
add	 $sp, $sp, 68
jr	 $ra
printInt1:
lw		$a0, -12($sp)		#
li		$v0, 1
syscall
jr		$ra					# jump to $ra

printFloat1:
s.s		$f12, -16($sp)		# Store $f12 just in case we're using it
l.s		$f12, -12($sp)		# Load output
li		$v0, 2
syscall
l.s		$f12, -16($sp)      # Then restore $f12 if it was used
jr		$ra					# jump to $ra


# TODO: printString1

printChar1:
lw		$a0, -12($sp)		#
li		$v0, 11
syscall
jr		$ra					# jump to $ra

readInt1:
li		$v0, 5
syscall
sw		$v0, -8($sp)
add		$v0, $sp, -8
sw		$v0, -4($sp)
jr		$ra

readFloat1:
s.s		$f0, -12($sp)		# Store $f0 just in case we're using it
li		$v0, 6
syscall
s.s		$f0, -8($sp)
add		$v0, $sp, -8
sw		$v0, -4($sp)
l.s		$f0, -12($sp)
jr		$ra

# TODO: readString1

readChar1:
li		$v0, 12
syscall
sw		$v0, -4($sp)
jr		$ra
