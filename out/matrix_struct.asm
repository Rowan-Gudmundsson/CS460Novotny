	.data
fp0:	.float 1.000000
fp1:	.float 0.000000
fp2:	.float 0.000000
fp3:	.float 0.000000
fp4:	.float 1.000000
fp5:	.float 0.000000
fp6:	.float 0.000000
fp7:	.float 0.000000
fp8:	.float 1.000000
fp9:	.float 1.000000
fp10:	.float 2.000000
fp11:	.float 3.000000
fp12:	.float 2.000000
fp13:	.float 3.000000
fp14:	.float 4.000000
fp15:	.float 3.000000
fp16:	.float 4.000000
fp17:	.float 5.000000
fp18:	.float 0.000000
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
# * PROCENTRY         (ICONS 136)       (ICONS 0)                           
subi	$sp, $sp, 136
sw	$ra, 132($sp)
# ----------------------------
# | Original source          |
# ----------------------------
# * 	mat1.rows           = 3;
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ASSIGN            (ICONS 3)                           (ILocal 40)       
li	 $t0, 3

sw	 $t0, 40($sp)
# ----------------------------
# | Original source          |
# ----------------------------
# * 	mat1.columns        = 3;
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ASSIGN            (ICONS 3)                           (ILocal 0)        
li	 $t0, 3

sw	 $t0, 0($sp)
# ----------------------------
# | Original source          |
# ----------------------------
# * 	mat1.elements[0][0] = 1.0f;
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * MULT              (ICONS 0)         (ICONS 12)        (ITemp 0)         
li	 $t0, 0
li	 $t1, 12
mul	 $t0, $t0, $t1
# * MULT              (ICONS 0)         (ICONS 4)         (ITemp 1)         
li	 $t1, 0
li	 $t2, 4
mul	 $t1, $t1, $t2
# * ADD               (ITemp 0)         (ITemp 1)         (ITemp 2)         
add	 $t0, $t0, $t1
# * ADD               (ICONS 4)         (ITemp 2)         (ITemp 3)         
li	 $t1, 4
add	 $t0, $t1, $t0
# * OFFSET            (ITemp 3)                                             
add	 $t0, $t0, $sp
# * ASSIGN            (FCONS fp0)                         (ITemp 4)         
l.s	 $f0, fp0
mfc1	 $t1, $f0
# * ASSIGN            (ITemp 4)                           (IINDR 3)         

sw	 $t1, ($t0)
# ----------------------------
# | Original source          |
# ----------------------------
# * 	mat1.elements[0][1] = 0.0f;
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * MULT              (ICONS 0)         (ICONS 12)        (ITemp 5)         
li	 $t0, 0
li	 $t1, 12
mul	 $t0, $t0, $t1
# * MULT              (ICONS 1)         (ICONS 4)         (ITemp 6)         
li	 $t1, 1
li	 $t2, 4
mul	 $t1, $t1, $t2
# * ADD               (ITemp 5)         (ITemp 6)         (ITemp 7)         
add	 $t0, $t0, $t1
# * ADD               (ICONS 4)         (ITemp 7)         (ITemp 8)         
li	 $t1, 4
add	 $t0, $t1, $t0
# * OFFSET            (ITemp 8)                                             
add	 $t0, $t0, $sp
# * ASSIGN            (FCONS fp1)                         (ITemp 9)         
l.s	 $f0, fp1
mfc1	 $t1, $f0
# * ASSIGN            (ITemp 9)                           (IINDR 8)         

sw	 $t1, ($t0)
# ----------------------------
# | Original source          |
# ----------------------------
# * 	mat1.elements[0][2] = 0.0f;
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * MULT              (ICONS 0)         (ICONS 12)        (ITemp 10)        
li	 $t0, 0
li	 $t1, 12
mul	 $t0, $t0, $t1
# * MULT              (ICONS 2)         (ICONS 4)         (ITemp 11)        
li	 $t1, 2
li	 $t2, 4
mul	 $t1, $t1, $t2
# * ADD               (ITemp 10)        (ITemp 11)        (ITemp 12)        
add	 $t0, $t0, $t1
# * ADD               (ICONS 4)         (ITemp 12)        (ITemp 13)        
li	 $t1, 4
add	 $t0, $t1, $t0
# * OFFSET            (ITemp 13)                                            
add	 $t0, $t0, $sp
# * ASSIGN            (FCONS fp2)                         (ITemp 14)        
l.s	 $f0, fp2
mfc1	 $t1, $f0
# * ASSIGN            (ITemp 14)                          (IINDR 13)        

sw	 $t1, ($t0)
# ----------------------------
# | Original source          |
# ----------------------------
# * 	mat1.elements[1][0] = 0.0f;
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * MULT              (ICONS 1)         (ICONS 12)        (ITemp 15)        
li	 $t0, 1
li	 $t1, 12
mul	 $t0, $t0, $t1
# * MULT              (ICONS 0)         (ICONS 4)         (ITemp 16)        
li	 $t1, 0
li	 $t2, 4
mul	 $t1, $t1, $t2
# * ADD               (ITemp 15)        (ITemp 16)        (ITemp 17)        
add	 $t0, $t0, $t1
# * ADD               (ICONS 4)         (ITemp 17)        (ITemp 18)        
li	 $t1, 4
add	 $t0, $t1, $t0
# * OFFSET            (ITemp 18)                                            
add	 $t0, $t0, $sp
# * ASSIGN            (FCONS fp3)                         (ITemp 19)        
l.s	 $f0, fp3
mfc1	 $t1, $f0
# * ASSIGN            (ITemp 19)                          (IINDR 18)        

sw	 $t1, ($t0)
# ----------------------------
# | Original source          |
# ----------------------------
# * 	mat1.elements[1][1] = 1.0f;
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * MULT              (ICONS 1)         (ICONS 12)        (ITemp 20)        
li	 $t0, 1
li	 $t1, 12
mul	 $t0, $t0, $t1
# * MULT              (ICONS 1)         (ICONS 4)         (ITemp 21)        
li	 $t1, 1
li	 $t2, 4
mul	 $t1, $t1, $t2
# * ADD               (ITemp 20)        (ITemp 21)        (ITemp 22)        
add	 $t0, $t0, $t1
# * ADD               (ICONS 4)         (ITemp 22)        (ITemp 23)        
li	 $t1, 4
add	 $t0, $t1, $t0
# * OFFSET            (ITemp 23)                                            
add	 $t0, $t0, $sp
# * ASSIGN            (FCONS fp4)                         (ITemp 24)        
l.s	 $f0, fp4
mfc1	 $t1, $f0
# * ASSIGN            (ITemp 24)                          (IINDR 23)        

sw	 $t1, ($t0)
# ----------------------------
# | Original source          |
# ----------------------------
# * 	mat1.elements[1][2] = 0.0f;
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * MULT              (ICONS 1)         (ICONS 12)        (ITemp 25)        
li	 $t0, 1
li	 $t1, 12
mul	 $t0, $t0, $t1
# * MULT              (ICONS 2)         (ICONS 4)         (ITemp 26)        
li	 $t1, 2
li	 $t2, 4
mul	 $t1, $t1, $t2
# * ADD               (ITemp 25)        (ITemp 26)        (ITemp 27)        
add	 $t0, $t0, $t1
# * ADD               (ICONS 4)         (ITemp 27)        (ITemp 28)        
li	 $t1, 4
add	 $t0, $t1, $t0
# * OFFSET            (ITemp 28)                                            
add	 $t0, $t0, $sp
# * ASSIGN            (FCONS fp5)                         (ITemp 29)        
l.s	 $f0, fp5
mfc1	 $t1, $f0
# * ASSIGN            (ITemp 29)                          (IINDR 28)        

sw	 $t1, ($t0)
# ----------------------------
# | Original source          |
# ----------------------------
# * 	mat1.elements[2][0] = 0.0f;
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * MULT              (ICONS 2)         (ICONS 12)        (ITemp 30)        
li	 $t0, 2
li	 $t1, 12
mul	 $t0, $t0, $t1
# * MULT              (ICONS 0)         (ICONS 4)         (ITemp 31)        
li	 $t1, 0
li	 $t2, 4
mul	 $t1, $t1, $t2
# * ADD               (ITemp 30)        (ITemp 31)        (ITemp 32)        
add	 $t0, $t0, $t1
# * ADD               (ICONS 4)         (ITemp 32)        (ITemp 33)        
li	 $t1, 4
add	 $t0, $t1, $t0
# * OFFSET            (ITemp 33)                                            
add	 $t0, $t0, $sp
# * ASSIGN            (FCONS fp6)                         (ITemp 34)        
l.s	 $f0, fp6
mfc1	 $t1, $f0
# * ASSIGN            (ITemp 34)                          (IINDR 33)        

sw	 $t1, ($t0)
# ----------------------------
# | Original source          |
# ----------------------------
# * 	mat1.elements[2][1] = 0.0f;
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * MULT              (ICONS 2)         (ICONS 12)        (ITemp 35)        
li	 $t0, 2
li	 $t1, 12
mul	 $t0, $t0, $t1
# * MULT              (ICONS 1)         (ICONS 4)         (ITemp 36)        
li	 $t1, 1
li	 $t2, 4
mul	 $t1, $t1, $t2
# * ADD               (ITemp 35)        (ITemp 36)        (ITemp 37)        
add	 $t0, $t0, $t1
# * ADD               (ICONS 4)         (ITemp 37)        (ITemp 38)        
li	 $t1, 4
add	 $t0, $t1, $t0
# * OFFSET            (ITemp 38)                                            
add	 $t0, $t0, $sp
# * ASSIGN            (FCONS fp7)                         (ITemp 39)        
l.s	 $f0, fp7
mfc1	 $t1, $f0
# * ASSIGN            (ITemp 39)                          (IINDR 38)        

sw	 $t1, ($t0)
# ----------------------------
# | Original source          |
# ----------------------------
# * 	mat1.elements[2][2] = 1.0f;
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * MULT              (ICONS 2)         (ICONS 12)        (ITemp 40)        
li	 $t0, 2
li	 $t1, 12
mul	 $t0, $t0, $t1
# * MULT              (ICONS 2)         (ICONS 4)         (ITemp 41)        
li	 $t1, 2
li	 $t2, 4
mul	 $t1, $t1, $t2
# * ADD               (ITemp 40)        (ITemp 41)        (ITemp 42)        
add	 $t0, $t0, $t1
# * ADD               (ICONS 4)         (ITemp 42)        (ITemp 43)        
li	 $t1, 4
add	 $t0, $t1, $t0
# * OFFSET            (ITemp 43)                                            
add	 $t0, $t0, $sp
# * ASSIGN            (FCONS fp8)                         (ITemp 44)        
l.s	 $f0, fp8
mfc1	 $t1, $f0
# * ASSIGN            (ITemp 44)                          (IINDR 43)        

sw	 $t1, ($t0)
# ----------------------------
# | Original source          |
# ----------------------------
# * 	mat2.rows           = 3;
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ASSIGN            (ICONS 3)                           (ILocal 84)       
li	 $t0, 3

sw	 $t0, 84($sp)
# ----------------------------
# | Original source          |
# ----------------------------
# * 	mat2.columns        = 3;
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ASSIGN            (ICONS 3)                           (ILocal 44)       
li	 $t0, 3

sw	 $t0, 44($sp)
# ----------------------------
# | Original source          |
# ----------------------------
# * 	mat2.elements[0][0] = 1.0f;
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * MULT              (ICONS 0)         (ICONS 12)        (ITemp 45)        
li	 $t0, 0
li	 $t1, 12
mul	 $t0, $t0, $t1
# * MULT              (ICONS 0)         (ICONS 4)         (ITemp 46)        
li	 $t1, 0
li	 $t2, 4
mul	 $t1, $t1, $t2
# * ADD               (ITemp 45)        (ITemp 46)        (ITemp 47)        
add	 $t0, $t0, $t1
# * ADD               (ICONS 48)        (ITemp 47)        (ITemp 48)        
li	 $t1, 48
add	 $t0, $t1, $t0
# * OFFSET            (ITemp 48)                                            
add	 $t0, $t0, $sp
# * ASSIGN            (FCONS fp9)                         (ITemp 49)        
l.s	 $f0, fp9
mfc1	 $t1, $f0
# * ASSIGN            (ITemp 49)                          (IINDR 48)        

sw	 $t1, ($t0)
# ----------------------------
# | Original source          |
# ----------------------------
# * 	mat2.elements[0][1] = 2.0f;
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * MULT              (ICONS 0)         (ICONS 12)        (ITemp 50)        
li	 $t0, 0
li	 $t1, 12
mul	 $t0, $t0, $t1
# * MULT              (ICONS 1)         (ICONS 4)         (ITemp 51)        
li	 $t1, 1
li	 $t2, 4
mul	 $t1, $t1, $t2
# * ADD               (ITemp 50)        (ITemp 51)        (ITemp 52)        
add	 $t0, $t0, $t1
# * ADD               (ICONS 48)        (ITemp 52)        (ITemp 53)        
li	 $t1, 48
add	 $t0, $t1, $t0
# * OFFSET            (ITemp 53)                                            
add	 $t0, $t0, $sp
# * ASSIGN            (FCONS fp10)                        (ITemp 54)        
l.s	 $f0, fp10
mfc1	 $t1, $f0
# * ASSIGN            (ITemp 54)                          (IINDR 53)        

sw	 $t1, ($t0)
# ----------------------------
# | Original source          |
# ----------------------------
# * 	mat2.elements[0][2] = 3.0f;
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * MULT              (ICONS 0)         (ICONS 12)        (ITemp 55)        
li	 $t0, 0
li	 $t1, 12
mul	 $t0, $t0, $t1
# * MULT              (ICONS 2)         (ICONS 4)         (ITemp 56)        
li	 $t1, 2
li	 $t2, 4
mul	 $t1, $t1, $t2
# * ADD               (ITemp 55)        (ITemp 56)        (ITemp 57)        
add	 $t0, $t0, $t1
# * ADD               (ICONS 48)        (ITemp 57)        (ITemp 58)        
li	 $t1, 48
add	 $t0, $t1, $t0
# * OFFSET            (ITemp 58)                                            
add	 $t0, $t0, $sp
# * ASSIGN            (FCONS fp11)                        (ITemp 59)        
l.s	 $f0, fp11
mfc1	 $t1, $f0
# * ASSIGN            (ITemp 59)                          (IINDR 58)        

sw	 $t1, ($t0)
# ----------------------------
# | Original source          |
# ----------------------------
# * 	mat2.elements[1][0] = 2.0f;
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * MULT              (ICONS 1)         (ICONS 12)        (ITemp 60)        
li	 $t0, 1
li	 $t1, 12
mul	 $t0, $t0, $t1
# * MULT              (ICONS 0)         (ICONS 4)         (ITemp 61)        
li	 $t1, 0
li	 $t2, 4
mul	 $t1, $t1, $t2
# * ADD               (ITemp 60)        (ITemp 61)        (ITemp 62)        
add	 $t0, $t0, $t1
# * ADD               (ICONS 48)        (ITemp 62)        (ITemp 63)        
li	 $t1, 48
add	 $t0, $t1, $t0
# * OFFSET            (ITemp 63)                                            
add	 $t0, $t0, $sp
# * ASSIGN            (FCONS fp12)                        (ITemp 64)        
l.s	 $f0, fp12
mfc1	 $t1, $f0
# * ASSIGN            (ITemp 64)                          (IINDR 63)        

sw	 $t1, ($t0)
# ----------------------------
# | Original source          |
# ----------------------------
# * 	mat2.elements[1][1] = 3.0f;
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * MULT              (ICONS 1)         (ICONS 12)        (ITemp 65)        
li	 $t0, 1
li	 $t1, 12
mul	 $t0, $t0, $t1
# * MULT              (ICONS 1)         (ICONS 4)         (ITemp 66)        
li	 $t1, 1
li	 $t2, 4
mul	 $t1, $t1, $t2
# * ADD               (ITemp 65)        (ITemp 66)        (ITemp 67)        
add	 $t0, $t0, $t1
# * ADD               (ICONS 48)        (ITemp 67)        (ITemp 68)        
li	 $t1, 48
add	 $t0, $t1, $t0
# * OFFSET            (ITemp 68)                                            
add	 $t0, $t0, $sp
# * ASSIGN            (FCONS fp13)                        (ITemp 69)        
l.s	 $f0, fp13
mfc1	 $t1, $f0
# * ASSIGN            (ITemp 69)                          (IINDR 68)        

sw	 $t1, ($t0)
# ----------------------------
# | Original source          |
# ----------------------------
# * 	mat2.elements[1][2] = 4.0f;
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * MULT              (ICONS 1)         (ICONS 12)        (ITemp 70)        
li	 $t0, 1
li	 $t1, 12
mul	 $t0, $t0, $t1
# * MULT              (ICONS 2)         (ICONS 4)         (ITemp 71)        
li	 $t1, 2
li	 $t2, 4
mul	 $t1, $t1, $t2
# * ADD               (ITemp 70)        (ITemp 71)        (ITemp 72)        
add	 $t0, $t0, $t1
# * ADD               (ICONS 48)        (ITemp 72)        (ITemp 73)        
li	 $t1, 48
add	 $t0, $t1, $t0
# * OFFSET            (ITemp 73)                                            
add	 $t0, $t0, $sp
# * ASSIGN            (FCONS fp14)                        (ITemp 74)        
l.s	 $f0, fp14
mfc1	 $t1, $f0
# * ASSIGN            (ITemp 74)                          (IINDR 73)        

sw	 $t1, ($t0)
# ----------------------------
# | Original source          |
# ----------------------------
# * 	mat2.elements[2][0] = 3.0f;
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * MULT              (ICONS 2)         (ICONS 12)        (ITemp 75)        
li	 $t0, 2
li	 $t1, 12
mul	 $t0, $t0, $t1
# * MULT              (ICONS 0)         (ICONS 4)         (ITemp 76)        
li	 $t1, 0
li	 $t2, 4
mul	 $t1, $t1, $t2
# * ADD               (ITemp 75)        (ITemp 76)        (ITemp 77)        
add	 $t0, $t0, $t1
# * ADD               (ICONS 48)        (ITemp 77)        (ITemp 78)        
li	 $t1, 48
add	 $t0, $t1, $t0
# * OFFSET            (ITemp 78)                                            
add	 $t0, $t0, $sp
# * ASSIGN            (FCONS fp15)                        (ITemp 79)        
l.s	 $f0, fp15
mfc1	 $t1, $f0
# * ASSIGN            (ITemp 79)                          (IINDR 78)        

sw	 $t1, ($t0)
# ----------------------------
# | Original source          |
# ----------------------------
# * 	mat2.elements[2][1] = 4.0f;
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * MULT              (ICONS 2)         (ICONS 12)        (ITemp 80)        
li	 $t0, 2
li	 $t1, 12
mul	 $t0, $t0, $t1
# * MULT              (ICONS 1)         (ICONS 4)         (ITemp 81)        
li	 $t1, 1
li	 $t2, 4
mul	 $t1, $t1, $t2
# * ADD               (ITemp 80)        (ITemp 81)        (ITemp 82)        
add	 $t0, $t0, $t1
# * ADD               (ICONS 48)        (ITemp 82)        (ITemp 83)        
li	 $t1, 48
add	 $t0, $t1, $t0
# * OFFSET            (ITemp 83)                                            
add	 $t0, $t0, $sp
# * ASSIGN            (FCONS fp16)                        (ITemp 84)        
l.s	 $f0, fp16
mfc1	 $t1, $f0
# * ASSIGN            (ITemp 84)                          (IINDR 83)        

sw	 $t1, ($t0)
# ----------------------------
# | Original source          |
# ----------------------------
# * 	mat2.elements[2][2] = 5.0f;
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * MULT              (ICONS 2)         (ICONS 12)        (ITemp 85)        
li	 $t0, 2
li	 $t1, 12
mul	 $t0, $t0, $t1
# * MULT              (ICONS 2)         (ICONS 4)         (ITemp 86)        
li	 $t1, 2
li	 $t2, 4
mul	 $t1, $t1, $t2
# * ADD               (ITemp 85)        (ITemp 86)        (ITemp 87)        
add	 $t0, $t0, $t1
# * ADD               (ICONS 48)        (ITemp 87)        (ITemp 88)        
li	 $t1, 48
add	 $t0, $t1, $t0
# * OFFSET            (ITemp 88)                                            
add	 $t0, $t0, $sp
# * ASSIGN            (FCONS fp17)                        (ITemp 89)        
l.s	 $f0, fp17
mfc1	 $t1, $f0
# * ASSIGN            (ITemp 89)                          (IINDR 88)        

sw	 $t1, ($t0)
# ----------------------------
# | Original source          |
# ----------------------------
# * 	mat3 = calc_product(mat1, mat2);
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ASSIGN            (ILocal 0)                          (ILocal -136)     
lw	 $s0, 0($sp)

sw	 $s0, -136($sp)
# * ASSIGN            (ILocal 4)                          (ILocal -132)     
lw	 $s0, 4($sp)

sw	 $s0, -132($sp)
# * ASSIGN            (ILocal 40)                         (ILocal -96)      
lw	 $s0, 40($sp)

sw	 $s0, -96($sp)
# * ASSIGN            (ILocal 44)                         (ILocal -92)      
lw	 $s0, 44($sp)

sw	 $s0, -92($sp)
# * ASSIGN            (ILocal 48)                         (ILocal -88)      
lw	 $s0, 48($sp)

sw	 $s0, -88($sp)
# * ASSIGN            (ILocal 84)                         (ILocal -52)      
lw	 $s0, 84($sp)

sw	 $s0, -52($sp)
# * CALL                                                  (LABEL calc_product1)
jal	 calc_product1
# * ASSIGN            (ILocal -44)                        (ILocal 88)       
lw	 $s0, -44($sp)

sw	 $s0, 88($sp)
# ----------------------------
# | Original source          |
# ----------------------------
# * }
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * RETURN            (ICONS 132)       (ICONS 136)                         
lw	 $ra, 132($sp)
add	 $sp, $sp, 136
jr	 $ra
# ----------------------------
# | Original source          |
# ----------------------------
# * struct Matrix calc_product(struct Matrix mat1, struct Matrix mat2) {
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * LABEL             (LABEL calc_product1)                                    
calc_product1:
# * PROCENTRY         (ICONS 136)       (ICONS 44)                          
subi	$sp, $sp, 136
sw	$ra, 88($sp)
# ----------------------------
# | Original source          |
# ----------------------------
# * 	int i = 0, j = 0, k = 0;
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ASSIGN            (ICONS 0)                           (ILocal 88)       
li	 $t0, 0

sw	 $t0, 88($sp)
# * ASSIGN            (ICONS 0)                           (ILocal 92)       
li	 $t0, 0

sw	 $t0, 92($sp)
# * ASSIGN            (ICONS 0)                           (ILocal 96)       
li	 $t0, 0

sw	 $t0, 96($sp)
# ----------------------------
# | Original source          |
# ----------------------------
# * 	mat3.rows    = mat1.rows;
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ASSIGN            (ILocal 40)                         (ILocal 140)      
lw	 $s0, 40($sp)

sw	 $s0, 140($sp)
# ----------------------------
# | Original source          |
# ----------------------------
# * 	mat3.columns = mat2.columns;
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ASSIGN            (ILocal 44)                         (ILocal 100)      
lw	 $s0, 44($sp)

sw	 $s0, 100($sp)
# ----------------------------
# | Original source          |
# ----------------------------
# * 	for (i = 0; i < mat3.rows; i++) {
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ASSIGN            (ICONS 0)                           (ILocal 88)       
li	 $t0, 0

sw	 $t0, 88($sp)
# * LABEL             (LABEL LL00000)                                       
LL00000:
# * LT                (ILocal 88)       (ILocal 140)      (ITemp 90)        
lw	 $s0, 88($sp)
lw	 $s1, 140($sp)
slt	 $t0, $s0, $s1
# * BREQ              (ITemp 90)        (ICONS 0)         (LABEL LL00001)   
li	 $t1, 0
beq	 $t0, $t1, LL00001
# ----------------------------
# | Original source          |
# ----------------------------
# * 		for (j = 0; j < mat3.columns; j++) { mat3.elements[i][j] = 0.0f; }
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ASSIGN            (ICONS 0)                           (ILocal 92)       
li	 $t0, 0

sw	 $t0, 92($sp)
# * LABEL             (LABEL LL00002)                                       
LL00002:
# * LT                (ILocal 92)       (ILocal 100)      (ITemp 91)        
lw	 $s0, 92($sp)
lw	 $s1, 100($sp)
slt	 $t0, $s0, $s1
# * BREQ              (ITemp 91)        (ICONS 0)         (LABEL LL00003)   
li	 $t1, 0
beq	 $t0, $t1, LL00003
# * MULT              (ILocal 88)       (ICONS 12)        (ITemp 92)        
lw	 $s2, 88($sp)
li	 $t0, 12
mul	 $t0, $s2, $t0
# * MULT              (ILocal 92)       (ICONS 4)         (ITemp 93)        
li	 $t1, 4
mul	 $t1, $s0, $t1
# * ADD               (ITemp 92)        (ITemp 93)        (ITemp 94)        
add	 $t0, $t0, $t1
# * ADD               (ICONS 104)       (ITemp 94)        (ITemp 95)        
li	 $t1, 104
add	 $t0, $t1, $t0
# * OFFSET            (ITemp 95)                                            
add	 $t0, $t0, $sp
# * ASSIGN            (FCONS fp18)                        (ITemp 96)        
l.s	 $f0, fp18
mfc1	 $t1, $f0
# * ASSIGN            (ITemp 96)                          (IINDR 95)        

sw	 $t1, ($t0)
# * ADD               (ILocal 92)       (ICONS 1)         (ILocal 92)       
li	 $t0, 1
add	 $s0, $s0, $t0
sw	 $s0, 92($sp)
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
# * 	for (i = 0; i < mat3.rows; i++) {
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ADD               (ILocal 88)       (ICONS 1)         (ILocal 88)       
lw	 $s0, 88($sp)
li	 $t0, 1
add	 $s0, $s0, $t0
sw	 $s0, 88($sp)
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
# * 	if (mat1.columns != mat2.rows) return mat3;
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * NE                (ILocal 0)        (ILocal 84)       (ITemp 97)        
lw	 $s0, 0($sp)
lw	 $s1, 84($sp)
sne	 $t0, $s0, $s1
# * BREQ              (ITemp 97)        (ICONS 0)         (LABEL if4)       
li	 $t1, 0
beq	 $t0, $t1, if4
# * ASSIGN            (ILocal 100)                        (ILocal 92)       
lw	 $s2, 100($sp)

sw	 $s2, 92($sp)
# * ASSIGN            (ILocal 104)                        (ILocal 96)       
lw	 $s2, 104($sp)

sw	 $s2, 96($sp)
# * ASSIGN            (ILocal 108)                        (ILocal 100)      
lw	 $s2, 108($sp)

sw	 $s2, 100($sp)
# * ASSIGN            (ILocal 112)                        (ILocal 104)      
lw	 $s2, 112($sp)

sw	 $s2, 104($sp)
# * ASSIGN            (ILocal 116)                        (ILocal 108)      
lw	 $s2, 116($sp)

sw	 $s2, 108($sp)
# * ASSIGN            (ILocal 120)                        (ILocal 112)      
lw	 $s2, 120($sp)

sw	 $s2, 112($sp)
# * ASSIGN            (ILocal 124)                        (ILocal 116)      
lw	 $s2, 124($sp)

sw	 $s2, 116($sp)
# * ASSIGN            (ILocal 140)                        (ILocal 132)      
lw	 $s2, 140($sp)

sw	 $s2, 132($sp)
# * RETURN            (ICONS 88)        (ICONS 136)                         
lw	 $ra, 88($sp)
add	 $sp, $sp, 136
jr	 $ra
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
# * 	for (i = 0; i < mat1.rows; i++) {
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ASSIGN            (ICONS 0)                           (ILocal 88)       
li	 $t0, 0

sw	 $t0, 88($sp)
# * LABEL             (LABEL LL00006)                                       
LL00006:
# * LT                (ILocal 88)       (ILocal 40)       (ITemp 98)        
lw	 $s0, 88($sp)
lw	 $s1, 40($sp)
slt	 $t0, $s0, $s1
# * BREQ              (ITemp 98)        (ICONS 0)         (LABEL LL00007)   
li	 $t1, 0
beq	 $t0, $t1, LL00007
# ----------------------------
# | Original source          |
# ----------------------------
# * 		for (j = 0; j < mat2.columns; j++) {
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ASSIGN            (ICONS 0)                           (ILocal 92)       
li	 $t0, 0

sw	 $t0, 92($sp)
# * LABEL             (LABEL LL00008)                                       
LL00008:
# * LT                (ILocal 92)       (ILocal 44)       (ITemp 99)        
lw	 $s0, 92($sp)
lw	 $s1, 44($sp)
slt	 $t0, $s0, $s1
# * BREQ              (ITemp 99)        (ICONS 0)         (LABEL LL00009)   
li	 $t1, 0
beq	 $t0, $t1, LL00009
# ----------------------------
# | Original source          |
# ----------------------------
# * 			for (k = 0; k < mat2.rows; k++) {
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ASSIGN            (ICONS 0)                           (ILocal 96)       
li	 $t0, 0

sw	 $t0, 96($sp)
# * LABEL             (LABEL LL00010)                                       
LL00010:
# * LT                (ILocal 96)       (ILocal 84)       (ITemp 100)       
lw	 $s0, 96($sp)
lw	 $s1, 84($sp)
slt	 $t0, $s0, $s1
# * BREQ              (ITemp 100)       (ICONS 0)         (LABEL LL00011)   
li	 $t1, 0
beq	 $t0, $t1, LL00011
# ----------------------------
# | Original source          |
# ----------------------------
# * 				mat3.elements[i][j] += mat1.elements[i][k] * mat2.elements[k][j];
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * MULT              (ILocal 88)       (ICONS 12)        (ITemp 101)       
lw	 $s2, 88($sp)
li	 $t0, 12
mul	 $t0, $s2, $t0
# * MULT              (ILocal 92)       (ICONS 4)         (ITemp 102)       
lw	 $s3, 92($sp)
li	 $t1, 4
mul	 $t1, $s3, $t1
# * ADD               (ITemp 101)       (ITemp 102)       (ITemp 103)       
add	 $t0, $t0, $t1
# * ADD               (ICONS 104)       (ITemp 103)       (ITemp 104)       
li	 $t1, 104
add	 $t0, $t1, $t0
# * OFFSET            (ITemp 104)                                           
add	 $t0, $t0, $sp
# * MULT              (ILocal 88)       (ICONS 12)        (ITemp 105)       
li	 $t1, 12
mul	 $t1, $s2, $t1
# * MULT              (ILocal 96)       (ICONS 4)         (ITemp 106)       
li	 $t2, 4
mul	 $t2, $s0, $t2
# * ADD               (ITemp 105)       (ITemp 106)       (ITemp 107)       
add	 $t1, $t1, $t2
# * ADD               (ICONS 4)         (ITemp 107)       (ITemp 108)       
li	 $t2, 4
add	 $t1, $t2, $t1
# * OFFSET            (ITemp 108)                                           
add	 $t1, $t1, $sp
# * MULT              (ILocal 96)       (ICONS 12)        (ITemp 109)       
li	 $t2, 12
mul	 $t2, $s0, $t2
# * MULT              (ILocal 92)       (ICONS 4)         (ITemp 110)       
li	 $t3, 4
mul	 $t3, $s3, $t3
# * ADD               (ITemp 109)       (ITemp 110)       (ITemp 111)       
add	 $t2, $t2, $t3
# * ADD               (ICONS 48)        (ITemp 111)       (ITemp 112)       
li	 $t3, 48
add	 $t2, $t3, $t2
# * OFFSET            (ITemp 112)                                           
add	 $t2, $t2, $sp
# * MULT              (IINDR 108)       (IINDR 112)       (ITemp 113)       
lw	 $t3, ($t1)
lw	 $t4, ($t2)
mul	 $t3, $t3, $t4
# * ADD               (IINDR 104)       (ITemp 113)       (IINDR 104)       
lw	 $t4, ($t0)
add	 $t3, $t4, $t3
sw	 $t3, ($t0)
# ----------------------------
# | Original source          |
# ----------------------------
# * 			for (k = 0; k < mat2.rows; k++) {
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ADD               (ILocal 96)       (ICONS 1)         (ILocal 96)       
li	 $t0, 1
add	 $s0, $s0, $t0
sw	 $s0, 96($sp)
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
# * 		for (j = 0; j < mat2.columns; j++) {
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ADD               (ILocal 92)       (ICONS 1)         (ILocal 92)       
lw	 $s0, 92($sp)
li	 $t0, 1
add	 $s0, $s0, $t0
sw	 $s0, 92($sp)
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
# * 	for (i = 0; i < mat1.rows; i++) {
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ADD               (ILocal 88)       (ICONS 1)         (ILocal 88)       
lw	 $s0, 88($sp)
li	 $t0, 1
add	 $s0, $s0, $t0
sw	 $s0, 88($sp)
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
# * 	return mat3;
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ASSIGN            (ILocal 100)                        (ILocal 92)       
lw	 $s0, 100($sp)

sw	 $s0, 92($sp)
# * ASSIGN            (ILocal 104)                        (ILocal 96)       
lw	 $s0, 104($sp)

sw	 $s0, 96($sp)
# * ASSIGN            (ILocal 108)                        (ILocal 100)      
lw	 $s0, 108($sp)

sw	 $s0, 100($sp)
# * ASSIGN            (ILocal 112)                        (ILocal 104)      
lw	 $s0, 112($sp)

sw	 $s0, 104($sp)
# * ASSIGN            (ILocal 116)                        (ILocal 108)      
lw	 $s0, 116($sp)

sw	 $s0, 108($sp)
# * ASSIGN            (ILocal 120)                        (ILocal 112)      
lw	 $s0, 120($sp)

sw	 $s0, 112($sp)
# * ASSIGN            (ILocal 124)                        (ILocal 116)      
lw	 $s0, 124($sp)

sw	 $s0, 116($sp)
# * ASSIGN            (ILocal 140)                        (ILocal 132)      
lw	 $s0, 140($sp)

sw	 $s0, 132($sp)
# * RETURN            (ICONS 88)        (ICONS 136)                         
lw	 $ra, 88($sp)
add	 $sp, $sp, 136
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
# * RETURN            (ICONS 88)        (ICONS 136)                         
lw	 $ra, 88($sp)
add	 $sp, $sp, 136
jr	 $ra
