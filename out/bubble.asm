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
# * PROCENTRY         (ICONS 60)        (ICONS 0)                           
subi	$sp, $sp, 60
sw	$ra, 56($sp)
# ----------------------------
# | Original source          |
# ----------------------------
# * 	for (i = 0; i < 10; i++) { arr[i] = 10 - i; }
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ASSIGN            (ICONS 0)                           (ILocal 44)       
li	 $t0, 0

sw	 $t0, 44($sp)
# * LABEL             (LABEL LL00000)                                       
LL00000:
# * LT                (ILocal 44)       (ICONS 10)        (ITemp 0)         
lw	 $s0, 44($sp)
li	 $t0, 10
slt	 $t0, $s0, $t0
# * BREQ              (ITemp 0)         (ICONS 0)         (LABEL LL00001)   
li	 $t1, 0
beq	 $t0, $t1, LL00001
# * MULT              (ILocal 44)       (ICONS 4)         (ITemp 1)         
li	 $t0, 4
mul	 $t0, $s0, $t0
# * ADD               (ICONS 0)         (ITemp 1)         (ITemp 2)         
li	 $t1, 0
add	 $t0, $t1, $t0
# * OFFSET            (ITemp 2)                                             
add	 $t0, $t0, $sp
# * SUB               (ICONS 10)        (ILocal 44)       (ITemp 3)         
li	 $t1, 10
sub	 $t1, $t1, $s0
# * ASSIGN            (ITemp 3)                           (IINDR 2)         

sw	 $t1, ($t0)
# * ADD               (ILocal 44)       (ICONS 1)         (ILocal 44)       
li	 $t0, 1
add	 $s0, $s0, $t0
sw	 $s0, 44($sp)
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
# * 	for (upperBound = 10; upperBound > 0; upperBound--) {
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ASSIGN            (ICONS 10)                          (ILocal 52)       
li	 $t0, 10

sw	 $t0, 52($sp)
# * LABEL             (LABEL LL00002)                                       
LL00002:
# * GT                (ILocal 52)       (ICONS 0)         (ITemp 4)         
lw	 $s0, 52($sp)
li	 $t0, 0
sgt	 $t0, $s0, $t0
# * BREQ              (ITemp 4)         (ICONS 0)         (LABEL LL00003)   
li	 $t1, 0
beq	 $t0, $t1, LL00003
# ----------------------------
# | Original source          |
# ----------------------------
# * 		for (currentIndex = 0; currentIndex < upperBound; currentIndex++) {
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ASSIGN            (ICONS 0)                           (ILocal 40)       
li	 $t0, 0

sw	 $t0, 40($sp)
# * LABEL             (LABEL LL00004)                                       
LL00004:
# * LT                (ILocal 40)       (ILocal 52)       (ITemp 5)         
lw	 $s0, 40($sp)
lw	 $s1, 52($sp)
slt	 $t0, $s0, $s1
# * BREQ              (ITemp 5)         (ICONS 0)         (LABEL LL00005)   
li	 $t1, 0
beq	 $t0, $t1, LL00005
# ----------------------------
# | Original source          |
# ----------------------------
# * 			if (arr[currentIndex] > arr[currentIndex + 1]) {
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * MULT              (ILocal 40)       (ICONS 4)         (ITemp 6)         
li	 $t0, 4
mul	 $t0, $s0, $t0
# * ADD               (ICONS 0)         (ITemp 6)         (ITemp 7)         
li	 $t1, 0
add	 $t0, $t1, $t0
# * OFFSET            (ITemp 7)                                             
add	 $t0, $t0, $sp
# * ADD               (ILocal 40)       (ICONS 1)         (ITemp 8)         
li	 $t1, 1
add	 $t1, $s0, $t1
# * MULT              (ITemp 8)         (ICONS 4)         (ITemp 8)         
li	 $t2, 4
mul	 $t1, $t1, $t2
# * ADD               (ICONS 0)         (ITemp 8)         (ITemp 10)        
li	 $t2, 0
add	 $t1, $t2, $t1
# * OFFSET            (ITemp 10)                                            
add	 $t1, $t1, $sp
# * GT                (IINDR 7)         (IINDR 10)        (ITemp 11)        
lw	 $t2, ($t0)
lw	 $t3, ($t1)
sgt	 $t2, $t2, $t3
# * BREQ              (ITemp 11)        (ICONS 0)         (LABEL if6)       
li	 $t3, 0
beq	 $t2, $t3, if6
# ----------------------------
# | Original source          |
# ----------------------------
# * 				swapTemp              = arr[currentIndex];
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * MULT              (ILocal 40)       (ICONS 4)         (ITemp 12)        
li	 $t2, 4
mul	 $t2, $s0, $t2
# * ADD               (ICONS 0)         (ITemp 12)        (ITemp 13)        
li	 $t3, 0
add	 $t2, $t3, $t2
# * OFFSET            (ITemp 13)                                            
add	 $t2, $t2, $sp
# * ASSIGN            (IINDR 13)                          (ILocal 48)       
lw	 $t3, ($t2)

sw	 $t3, 48($sp)
# ----------------------------
# | Original source          |
# ----------------------------
# * 				arr[currentIndex]     = arr[currentIndex + 1];
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * MULT              (ILocal 40)       (ICONS 4)         (ITemp 14)        
li	 $t3, 4
mul	 $t3, $s0, $t3
# * ADD               (ICONS 0)         (ITemp 14)        (ITemp 15)        
li	 $t4, 0
add	 $t3, $t4, $t3
# * OFFSET            (ITemp 15)                                            
add	 $t3, $t3, $sp
# * ADD               (ILocal 40)       (ICONS 1)         (ITemp 16)        
li	 $t4, 1
add	 $t4, $s0, $t4
# * MULT              (ITemp 16)        (ICONS 4)         (ITemp 16)        
li	 $t5, 4
mul	 $t4, $t4, $t5
# * ADD               (ICONS 0)         (ITemp 16)        (ITemp 18)        
li	 $t5, 0
add	 $t4, $t5, $t4
# * OFFSET            (ITemp 18)                                            
add	 $t4, $t4, $sp
# * ASSIGN            (IINDR 18)                          (IINDR 15)        
lw	 $t5, ($t4)

sw	 $t5, ($t3)
# ----------------------------
# | Original source          |
# ----------------------------
# * 				arr[currentIndex + 1] = swapTemp;
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ADD               (ILocal 40)       (ICONS 1)         (ITemp 19)        
li	 $t3, 1
add	 $t3, $s0, $t3
# * MULT              (ITemp 19)        (ICONS 4)         (ITemp 19)        
li	 $t5, 4
mul	 $t3, $t3, $t5
# * ADD               (ICONS 0)         (ITemp 19)        (ITemp 21)        
li	 $t5, 0
add	 $t3, $t5, $t3
# * OFFSET            (ITemp 21)                                            
add	 $t3, $t3, $sp
# * ASSIGN            (ILocal 48)                         (IINDR 21)        
lw	 $s2, 48($sp)

sw	 $t5, ($t3)
# ----------------------------
# | Original source          |
# ----------------------------
# * 			if (arr[currentIndex] > arr[currentIndex + 1]) {
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * BR                                                    (LABEL if7)       
b	 if7
# ----------------------------
# | Original source          |
# ----------------------------
# * 	}
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * LABEL             (LABEL if6)                                           
if6:
# * LABEL             (LABEL if7)                                           
if7:
# ----------------------------
# | Original source          |
# ----------------------------
# * 		for (currentIndex = 0; currentIndex < upperBound; currentIndex++) {
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ADD               (ILocal 40)       (ICONS 1)         (ILocal 40)       
lw	 $s0, 40($sp)
li	 $t0, 1
add	 $s0, $s0, $t0
sw	 $s0, 40($sp)
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
# * 	for (upperBound = 10; upperBound > 0; upperBound--) {
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * SUB               (ILocal 52)       (ICONS 1)         (ILocal 52)       
lw	 $s0, 52($sp)
li	 $t0, 1
sub	 $s0, $s0, $t0
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
# * }
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * RETURN            (ICONS 56)        (ICONS 60)                          
lw	 $ra, 56($sp)
add	 $sp, $sp, 60
jr	 $ra
