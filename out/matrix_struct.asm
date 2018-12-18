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
# * ASSIGN            (ILocal -408)                       (ILocal 8)        
lw	 $s0, -408($sp)

sw	 $s0, 8($sp)
# * ASSIGN            (ILocal -404)                       (ILocal 12)       
lw	 $s0, -404($sp)

sw	 $s0, 12($sp)
# * ASSIGN            (ILocal -400)                       (ILocal 16)       
lw	 $s0, -400($sp)

sw	 $s0, 16($sp)
# * ASSIGN            (ILocal -396)                       (ILocal 20)       
lw	 $s0, -396($sp)

sw	 $s0, 20($sp)
# * ASSIGN            (ILocal -392)                       (ILocal 24)       
lw	 $s0, -392($sp)

sw	 $s0, 24($sp)
# * ASSIGN            (ILocal -388)                       (ILocal 28)       
lw	 $s0, -388($sp)

sw	 $s0, 28($sp)
# * ASSIGN            (ILocal -384)                       (ILocal 32)       
lw	 $s0, -384($sp)

sw	 $s0, 32($sp)
# * ASSIGN            (ILocal -380)                       (ILocal 36)       
lw	 $s0, -380($sp)

sw	 $s0, 36($sp)
# * ASSIGN            (ILocal -376)                       (ILocal 40)       
lw	 $s0, -376($sp)

sw	 $s0, 40($sp)
# * ASSIGN            (ILocal -372)                       (ILocal 44)       
lw	 $s0, -372($sp)

sw	 $s0, 44($sp)
# * ASSIGN            (ILocal -368)                       (ILocal 48)       
lw	 $s0, -368($sp)

sw	 $s0, 48($sp)
# * ASSIGN            (ILocal -364)                       (ILocal 52)       
lw	 $s0, -364($sp)

sw	 $s0, 52($sp)
# * ASSIGN            (ILocal -360)                       (ILocal 56)       
lw	 $s0, -360($sp)

sw	 $s0, 56($sp)
# * ASSIGN            (ILocal -356)                       (ILocal 60)       
lw	 $s0, -356($sp)

sw	 $s0, 60($sp)
# * ASSIGN            (ILocal -352)                       (ILocal 64)       
lw	 $s0, -352($sp)

sw	 $s0, 64($sp)
# * ASSIGN            (ILocal -348)                       (ILocal 68)       
lw	 $s0, -348($sp)

sw	 $s0, 68($sp)
# * ASSIGN            (ILocal -344)                       (ILocal 72)       
lw	 $s0, -344($sp)

sw	 $s0, 72($sp)
# * ASSIGN            (ILocal -340)                       (ILocal 76)       
lw	 $s0, -340($sp)

sw	 $s0, 76($sp)
# * ASSIGN            (ILocal -336)                       (ILocal 80)       
lw	 $s0, -336($sp)

sw	 $s0, 80($sp)
# * ASSIGN            (ILocal -332)                       (ILocal 84)       
lw	 $s0, -332($sp)

sw	 $s0, 84($sp)
# * ASSIGN            (ILocal -328)                       (ILocal 88)       
lw	 $s0, -328($sp)

sw	 $s0, 88($sp)
# * ASSIGN            (ILocal -324)                       (ILocal 92)       
lw	 $s0, -324($sp)

sw	 $s0, 92($sp)
# * ASSIGN            (ILocal -320)                       (ILocal 96)       
lw	 $s0, -320($sp)

sw	 $s0, 96($sp)
# * ASSIGN            (ILocal -316)                       (ILocal 100)      
lw	 $s0, -316($sp)

sw	 $s0, 100($sp)
# * ASSIGN            (ILocal -312)                       (ILocal 104)      
lw	 $s0, -312($sp)

sw	 $s0, 104($sp)
# * ASSIGN            (ILocal -308)                       (ILocal 108)      
lw	 $s0, -308($sp)

sw	 $s0, 108($sp)
# * ASSIGN            (ILocal -304)                       (ILocal 112)      
lw	 $s0, -304($sp)

sw	 $s0, 112($sp)
# * ASSIGN            (ILocal -300)                       (ILocal 116)      
lw	 $s0, -300($sp)

sw	 $s0, 116($sp)
# * ASSIGN            (ILocal -296)                       (ILocal 120)      
lw	 $s0, -296($sp)

sw	 $s0, 120($sp)
# * ASSIGN            (ILocal -292)                       (ILocal 124)      
lw	 $s0, -292($sp)

sw	 $s0, 124($sp)
# * ASSIGN            (ILocal -288)                       (ILocal 128)      
lw	 $s0, -288($sp)

sw	 $s0, 128($sp)
# * ASSIGN            (ILocal -284)                       (ILocal 132)      
lw	 $s0, -284($sp)

sw	 $s0, 132($sp)
# * ASSIGN            (ILocal -280)                       (ILocal 136)      
lw	 $s0, -280($sp)

sw	 $s0, 136($sp)
# * ASSIGN            (ILocal -276)                       (ILocal 140)      
lw	 $s0, -276($sp)

sw	 $s0, 140($sp)
# * ASSIGN            (ILocal -272)                       (ILocal 144)      
lw	 $s0, -272($sp)

sw	 $s0, 144($sp)
# * ASSIGN            (ILocal -268)                       (ILocal 148)      
lw	 $s0, -268($sp)

sw	 $s0, 148($sp)
# * ASSIGN            (ILocal -264)                       (ILocal 152)      
lw	 $s0, -264($sp)

sw	 $s0, 152($sp)
# * ASSIGN            (ILocal -260)                       (ILocal 156)      
lw	 $s0, -260($sp)

sw	 $s0, 156($sp)
# * ASSIGN            (ILocal -256)                       (ILocal 160)      
lw	 $s0, -256($sp)

sw	 $s0, 160($sp)
# * ASSIGN            (ILocal -252)                       (ILocal 164)      
lw	 $s0, -252($sp)

sw	 $s0, 164($sp)
# * ASSIGN            (ILocal -248)                       (ILocal 168)      
lw	 $s0, -248($sp)

sw	 $s0, 168($sp)
# * ASSIGN            (ILocal -244)                       (ILocal 172)      
lw	 $s0, -244($sp)

sw	 $s0, 172($sp)
# * ASSIGN            (ILocal -240)                       (ILocal 176)      
lw	 $s0, -240($sp)

sw	 $s0, 176($sp)
# * ASSIGN            (ILocal -236)                       (ILocal 180)      
lw	 $s0, -236($sp)

sw	 $s0, 180($sp)
# * ASSIGN            (ILocal -232)                       (ILocal 184)      
lw	 $s0, -232($sp)

sw	 $s0, 184($sp)
# * ASSIGN            (ILocal -228)                       (ILocal 188)      
lw	 $s0, -228($sp)

sw	 $s0, 188($sp)
# * ASSIGN            (ILocal -224)                       (ILocal 192)      
lw	 $s0, -224($sp)

sw	 $s0, 192($sp)
# * ASSIGN            (ILocal -220)                       (ILocal 196)      
lw	 $s0, -220($sp)

sw	 $s0, 196($sp)
# * ASSIGN            (ILocal -216)                       (ILocal 200)      
lw	 $s0, -216($sp)

sw	 $s0, 200($sp)
# * ASSIGN            (ILocal -212)                       (ILocal 204)      
lw	 $s0, -212($sp)

sw	 $s0, 204($sp)
# * ASSIGN            (ILocal -208)                       (ILocal 208)      
lw	 $s0, -208($sp)

sw	 $s0, 208($sp)
# * ASSIGN            (ILocal -204)                       (ILocal 212)      
lw	 $s0, -204($sp)

sw	 $s0, 212($sp)
# * ASSIGN            (ILocal -200)                       (ILocal 216)      
lw	 $s0, -200($sp)

sw	 $s0, 216($sp)
# * ASSIGN            (ILocal -196)                       (ILocal 220)      
lw	 $s0, -196($sp)

sw	 $s0, 220($sp)
# * ASSIGN            (ILocal -192)                       (ILocal 224)      
lw	 $s0, -192($sp)

sw	 $s0, 224($sp)
# * ASSIGN            (ILocal -188)                       (ILocal 228)      
lw	 $s0, -188($sp)

sw	 $s0, 228($sp)
# * ASSIGN            (ILocal -184)                       (ILocal 232)      
lw	 $s0, -184($sp)

sw	 $s0, 232($sp)
# * ASSIGN            (ILocal -180)                       (ILocal 236)      
lw	 $s0, -180($sp)

sw	 $s0, 236($sp)
# * ASSIGN            (ILocal -176)                       (ILocal 240)      
lw	 $s0, -176($sp)

sw	 $s0, 240($sp)
# * ASSIGN            (ILocal -172)                       (ILocal 244)      
lw	 $s0, -172($sp)

sw	 $s0, 244($sp)
# * ASSIGN            (ILocal -168)                       (ILocal 248)      
lw	 $s0, -168($sp)

sw	 $s0, 248($sp)
# * ASSIGN            (ILocal -164)                       (ILocal 252)      
lw	 $s0, -164($sp)

sw	 $s0, 252($sp)
# * ASSIGN            (ILocal -160)                       (ILocal 256)      
lw	 $s0, -160($sp)

sw	 $s0, 256($sp)
# * ASSIGN            (ILocal -156)                       (ILocal 260)      
lw	 $s0, -156($sp)

sw	 $s0, 260($sp)
# * ASSIGN            (ILocal -152)                       (ILocal 264)      
lw	 $s0, -152($sp)

sw	 $s0, 264($sp)
# * ASSIGN            (ILocal -148)                       (ILocal 268)      
lw	 $s0, -148($sp)

sw	 $s0, 268($sp)
# * ASSIGN            (ILocal -144)                       (ILocal 272)      
lw	 $s0, -144($sp)

sw	 $s0, 272($sp)
# * ASSIGN            (ILocal -140)                       (ILocal 276)      
lw	 $s0, -140($sp)

sw	 $s0, 276($sp)
# * ASSIGN            (ILocal -136)                       (ILocal 280)      
lw	 $s0, -136($sp)

sw	 $s0, 280($sp)
# * ASSIGN            (ILocal -132)                       (ILocal 284)      
lw	 $s0, -132($sp)

sw	 $s0, 284($sp)
# * ASSIGN            (ILocal -128)                       (ILocal 288)      
lw	 $s0, -128($sp)

sw	 $s0, 288($sp)
# * ASSIGN            (ILocal -124)                       (ILocal 292)      
lw	 $s0, -124($sp)

sw	 $s0, 292($sp)
# * ASSIGN            (ILocal -120)                       (ILocal 296)      
lw	 $s0, -120($sp)

sw	 $s0, 296($sp)
# * ASSIGN            (ILocal -116)                       (ILocal 300)      
lw	 $s0, -116($sp)

sw	 $s0, 300($sp)
# * ASSIGN            (ILocal -112)                       (ILocal 304)      
lw	 $s0, -112($sp)

sw	 $s0, 304($sp)
# * ASSIGN            (ILocal -108)                       (ILocal 308)      
lw	 $s0, -108($sp)

sw	 $s0, 308($sp)
# * ASSIGN            (ILocal -104)                       (ILocal 312)      
lw	 $s0, -104($sp)

sw	 $s0, 312($sp)
# * ASSIGN            (ILocal -100)                       (ILocal 316)      
lw	 $s0, -100($sp)

sw	 $s0, 316($sp)
# * ASSIGN            (ILocal -96)                        (ILocal 320)      
lw	 $s0, -96($sp)

sw	 $s0, 320($sp)
# * ASSIGN            (ILocal -92)                        (ILocal 324)      
lw	 $s0, -92($sp)

sw	 $s0, 324($sp)
# * ASSIGN            (ILocal -88)                        (ILocal 328)      
lw	 $s0, -88($sp)

sw	 $s0, 328($sp)
# * ASSIGN            (ILocal -84)                        (ILocal 332)      
lw	 $s0, -84($sp)

sw	 $s0, 332($sp)
# * ASSIGN            (ILocal -80)                        (ILocal 336)      
lw	 $s0, -80($sp)

sw	 $s0, 336($sp)
# * ASSIGN            (ILocal -76)                        (ILocal 340)      
lw	 $s0, -76($sp)

sw	 $s0, 340($sp)
# * ASSIGN            (ILocal -72)                        (ILocal 344)      
lw	 $s0, -72($sp)

sw	 $s0, 344($sp)
# * ASSIGN            (ILocal -68)                        (ILocal 348)      
lw	 $s0, -68($sp)

sw	 $s0, 348($sp)
# * ASSIGN            (ILocal -64)                        (ILocal 352)      
lw	 $s0, -64($sp)

sw	 $s0, 352($sp)
# * ASSIGN            (ILocal -60)                        (ILocal 356)      
lw	 $s0, -60($sp)

sw	 $s0, 356($sp)
# * ASSIGN            (ILocal -56)                        (ILocal 360)      
lw	 $s0, -56($sp)

sw	 $s0, 360($sp)
# * ASSIGN            (ILocal -52)                        (ILocal 364)      
lw	 $s0, -52($sp)

sw	 $s0, 364($sp)
# * ASSIGN            (ILocal -48)                        (ILocal 368)      
lw	 $s0, -48($sp)

sw	 $s0, 368($sp)
# * ASSIGN            (ILocal -44)                        (ILocal 372)      
lw	 $s0, -44($sp)

sw	 $s0, 372($sp)
# * ASSIGN            (ILocal -40)                        (ILocal 376)      
lw	 $s0, -40($sp)

sw	 $s0, 376($sp)
# * ASSIGN            (ILocal -36)                        (ILocal 380)      
lw	 $s0, -36($sp)

sw	 $s0, 380($sp)
# * ASSIGN            (ILocal -32)                        (ILocal 384)      
lw	 $s0, -32($sp)

sw	 $s0, 384($sp)
# * ASSIGN            (ILocal -28)                        (ILocal 388)      
lw	 $s0, -28($sp)

sw	 $s0, 388($sp)
# * ASSIGN            (ILocal -24)                        (ILocal 392)      
lw	 $s0, -24($sp)

sw	 $s0, 392($sp)
# * ASSIGN            (ILocal -20)                        (ILocal 396)      
lw	 $s0, -20($sp)

sw	 $s0, 396($sp)
# * ASSIGN            (ILocal -16)                        (ILocal 400)      
lw	 $s0, -16($sp)

sw	 $s0, 400($sp)
# * ASSIGN            (ILocal -12)                        (ILocal 404)      
lw	 $s0, -12($sp)

sw	 $s0, 404($sp)
# * ASSIGN            (ILocal -8)                         (ILocal 408)      
lw	 $s0, -8($sp)

sw	 $s0, 408($sp)
# * ASSIGN            (ILocal -4)                         (ILocal 412)      
lw	 $s0, -4($sp)

sw	 $s0, 412($sp)
# ----------------------------
# | Original source          |
# ----------------------------
# * 	printMatrix(mat1);
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ASSIGN            (ILocal 8)                          (ILocal -2072)    
lw	 $s0, 8($sp)

sw	 $s0, -2072($sp)
# * ASSIGN            (ILocal 12)                         (ILocal -2068)    
lw	 $s0, 12($sp)

sw	 $s0, -2068($sp)
# * ASSIGN            (ILocal 16)                         (ILocal -2064)    
lw	 $s0, 16($sp)

sw	 $s0, -2064($sp)
# * ASSIGN            (ILocal 20)                         (ILocal -2060)    
lw	 $s0, 20($sp)

sw	 $s0, -2060($sp)
# * ASSIGN            (ILocal 24)                         (ILocal -2056)    
lw	 $s0, 24($sp)

sw	 $s0, -2056($sp)
# * ASSIGN            (ILocal 28)                         (ILocal -2052)    
lw	 $s0, 28($sp)

sw	 $s0, -2052($sp)
# * ASSIGN            (ILocal 32)                         (ILocal -2048)    
lw	 $s0, 32($sp)

sw	 $s0, -2048($sp)
# * ASSIGN            (ILocal 36)                         (ILocal -2044)    
lw	 $s0, 36($sp)

sw	 $s0, -2044($sp)
# * ASSIGN            (ILocal 40)                         (ILocal -2040)    
lw	 $s0, 40($sp)

sw	 $s0, -2040($sp)
# * ASSIGN            (ILocal 44)                         (ILocal -2036)    
lw	 $s0, 44($sp)

sw	 $s0, -2036($sp)
# * ASSIGN            (ILocal 48)                         (ILocal -2032)    
lw	 $s0, 48($sp)

sw	 $s0, -2032($sp)
# * ASSIGN            (ILocal 52)                         (ILocal -2028)    
lw	 $s0, 52($sp)

sw	 $s0, -2028($sp)
# * ASSIGN            (ILocal 56)                         (ILocal -2024)    
lw	 $s0, 56($sp)

sw	 $s0, -2024($sp)
# * ASSIGN            (ILocal 60)                         (ILocal -2020)    
lw	 $s0, 60($sp)

sw	 $s0, -2020($sp)
# * ASSIGN            (ILocal 64)                         (ILocal -2016)    
lw	 $s0, 64($sp)

sw	 $s0, -2016($sp)
# * ASSIGN            (ILocal 68)                         (ILocal -2012)    
lw	 $s0, 68($sp)

sw	 $s0, -2012($sp)
# * ASSIGN            (ILocal 72)                         (ILocal -2008)    
lw	 $s0, 72($sp)

sw	 $s0, -2008($sp)
# * ASSIGN            (ILocal 76)                         (ILocal -2004)    
lw	 $s0, 76($sp)

sw	 $s0, -2004($sp)
# * ASSIGN            (ILocal 80)                         (ILocal -2000)    
lw	 $s0, 80($sp)

sw	 $s0, -2000($sp)
# * ASSIGN            (ILocal 84)                         (ILocal -1996)    
lw	 $s0, 84($sp)

sw	 $s0, -1996($sp)
# * ASSIGN            (ILocal 88)                         (ILocal -1992)    
lw	 $s0, 88($sp)

sw	 $s0, -1992($sp)
# * ASSIGN            (ILocal 92)                         (ILocal -1988)    
lw	 $s0, 92($sp)

sw	 $s0, -1988($sp)
# * ASSIGN            (ILocal 96)                         (ILocal -1984)    
lw	 $s0, 96($sp)

sw	 $s0, -1984($sp)
# * ASSIGN            (ILocal 100)                        (ILocal -1980)    
lw	 $s0, 100($sp)

sw	 $s0, -1980($sp)
# * ASSIGN            (ILocal 104)                        (ILocal -1976)    
lw	 $s0, 104($sp)

sw	 $s0, -1976($sp)
# * ASSIGN            (ILocal 108)                        (ILocal -1972)    
lw	 $s0, 108($sp)

sw	 $s0, -1972($sp)
# * ASSIGN            (ILocal 112)                        (ILocal -1968)    
lw	 $s0, 112($sp)

sw	 $s0, -1968($sp)
# * ASSIGN            (ILocal 116)                        (ILocal -1964)    
lw	 $s0, 116($sp)

sw	 $s0, -1964($sp)
# * ASSIGN            (ILocal 120)                        (ILocal -1960)    
lw	 $s0, 120($sp)

sw	 $s0, -1960($sp)
# * ASSIGN            (ILocal 124)                        (ILocal -1956)    
lw	 $s0, 124($sp)

sw	 $s0, -1956($sp)
# * ASSIGN            (ILocal 128)                        (ILocal -1952)    
lw	 $s0, 128($sp)

sw	 $s0, -1952($sp)
# * ASSIGN            (ILocal 132)                        (ILocal -1948)    
lw	 $s0, 132($sp)

sw	 $s0, -1948($sp)
# * ASSIGN            (ILocal 136)                        (ILocal -1944)    
lw	 $s0, 136($sp)

sw	 $s0, -1944($sp)
# * ASSIGN            (ILocal 140)                        (ILocal -1940)    
lw	 $s0, 140($sp)

sw	 $s0, -1940($sp)
# * ASSIGN            (ILocal 144)                        (ILocal -1936)    
lw	 $s0, 144($sp)

sw	 $s0, -1936($sp)
# * ASSIGN            (ILocal 148)                        (ILocal -1932)    
lw	 $s0, 148($sp)

sw	 $s0, -1932($sp)
# * ASSIGN            (ILocal 152)                        (ILocal -1928)    
lw	 $s0, 152($sp)

sw	 $s0, -1928($sp)
# * ASSIGN            (ILocal 156)                        (ILocal -1924)    
lw	 $s0, 156($sp)

sw	 $s0, -1924($sp)
# * ASSIGN            (ILocal 160)                        (ILocal -1920)    
lw	 $s0, 160($sp)

sw	 $s0, -1920($sp)
# * ASSIGN            (ILocal 164)                        (ILocal -1916)    
lw	 $s0, 164($sp)

sw	 $s0, -1916($sp)
# * ASSIGN            (ILocal 168)                        (ILocal -1912)    
lw	 $s0, 168($sp)

sw	 $s0, -1912($sp)
# * ASSIGN            (ILocal 172)                        (ILocal -1908)    
lw	 $s0, 172($sp)

sw	 $s0, -1908($sp)
# * ASSIGN            (ILocal 176)                        (ILocal -1904)    
lw	 $s0, 176($sp)

sw	 $s0, -1904($sp)
# * ASSIGN            (ILocal 180)                        (ILocal -1900)    
lw	 $s0, 180($sp)

sw	 $s0, -1900($sp)
# * ASSIGN            (ILocal 184)                        (ILocal -1896)    
lw	 $s0, 184($sp)

sw	 $s0, -1896($sp)
# * ASSIGN            (ILocal 188)                        (ILocal -1892)    
lw	 $s0, 188($sp)

sw	 $s0, -1892($sp)
# * ASSIGN            (ILocal 192)                        (ILocal -1888)    
lw	 $s0, 192($sp)

sw	 $s0, -1888($sp)
# * ASSIGN            (ILocal 196)                        (ILocal -1884)    
lw	 $s0, 196($sp)

sw	 $s0, -1884($sp)
# * ASSIGN            (ILocal 200)                        (ILocal -1880)    
lw	 $s0, 200($sp)

sw	 $s0, -1880($sp)
# * ASSIGN            (ILocal 204)                        (ILocal -1876)    
lw	 $s0, 204($sp)

sw	 $s0, -1876($sp)
# * ASSIGN            (ILocal 208)                        (ILocal -1872)    
lw	 $s0, 208($sp)

sw	 $s0, -1872($sp)
# * ASSIGN            (ILocal 212)                        (ILocal -1868)    
lw	 $s0, 212($sp)

sw	 $s0, -1868($sp)
# * ASSIGN            (ILocal 216)                        (ILocal -1864)    
lw	 $s0, 216($sp)

sw	 $s0, -1864($sp)
# * ASSIGN            (ILocal 220)                        (ILocal -1860)    
lw	 $s0, 220($sp)

sw	 $s0, -1860($sp)
# * ASSIGN            (ILocal 224)                        (ILocal -1856)    
lw	 $s0, 224($sp)

sw	 $s0, -1856($sp)
# * ASSIGN            (ILocal 228)                        (ILocal -1852)    
lw	 $s0, 228($sp)

sw	 $s0, -1852($sp)
# * ASSIGN            (ILocal 232)                        (ILocal -1848)    
lw	 $s0, 232($sp)

sw	 $s0, -1848($sp)
# * ASSIGN            (ILocal 236)                        (ILocal -1844)    
lw	 $s0, 236($sp)

sw	 $s0, -1844($sp)
# * ASSIGN            (ILocal 240)                        (ILocal -1840)    
lw	 $s0, 240($sp)

sw	 $s0, -1840($sp)
# * ASSIGN            (ILocal 244)                        (ILocal -1836)    
lw	 $s0, 244($sp)

sw	 $s0, -1836($sp)
# * ASSIGN            (ILocal 248)                        (ILocal -1832)    
lw	 $s0, 248($sp)

sw	 $s0, -1832($sp)
# * ASSIGN            (ILocal 252)                        (ILocal -1828)    
lw	 $s0, 252($sp)

sw	 $s0, -1828($sp)
# * ASSIGN            (ILocal 256)                        (ILocal -1824)    
lw	 $s0, 256($sp)

sw	 $s0, -1824($sp)
# * ASSIGN            (ILocal 260)                        (ILocal -1820)    
lw	 $s0, 260($sp)

sw	 $s0, -1820($sp)
# * ASSIGN            (ILocal 264)                        (ILocal -1816)    
lw	 $s0, 264($sp)

sw	 $s0, -1816($sp)
# * ASSIGN            (ILocal 268)                        (ILocal -1812)    
lw	 $s0, 268($sp)

sw	 $s0, -1812($sp)
# * ASSIGN            (ILocal 272)                        (ILocal -1808)    
lw	 $s0, 272($sp)

sw	 $s0, -1808($sp)
# * ASSIGN            (ILocal 276)                        (ILocal -1804)    
lw	 $s0, 276($sp)

sw	 $s0, -1804($sp)
# * ASSIGN            (ILocal 280)                        (ILocal -1800)    
lw	 $s0, 280($sp)

sw	 $s0, -1800($sp)
# * ASSIGN            (ILocal 284)                        (ILocal -1796)    
lw	 $s0, 284($sp)

sw	 $s0, -1796($sp)
# * ASSIGN            (ILocal 288)                        (ILocal -1792)    
lw	 $s0, 288($sp)

sw	 $s0, -1792($sp)
# * ASSIGN            (ILocal 292)                        (ILocal -1788)    
lw	 $s0, 292($sp)

sw	 $s0, -1788($sp)
# * ASSIGN            (ILocal 296)                        (ILocal -1784)    
lw	 $s0, 296($sp)

sw	 $s0, -1784($sp)
# * ASSIGN            (ILocal 300)                        (ILocal -1780)    
lw	 $s0, 300($sp)

sw	 $s0, -1780($sp)
# * ASSIGN            (ILocal 304)                        (ILocal -1776)    
lw	 $s0, 304($sp)

sw	 $s0, -1776($sp)
# * ASSIGN            (ILocal 308)                        (ILocal -1772)    
lw	 $s0, 308($sp)

sw	 $s0, -1772($sp)
# * ASSIGN            (ILocal 312)                        (ILocal -1768)    
lw	 $s0, 312($sp)

sw	 $s0, -1768($sp)
# * ASSIGN            (ILocal 316)                        (ILocal -1764)    
lw	 $s0, 316($sp)

sw	 $s0, -1764($sp)
# * ASSIGN            (ILocal 320)                        (ILocal -1760)    
lw	 $s0, 320($sp)

sw	 $s0, -1760($sp)
# * ASSIGN            (ILocal 324)                        (ILocal -1756)    
lw	 $s0, 324($sp)

sw	 $s0, -1756($sp)
# * ASSIGN            (ILocal 328)                        (ILocal -1752)    
lw	 $s0, 328($sp)

sw	 $s0, -1752($sp)
# * ASSIGN            (ILocal 332)                        (ILocal -1748)    
lw	 $s0, 332($sp)

sw	 $s0, -1748($sp)
# * ASSIGN            (ILocal 336)                        (ILocal -1744)    
lw	 $s0, 336($sp)

sw	 $s0, -1744($sp)
# * ASSIGN            (ILocal 340)                        (ILocal -1740)    
lw	 $s0, 340($sp)

sw	 $s0, -1740($sp)
# * ASSIGN            (ILocal 344)                        (ILocal -1736)    
lw	 $s0, 344($sp)

sw	 $s0, -1736($sp)
# * ASSIGN            (ILocal 348)                        (ILocal -1732)    
lw	 $s0, 348($sp)

sw	 $s0, -1732($sp)
# * ASSIGN            (ILocal 352)                        (ILocal -1728)    
lw	 $s0, 352($sp)

sw	 $s0, -1728($sp)
# * ASSIGN            (ILocal 356)                        (ILocal -1724)    
lw	 $s0, 356($sp)

sw	 $s0, -1724($sp)
# * ASSIGN            (ILocal 360)                        (ILocal -1720)    
lw	 $s0, 360($sp)

sw	 $s0, -1720($sp)
# * ASSIGN            (ILocal 364)                        (ILocal -1716)    
lw	 $s0, 364($sp)

sw	 $s0, -1716($sp)
# * ASSIGN            (ILocal 368)                        (ILocal -1712)    
lw	 $s0, 368($sp)

sw	 $s0, -1712($sp)
# * ASSIGN            (ILocal 372)                        (ILocal -1708)    
lw	 $s0, 372($sp)

sw	 $s0, -1708($sp)
# * ASSIGN            (ILocal 376)                        (ILocal -1704)    
lw	 $s0, 376($sp)

sw	 $s0, -1704($sp)
# * ASSIGN            (ILocal 380)                        (ILocal -1700)    
lw	 $s0, 380($sp)

sw	 $s0, -1700($sp)
# * ASSIGN            (ILocal 384)                        (ILocal -1696)    
lw	 $s0, 384($sp)

sw	 $s0, -1696($sp)
# * ASSIGN            (ILocal 388)                        (ILocal -1692)    
lw	 $s0, 388($sp)

sw	 $s0, -1692($sp)
# * ASSIGN            (ILocal 392)                        (ILocal -1688)    
lw	 $s0, 392($sp)

sw	 $s0, -1688($sp)
# * ASSIGN            (ILocal 396)                        (ILocal -1684)    
lw	 $s0, 396($sp)

sw	 $s0, -1684($sp)
# * ASSIGN            (ILocal 400)                        (ILocal -1680)    
lw	 $s0, 400($sp)

sw	 $s0, -1680($sp)
# * ASSIGN            (ILocal 404)                        (ILocal -1676)    
lw	 $s0, 404($sp)

sw	 $s0, -1676($sp)
# * ASSIGN            (ILocal 408)                        (ILocal -1672)    
lw	 $s0, 408($sp)

sw	 $s0, -1672($sp)
# * ASSIGN            (ILocal 412)                        (ILocal -1668)    
lw	 $s0, 412($sp)

sw	 $s0, -1668($sp)
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
# * ASSIGN            (ILocal -408)                       (ILocal 416)      
lw	 $s0, -408($sp)

sw	 $s0, 416($sp)
# * ASSIGN            (ILocal -404)                       (ILocal 420)      
lw	 $s0, -404($sp)

sw	 $s0, 420($sp)
# * ASSIGN            (ILocal -400)                       (ILocal 424)      
lw	 $s0, -400($sp)

sw	 $s0, 424($sp)
# * ASSIGN            (ILocal -396)                       (ILocal 428)      
lw	 $s0, -396($sp)

sw	 $s0, 428($sp)
# * ASSIGN            (ILocal -392)                       (ILocal 432)      
lw	 $s0, -392($sp)

sw	 $s0, 432($sp)
# * ASSIGN            (ILocal -388)                       (ILocal 436)      
lw	 $s0, -388($sp)

sw	 $s0, 436($sp)
# * ASSIGN            (ILocal -384)                       (ILocal 440)      
lw	 $s0, -384($sp)

sw	 $s0, 440($sp)
# * ASSIGN            (ILocal -380)                       (ILocal 444)      
lw	 $s0, -380($sp)

sw	 $s0, 444($sp)
# * ASSIGN            (ILocal -376)                       (ILocal 448)      
lw	 $s0, -376($sp)

sw	 $s0, 448($sp)
# * ASSIGN            (ILocal -372)                       (ILocal 452)      
lw	 $s0, -372($sp)

sw	 $s0, 452($sp)
# * ASSIGN            (ILocal -368)                       (ILocal 456)      
lw	 $s0, -368($sp)

sw	 $s0, 456($sp)
# * ASSIGN            (ILocal -364)                       (ILocal 460)      
lw	 $s0, -364($sp)

sw	 $s0, 460($sp)
# * ASSIGN            (ILocal -360)                       (ILocal 464)      
lw	 $s0, -360($sp)

sw	 $s0, 464($sp)
# * ASSIGN            (ILocal -356)                       (ILocal 468)      
lw	 $s0, -356($sp)

sw	 $s0, 468($sp)
# * ASSIGN            (ILocal -352)                       (ILocal 472)      
lw	 $s0, -352($sp)

sw	 $s0, 472($sp)
# * ASSIGN            (ILocal -348)                       (ILocal 476)      
lw	 $s0, -348($sp)

sw	 $s0, 476($sp)
# * ASSIGN            (ILocal -344)                       (ILocal 480)      
lw	 $s0, -344($sp)

sw	 $s0, 480($sp)
# * ASSIGN            (ILocal -340)                       (ILocal 484)      
lw	 $s0, -340($sp)

sw	 $s0, 484($sp)
# * ASSIGN            (ILocal -336)                       (ILocal 488)      
lw	 $s0, -336($sp)

sw	 $s0, 488($sp)
# * ASSIGN            (ILocal -332)                       (ILocal 492)      
lw	 $s0, -332($sp)

sw	 $s0, 492($sp)
# * ASSIGN            (ILocal -328)                       (ILocal 496)      
lw	 $s0, -328($sp)

sw	 $s0, 496($sp)
# * ASSIGN            (ILocal -324)                       (ILocal 500)      
lw	 $s0, -324($sp)

sw	 $s0, 500($sp)
# * ASSIGN            (ILocal -320)                       (ILocal 504)      
lw	 $s0, -320($sp)

sw	 $s0, 504($sp)
# * ASSIGN            (ILocal -316)                       (ILocal 508)      
lw	 $s0, -316($sp)

sw	 $s0, 508($sp)
# * ASSIGN            (ILocal -312)                       (ILocal 512)      
lw	 $s0, -312($sp)

sw	 $s0, 512($sp)
# * ASSIGN            (ILocal -308)                       (ILocal 516)      
lw	 $s0, -308($sp)

sw	 $s0, 516($sp)
# * ASSIGN            (ILocal -304)                       (ILocal 520)      
lw	 $s0, -304($sp)

sw	 $s0, 520($sp)
# * ASSIGN            (ILocal -300)                       (ILocal 524)      
lw	 $s0, -300($sp)

sw	 $s0, 524($sp)
# * ASSIGN            (ILocal -296)                       (ILocal 528)      
lw	 $s0, -296($sp)

sw	 $s0, 528($sp)
# * ASSIGN            (ILocal -292)                       (ILocal 532)      
lw	 $s0, -292($sp)

sw	 $s0, 532($sp)
# * ASSIGN            (ILocal -288)                       (ILocal 536)      
lw	 $s0, -288($sp)

sw	 $s0, 536($sp)
# * ASSIGN            (ILocal -284)                       (ILocal 540)      
lw	 $s0, -284($sp)

sw	 $s0, 540($sp)
# * ASSIGN            (ILocal -280)                       (ILocal 544)      
lw	 $s0, -280($sp)

sw	 $s0, 544($sp)
# * ASSIGN            (ILocal -276)                       (ILocal 548)      
lw	 $s0, -276($sp)

sw	 $s0, 548($sp)
# * ASSIGN            (ILocal -272)                       (ILocal 552)      
lw	 $s0, -272($sp)

sw	 $s0, 552($sp)
# * ASSIGN            (ILocal -268)                       (ILocal 556)      
lw	 $s0, -268($sp)

sw	 $s0, 556($sp)
# * ASSIGN            (ILocal -264)                       (ILocal 560)      
lw	 $s0, -264($sp)

sw	 $s0, 560($sp)
# * ASSIGN            (ILocal -260)                       (ILocal 564)      
lw	 $s0, -260($sp)

sw	 $s0, 564($sp)
# * ASSIGN            (ILocal -256)                       (ILocal 568)      
lw	 $s0, -256($sp)

sw	 $s0, 568($sp)
# * ASSIGN            (ILocal -252)                       (ILocal 572)      
lw	 $s0, -252($sp)

sw	 $s0, 572($sp)
# * ASSIGN            (ILocal -248)                       (ILocal 576)      
lw	 $s0, -248($sp)

sw	 $s0, 576($sp)
# * ASSIGN            (ILocal -244)                       (ILocal 580)      
lw	 $s0, -244($sp)

sw	 $s0, 580($sp)
# * ASSIGN            (ILocal -240)                       (ILocal 584)      
lw	 $s0, -240($sp)

sw	 $s0, 584($sp)
# * ASSIGN            (ILocal -236)                       (ILocal 588)      
lw	 $s0, -236($sp)

sw	 $s0, 588($sp)
# * ASSIGN            (ILocal -232)                       (ILocal 592)      
lw	 $s0, -232($sp)

sw	 $s0, 592($sp)
# * ASSIGN            (ILocal -228)                       (ILocal 596)      
lw	 $s0, -228($sp)

sw	 $s0, 596($sp)
# * ASSIGN            (ILocal -224)                       (ILocal 600)      
lw	 $s0, -224($sp)

sw	 $s0, 600($sp)
# * ASSIGN            (ILocal -220)                       (ILocal 604)      
lw	 $s0, -220($sp)

sw	 $s0, 604($sp)
# * ASSIGN            (ILocal -216)                       (ILocal 608)      
lw	 $s0, -216($sp)

sw	 $s0, 608($sp)
# * ASSIGN            (ILocal -212)                       (ILocal 612)      
lw	 $s0, -212($sp)

sw	 $s0, 612($sp)
# * ASSIGN            (ILocal -208)                       (ILocal 616)      
lw	 $s0, -208($sp)

sw	 $s0, 616($sp)
# * ASSIGN            (ILocal -204)                       (ILocal 620)      
lw	 $s0, -204($sp)

sw	 $s0, 620($sp)
# * ASSIGN            (ILocal -200)                       (ILocal 624)      
lw	 $s0, -200($sp)

sw	 $s0, 624($sp)
# * ASSIGN            (ILocal -196)                       (ILocal 628)      
lw	 $s0, -196($sp)

sw	 $s0, 628($sp)
# * ASSIGN            (ILocal -192)                       (ILocal 632)      
lw	 $s0, -192($sp)

sw	 $s0, 632($sp)
# * ASSIGN            (ILocal -188)                       (ILocal 636)      
lw	 $s0, -188($sp)

sw	 $s0, 636($sp)
# * ASSIGN            (ILocal -184)                       (ILocal 640)      
lw	 $s0, -184($sp)

sw	 $s0, 640($sp)
# * ASSIGN            (ILocal -180)                       (ILocal 644)      
lw	 $s0, -180($sp)

sw	 $s0, 644($sp)
# * ASSIGN            (ILocal -176)                       (ILocal 648)      
lw	 $s0, -176($sp)

sw	 $s0, 648($sp)
# * ASSIGN            (ILocal -172)                       (ILocal 652)      
lw	 $s0, -172($sp)

sw	 $s0, 652($sp)
# * ASSIGN            (ILocal -168)                       (ILocal 656)      
lw	 $s0, -168($sp)

sw	 $s0, 656($sp)
# * ASSIGN            (ILocal -164)                       (ILocal 660)      
lw	 $s0, -164($sp)

sw	 $s0, 660($sp)
# * ASSIGN            (ILocal -160)                       (ILocal 664)      
lw	 $s0, -160($sp)

sw	 $s0, 664($sp)
# * ASSIGN            (ILocal -156)                       (ILocal 668)      
lw	 $s0, -156($sp)

sw	 $s0, 668($sp)
# * ASSIGN            (ILocal -152)                       (ILocal 672)      
lw	 $s0, -152($sp)

sw	 $s0, 672($sp)
# * ASSIGN            (ILocal -148)                       (ILocal 676)      
lw	 $s0, -148($sp)

sw	 $s0, 676($sp)
# * ASSIGN            (ILocal -144)                       (ILocal 680)      
lw	 $s0, -144($sp)

sw	 $s0, 680($sp)
# * ASSIGN            (ILocal -140)                       (ILocal 684)      
lw	 $s0, -140($sp)

sw	 $s0, 684($sp)
# * ASSIGN            (ILocal -136)                       (ILocal 688)      
lw	 $s0, -136($sp)

sw	 $s0, 688($sp)
# * ASSIGN            (ILocal -132)                       (ILocal 692)      
lw	 $s0, -132($sp)

sw	 $s0, 692($sp)
# * ASSIGN            (ILocal -128)                       (ILocal 696)      
lw	 $s0, -128($sp)

sw	 $s0, 696($sp)
# * ASSIGN            (ILocal -124)                       (ILocal 700)      
lw	 $s0, -124($sp)

sw	 $s0, 700($sp)
# * ASSIGN            (ILocal -120)                       (ILocal 704)      
lw	 $s0, -120($sp)

sw	 $s0, 704($sp)
# * ASSIGN            (ILocal -116)                       (ILocal 708)      
lw	 $s0, -116($sp)

sw	 $s0, 708($sp)
# * ASSIGN            (ILocal -112)                       (ILocal 712)      
lw	 $s0, -112($sp)

sw	 $s0, 712($sp)
# * ASSIGN            (ILocal -108)                       (ILocal 716)      
lw	 $s0, -108($sp)

sw	 $s0, 716($sp)
# * ASSIGN            (ILocal -104)                       (ILocal 720)      
lw	 $s0, -104($sp)

sw	 $s0, 720($sp)
# * ASSIGN            (ILocal -100)                       (ILocal 724)      
lw	 $s0, -100($sp)

sw	 $s0, 724($sp)
# * ASSIGN            (ILocal -96)                        (ILocal 728)      
lw	 $s0, -96($sp)

sw	 $s0, 728($sp)
# * ASSIGN            (ILocal -92)                        (ILocal 732)      
lw	 $s0, -92($sp)

sw	 $s0, 732($sp)
# * ASSIGN            (ILocal -88)                        (ILocal 736)      
lw	 $s0, -88($sp)

sw	 $s0, 736($sp)
# * ASSIGN            (ILocal -84)                        (ILocal 740)      
lw	 $s0, -84($sp)

sw	 $s0, 740($sp)
# * ASSIGN            (ILocal -80)                        (ILocal 744)      
lw	 $s0, -80($sp)

sw	 $s0, 744($sp)
# * ASSIGN            (ILocal -76)                        (ILocal 748)      
lw	 $s0, -76($sp)

sw	 $s0, 748($sp)
# * ASSIGN            (ILocal -72)                        (ILocal 752)      
lw	 $s0, -72($sp)

sw	 $s0, 752($sp)
# * ASSIGN            (ILocal -68)                        (ILocal 756)      
lw	 $s0, -68($sp)

sw	 $s0, 756($sp)
# * ASSIGN            (ILocal -64)                        (ILocal 760)      
lw	 $s0, -64($sp)

sw	 $s0, 760($sp)
# * ASSIGN            (ILocal -60)                        (ILocal 764)      
lw	 $s0, -60($sp)

sw	 $s0, 764($sp)
# * ASSIGN            (ILocal -56)                        (ILocal 768)      
lw	 $s0, -56($sp)

sw	 $s0, 768($sp)
# * ASSIGN            (ILocal -52)                        (ILocal 772)      
lw	 $s0, -52($sp)

sw	 $s0, 772($sp)
# * ASSIGN            (ILocal -48)                        (ILocal 776)      
lw	 $s0, -48($sp)

sw	 $s0, 776($sp)
# * ASSIGN            (ILocal -44)                        (ILocal 780)      
lw	 $s0, -44($sp)

sw	 $s0, 780($sp)
# * ASSIGN            (ILocal -40)                        (ILocal 784)      
lw	 $s0, -40($sp)

sw	 $s0, 784($sp)
# * ASSIGN            (ILocal -36)                        (ILocal 788)      
lw	 $s0, -36($sp)

sw	 $s0, 788($sp)
# * ASSIGN            (ILocal -32)                        (ILocal 792)      
lw	 $s0, -32($sp)

sw	 $s0, 792($sp)
# * ASSIGN            (ILocal -28)                        (ILocal 796)      
lw	 $s0, -28($sp)

sw	 $s0, 796($sp)
# * ASSIGN            (ILocal -24)                        (ILocal 800)      
lw	 $s0, -24($sp)

sw	 $s0, 800($sp)
# * ASSIGN            (ILocal -20)                        (ILocal 804)      
lw	 $s0, -20($sp)

sw	 $s0, 804($sp)
# * ASSIGN            (ILocal -16)                        (ILocal 808)      
lw	 $s0, -16($sp)

sw	 $s0, 808($sp)
# * ASSIGN            (ILocal -12)                        (ILocal 812)      
lw	 $s0, -12($sp)

sw	 $s0, 812($sp)
# * ASSIGN            (ILocal -8)                         (ILocal 816)      
lw	 $s0, -8($sp)

sw	 $s0, 816($sp)
# * ASSIGN            (ILocal -4)                         (ILocal 820)      
lw	 $s0, -4($sp)

sw	 $s0, 820($sp)
# ----------------------------
# | Original source          |
# ----------------------------
# * 	printMatrix(mat2);
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ASSIGN            (ILocal 416)                        (ILocal -2072)    
lw	 $s0, 416($sp)

sw	 $s0, -2072($sp)
# * ASSIGN            (ILocal 420)                        (ILocal -2068)    
lw	 $s0, 420($sp)

sw	 $s0, -2068($sp)
# * ASSIGN            (ILocal 424)                        (ILocal -2064)    
lw	 $s0, 424($sp)

sw	 $s0, -2064($sp)
# * ASSIGN            (ILocal 428)                        (ILocal -2060)    
lw	 $s0, 428($sp)

sw	 $s0, -2060($sp)
# * ASSIGN            (ILocal 432)                        (ILocal -2056)    
lw	 $s0, 432($sp)

sw	 $s0, -2056($sp)
# * ASSIGN            (ILocal 436)                        (ILocal -2052)    
lw	 $s0, 436($sp)

sw	 $s0, -2052($sp)
# * ASSIGN            (ILocal 440)                        (ILocal -2048)    
lw	 $s0, 440($sp)

sw	 $s0, -2048($sp)
# * ASSIGN            (ILocal 444)                        (ILocal -2044)    
lw	 $s0, 444($sp)

sw	 $s0, -2044($sp)
# * ASSIGN            (ILocal 448)                        (ILocal -2040)    
lw	 $s0, 448($sp)

sw	 $s0, -2040($sp)
# * ASSIGN            (ILocal 452)                        (ILocal -2036)    
lw	 $s0, 452($sp)

sw	 $s0, -2036($sp)
# * ASSIGN            (ILocal 456)                        (ILocal -2032)    
lw	 $s0, 456($sp)

sw	 $s0, -2032($sp)
# * ASSIGN            (ILocal 460)                        (ILocal -2028)    
lw	 $s0, 460($sp)

sw	 $s0, -2028($sp)
# * ASSIGN            (ILocal 464)                        (ILocal -2024)    
lw	 $s0, 464($sp)

sw	 $s0, -2024($sp)
# * ASSIGN            (ILocal 468)                        (ILocal -2020)    
lw	 $s0, 468($sp)

sw	 $s0, -2020($sp)
# * ASSIGN            (ILocal 472)                        (ILocal -2016)    
lw	 $s0, 472($sp)

sw	 $s0, -2016($sp)
# * ASSIGN            (ILocal 476)                        (ILocal -2012)    
lw	 $s0, 476($sp)

sw	 $s0, -2012($sp)
# * ASSIGN            (ILocal 480)                        (ILocal -2008)    
lw	 $s0, 480($sp)

sw	 $s0, -2008($sp)
# * ASSIGN            (ILocal 484)                        (ILocal -2004)    
lw	 $s0, 484($sp)

sw	 $s0, -2004($sp)
# * ASSIGN            (ILocal 488)                        (ILocal -2000)    
lw	 $s0, 488($sp)

sw	 $s0, -2000($sp)
# * ASSIGN            (ILocal 492)                        (ILocal -1996)    
lw	 $s0, 492($sp)

sw	 $s0, -1996($sp)
# * ASSIGN            (ILocal 496)                        (ILocal -1992)    
lw	 $s0, 496($sp)

sw	 $s0, -1992($sp)
# * ASSIGN            (ILocal 500)                        (ILocal -1988)    
lw	 $s0, 500($sp)

sw	 $s0, -1988($sp)
# * ASSIGN            (ILocal 504)                        (ILocal -1984)    
lw	 $s0, 504($sp)

sw	 $s0, -1984($sp)
# * ASSIGN            (ILocal 508)                        (ILocal -1980)    
lw	 $s0, 508($sp)

sw	 $s0, -1980($sp)
# * ASSIGN            (ILocal 512)                        (ILocal -1976)    
lw	 $s0, 512($sp)

sw	 $s0, -1976($sp)
# * ASSIGN            (ILocal 516)                        (ILocal -1972)    
lw	 $s0, 516($sp)

sw	 $s0, -1972($sp)
# * ASSIGN            (ILocal 520)                        (ILocal -1968)    
lw	 $s0, 520($sp)

sw	 $s0, -1968($sp)
# * ASSIGN            (ILocal 524)                        (ILocal -1964)    
lw	 $s0, 524($sp)

sw	 $s0, -1964($sp)
# * ASSIGN            (ILocal 528)                        (ILocal -1960)    
lw	 $s0, 528($sp)

sw	 $s0, -1960($sp)
# * ASSIGN            (ILocal 532)                        (ILocal -1956)    
lw	 $s0, 532($sp)

sw	 $s0, -1956($sp)
# * ASSIGN            (ILocal 536)                        (ILocal -1952)    
lw	 $s0, 536($sp)

sw	 $s0, -1952($sp)
# * ASSIGN            (ILocal 540)                        (ILocal -1948)    
lw	 $s0, 540($sp)

sw	 $s0, -1948($sp)
# * ASSIGN            (ILocal 544)                        (ILocal -1944)    
lw	 $s0, 544($sp)

sw	 $s0, -1944($sp)
# * ASSIGN            (ILocal 548)                        (ILocal -1940)    
lw	 $s0, 548($sp)

sw	 $s0, -1940($sp)
# * ASSIGN            (ILocal 552)                        (ILocal -1936)    
lw	 $s0, 552($sp)

sw	 $s0, -1936($sp)
# * ASSIGN            (ILocal 556)                        (ILocal -1932)    
lw	 $s0, 556($sp)

sw	 $s0, -1932($sp)
# * ASSIGN            (ILocal 560)                        (ILocal -1928)    
lw	 $s0, 560($sp)

sw	 $s0, -1928($sp)
# * ASSIGN            (ILocal 564)                        (ILocal -1924)    
lw	 $s0, 564($sp)

sw	 $s0, -1924($sp)
# * ASSIGN            (ILocal 568)                        (ILocal -1920)    
lw	 $s0, 568($sp)

sw	 $s0, -1920($sp)
# * ASSIGN            (ILocal 572)                        (ILocal -1916)    
lw	 $s0, 572($sp)

sw	 $s0, -1916($sp)
# * ASSIGN            (ILocal 576)                        (ILocal -1912)    
lw	 $s0, 576($sp)

sw	 $s0, -1912($sp)
# * ASSIGN            (ILocal 580)                        (ILocal -1908)    
lw	 $s0, 580($sp)

sw	 $s0, -1908($sp)
# * ASSIGN            (ILocal 584)                        (ILocal -1904)    
lw	 $s0, 584($sp)

sw	 $s0, -1904($sp)
# * ASSIGN            (ILocal 588)                        (ILocal -1900)    
lw	 $s0, 588($sp)

sw	 $s0, -1900($sp)
# * ASSIGN            (ILocal 592)                        (ILocal -1896)    
lw	 $s0, 592($sp)

sw	 $s0, -1896($sp)
# * ASSIGN            (ILocal 596)                        (ILocal -1892)    
lw	 $s0, 596($sp)

sw	 $s0, -1892($sp)
# * ASSIGN            (ILocal 600)                        (ILocal -1888)    
lw	 $s0, 600($sp)

sw	 $s0, -1888($sp)
# * ASSIGN            (ILocal 604)                        (ILocal -1884)    
lw	 $s0, 604($sp)

sw	 $s0, -1884($sp)
# * ASSIGN            (ILocal 608)                        (ILocal -1880)    
lw	 $s0, 608($sp)

sw	 $s0, -1880($sp)
# * ASSIGN            (ILocal 612)                        (ILocal -1876)    
lw	 $s0, 612($sp)

sw	 $s0, -1876($sp)
# * ASSIGN            (ILocal 616)                        (ILocal -1872)    
lw	 $s0, 616($sp)

sw	 $s0, -1872($sp)
# * ASSIGN            (ILocal 620)                        (ILocal -1868)    
lw	 $s0, 620($sp)

sw	 $s0, -1868($sp)
# * ASSIGN            (ILocal 624)                        (ILocal -1864)    
lw	 $s0, 624($sp)

sw	 $s0, -1864($sp)
# * ASSIGN            (ILocal 628)                        (ILocal -1860)    
lw	 $s0, 628($sp)

sw	 $s0, -1860($sp)
# * ASSIGN            (ILocal 632)                        (ILocal -1856)    
lw	 $s0, 632($sp)

sw	 $s0, -1856($sp)
# * ASSIGN            (ILocal 636)                        (ILocal -1852)    
lw	 $s0, 636($sp)

sw	 $s0, -1852($sp)
# * ASSIGN            (ILocal 640)                        (ILocal -1848)    
lw	 $s0, 640($sp)

sw	 $s0, -1848($sp)
# * ASSIGN            (ILocal 644)                        (ILocal -1844)    
lw	 $s0, 644($sp)

sw	 $s0, -1844($sp)
# * ASSIGN            (ILocal 648)                        (ILocal -1840)    
lw	 $s0, 648($sp)

sw	 $s0, -1840($sp)
# * ASSIGN            (ILocal 652)                        (ILocal -1836)    
lw	 $s0, 652($sp)

sw	 $s0, -1836($sp)
# * ASSIGN            (ILocal 656)                        (ILocal -1832)    
lw	 $s0, 656($sp)

sw	 $s0, -1832($sp)
# * ASSIGN            (ILocal 660)                        (ILocal -1828)    
lw	 $s0, 660($sp)

sw	 $s0, -1828($sp)
# * ASSIGN            (ILocal 664)                        (ILocal -1824)    
lw	 $s0, 664($sp)

sw	 $s0, -1824($sp)
# * ASSIGN            (ILocal 668)                        (ILocal -1820)    
lw	 $s0, 668($sp)

sw	 $s0, -1820($sp)
# * ASSIGN            (ILocal 672)                        (ILocal -1816)    
lw	 $s0, 672($sp)

sw	 $s0, -1816($sp)
# * ASSIGN            (ILocal 676)                        (ILocal -1812)    
lw	 $s0, 676($sp)

sw	 $s0, -1812($sp)
# * ASSIGN            (ILocal 680)                        (ILocal -1808)    
lw	 $s0, 680($sp)

sw	 $s0, -1808($sp)
# * ASSIGN            (ILocal 684)                        (ILocal -1804)    
lw	 $s0, 684($sp)

sw	 $s0, -1804($sp)
# * ASSIGN            (ILocal 688)                        (ILocal -1800)    
lw	 $s0, 688($sp)

sw	 $s0, -1800($sp)
# * ASSIGN            (ILocal 692)                        (ILocal -1796)    
lw	 $s0, 692($sp)

sw	 $s0, -1796($sp)
# * ASSIGN            (ILocal 696)                        (ILocal -1792)    
lw	 $s0, 696($sp)

sw	 $s0, -1792($sp)
# * ASSIGN            (ILocal 700)                        (ILocal -1788)    
lw	 $s0, 700($sp)

sw	 $s0, -1788($sp)
# * ASSIGN            (ILocal 704)                        (ILocal -1784)    
lw	 $s0, 704($sp)

sw	 $s0, -1784($sp)
# * ASSIGN            (ILocal 708)                        (ILocal -1780)    
lw	 $s0, 708($sp)

sw	 $s0, -1780($sp)
# * ASSIGN            (ILocal 712)                        (ILocal -1776)    
lw	 $s0, 712($sp)

sw	 $s0, -1776($sp)
# * ASSIGN            (ILocal 716)                        (ILocal -1772)    
lw	 $s0, 716($sp)

sw	 $s0, -1772($sp)
# * ASSIGN            (ILocal 720)                        (ILocal -1768)    
lw	 $s0, 720($sp)

sw	 $s0, -1768($sp)
# * ASSIGN            (ILocal 724)                        (ILocal -1764)    
lw	 $s0, 724($sp)

sw	 $s0, -1764($sp)
# * ASSIGN            (ILocal 728)                        (ILocal -1760)    
lw	 $s0, 728($sp)

sw	 $s0, -1760($sp)
# * ASSIGN            (ILocal 732)                        (ILocal -1756)    
lw	 $s0, 732($sp)

sw	 $s0, -1756($sp)
# * ASSIGN            (ILocal 736)                        (ILocal -1752)    
lw	 $s0, 736($sp)

sw	 $s0, -1752($sp)
# * ASSIGN            (ILocal 740)                        (ILocal -1748)    
lw	 $s0, 740($sp)

sw	 $s0, -1748($sp)
# * ASSIGN            (ILocal 744)                        (ILocal -1744)    
lw	 $s0, 744($sp)

sw	 $s0, -1744($sp)
# * ASSIGN            (ILocal 748)                        (ILocal -1740)    
lw	 $s0, 748($sp)

sw	 $s0, -1740($sp)
# * ASSIGN            (ILocal 752)                        (ILocal -1736)    
lw	 $s0, 752($sp)

sw	 $s0, -1736($sp)
# * ASSIGN            (ILocal 756)                        (ILocal -1732)    
lw	 $s0, 756($sp)

sw	 $s0, -1732($sp)
# * ASSIGN            (ILocal 760)                        (ILocal -1728)    
lw	 $s0, 760($sp)

sw	 $s0, -1728($sp)
# * ASSIGN            (ILocal 764)                        (ILocal -1724)    
lw	 $s0, 764($sp)

sw	 $s0, -1724($sp)
# * ASSIGN            (ILocal 768)                        (ILocal -1720)    
lw	 $s0, 768($sp)

sw	 $s0, -1720($sp)
# * ASSIGN            (ILocal 772)                        (ILocal -1716)    
lw	 $s0, 772($sp)

sw	 $s0, -1716($sp)
# * ASSIGN            (ILocal 776)                        (ILocal -1712)    
lw	 $s0, 776($sp)

sw	 $s0, -1712($sp)
# * ASSIGN            (ILocal 780)                        (ILocal -1708)    
lw	 $s0, 780($sp)

sw	 $s0, -1708($sp)
# * ASSIGN            (ILocal 784)                        (ILocal -1704)    
lw	 $s0, 784($sp)

sw	 $s0, -1704($sp)
# * ASSIGN            (ILocal 788)                        (ILocal -1700)    
lw	 $s0, 788($sp)

sw	 $s0, -1700($sp)
# * ASSIGN            (ILocal 792)                        (ILocal -1696)    
lw	 $s0, 792($sp)

sw	 $s0, -1696($sp)
# * ASSIGN            (ILocal 796)                        (ILocal -1692)    
lw	 $s0, 796($sp)

sw	 $s0, -1692($sp)
# * ASSIGN            (ILocal 800)                        (ILocal -1688)    
lw	 $s0, 800($sp)

sw	 $s0, -1688($sp)
# * ASSIGN            (ILocal 804)                        (ILocal -1684)    
lw	 $s0, 804($sp)

sw	 $s0, -1684($sp)
# * ASSIGN            (ILocal 808)                        (ILocal -1680)    
lw	 $s0, 808($sp)

sw	 $s0, -1680($sp)
# * ASSIGN            (ILocal 812)                        (ILocal -1676)    
lw	 $s0, 812($sp)

sw	 $s0, -1676($sp)
# * ASSIGN            (ILocal 816)                        (ILocal -1672)    
lw	 $s0, 816($sp)

sw	 $s0, -1672($sp)
# * ASSIGN            (ILocal 820)                        (ILocal -1668)    
lw	 $s0, 820($sp)

sw	 $s0, -1668($sp)
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
# * ASSIGN            (ILocal 8)                          (ILocal -3716)    
lw	 $s0, 8($sp)

sw	 $s0, -3716($sp)
# * ASSIGN            (ILocal 12)                         (ILocal -3712)    
lw	 $s0, 12($sp)

sw	 $s0, -3712($sp)
# * ASSIGN            (ILocal 16)                         (ILocal -3708)    
lw	 $s0, 16($sp)

sw	 $s0, -3708($sp)
# * ASSIGN            (ILocal 20)                         (ILocal -3704)    
lw	 $s0, 20($sp)

sw	 $s0, -3704($sp)
# * ASSIGN            (ILocal 24)                         (ILocal -3700)    
lw	 $s0, 24($sp)

sw	 $s0, -3700($sp)
# * ASSIGN            (ILocal 28)                         (ILocal -3696)    
lw	 $s0, 28($sp)

sw	 $s0, -3696($sp)
# * ASSIGN            (ILocal 32)                         (ILocal -3692)    
lw	 $s0, 32($sp)

sw	 $s0, -3692($sp)
# * ASSIGN            (ILocal 36)                         (ILocal -3688)    
lw	 $s0, 36($sp)

sw	 $s0, -3688($sp)
# * ASSIGN            (ILocal 40)                         (ILocal -3684)    
lw	 $s0, 40($sp)

sw	 $s0, -3684($sp)
# * ASSIGN            (ILocal 44)                         (ILocal -3680)    
lw	 $s0, 44($sp)

sw	 $s0, -3680($sp)
# * ASSIGN            (ILocal 48)                         (ILocal -3676)    
lw	 $s0, 48($sp)

sw	 $s0, -3676($sp)
# * ASSIGN            (ILocal 52)                         (ILocal -3672)    
lw	 $s0, 52($sp)

sw	 $s0, -3672($sp)
# * ASSIGN            (ILocal 56)                         (ILocal -3668)    
lw	 $s0, 56($sp)

sw	 $s0, -3668($sp)
# * ASSIGN            (ILocal 60)                         (ILocal -3664)    
lw	 $s0, 60($sp)

sw	 $s0, -3664($sp)
# * ASSIGN            (ILocal 64)                         (ILocal -3660)    
lw	 $s0, 64($sp)

sw	 $s0, -3660($sp)
# * ASSIGN            (ILocal 68)                         (ILocal -3656)    
lw	 $s0, 68($sp)

sw	 $s0, -3656($sp)
# * ASSIGN            (ILocal 72)                         (ILocal -3652)    
lw	 $s0, 72($sp)

sw	 $s0, -3652($sp)
# * ASSIGN            (ILocal 76)                         (ILocal -3648)    
lw	 $s0, 76($sp)

sw	 $s0, -3648($sp)
# * ASSIGN            (ILocal 80)                         (ILocal -3644)    
lw	 $s0, 80($sp)

sw	 $s0, -3644($sp)
# * ASSIGN            (ILocal 84)                         (ILocal -3640)    
lw	 $s0, 84($sp)

sw	 $s0, -3640($sp)
# * ASSIGN            (ILocal 88)                         (ILocal -3636)    
lw	 $s0, 88($sp)

sw	 $s0, -3636($sp)
# * ASSIGN            (ILocal 92)                         (ILocal -3632)    
lw	 $s0, 92($sp)

sw	 $s0, -3632($sp)
# * ASSIGN            (ILocal 96)                         (ILocal -3628)    
lw	 $s0, 96($sp)

sw	 $s0, -3628($sp)
# * ASSIGN            (ILocal 100)                        (ILocal -3624)    
lw	 $s0, 100($sp)

sw	 $s0, -3624($sp)
# * ASSIGN            (ILocal 104)                        (ILocal -3620)    
lw	 $s0, 104($sp)

sw	 $s0, -3620($sp)
# * ASSIGN            (ILocal 108)                        (ILocal -3616)    
lw	 $s0, 108($sp)

sw	 $s0, -3616($sp)
# * ASSIGN            (ILocal 112)                        (ILocal -3612)    
lw	 $s0, 112($sp)

sw	 $s0, -3612($sp)
# * ASSIGN            (ILocal 116)                        (ILocal -3608)    
lw	 $s0, 116($sp)

sw	 $s0, -3608($sp)
# * ASSIGN            (ILocal 120)                        (ILocal -3604)    
lw	 $s0, 120($sp)

sw	 $s0, -3604($sp)
# * ASSIGN            (ILocal 124)                        (ILocal -3600)    
lw	 $s0, 124($sp)

sw	 $s0, -3600($sp)
# * ASSIGN            (ILocal 128)                        (ILocal -3596)    
lw	 $s0, 128($sp)

sw	 $s0, -3596($sp)
# * ASSIGN            (ILocal 132)                        (ILocal -3592)    
lw	 $s0, 132($sp)

sw	 $s0, -3592($sp)
# * ASSIGN            (ILocal 136)                        (ILocal -3588)    
lw	 $s0, 136($sp)

sw	 $s0, -3588($sp)
# * ASSIGN            (ILocal 140)                        (ILocal -3584)    
lw	 $s0, 140($sp)

sw	 $s0, -3584($sp)
# * ASSIGN            (ILocal 144)                        (ILocal -3580)    
lw	 $s0, 144($sp)

sw	 $s0, -3580($sp)
# * ASSIGN            (ILocal 148)                        (ILocal -3576)    
lw	 $s0, 148($sp)

sw	 $s0, -3576($sp)
# * ASSIGN            (ILocal 152)                        (ILocal -3572)    
lw	 $s0, 152($sp)

sw	 $s0, -3572($sp)
# * ASSIGN            (ILocal 156)                        (ILocal -3568)    
lw	 $s0, 156($sp)

sw	 $s0, -3568($sp)
# * ASSIGN            (ILocal 160)                        (ILocal -3564)    
lw	 $s0, 160($sp)

sw	 $s0, -3564($sp)
# * ASSIGN            (ILocal 164)                        (ILocal -3560)    
lw	 $s0, 164($sp)

sw	 $s0, -3560($sp)
# * ASSIGN            (ILocal 168)                        (ILocal -3556)    
lw	 $s0, 168($sp)

sw	 $s0, -3556($sp)
# * ASSIGN            (ILocal 172)                        (ILocal -3552)    
lw	 $s0, 172($sp)

sw	 $s0, -3552($sp)
# * ASSIGN            (ILocal 176)                        (ILocal -3548)    
lw	 $s0, 176($sp)

sw	 $s0, -3548($sp)
# * ASSIGN            (ILocal 180)                        (ILocal -3544)    
lw	 $s0, 180($sp)

sw	 $s0, -3544($sp)
# * ASSIGN            (ILocal 184)                        (ILocal -3540)    
lw	 $s0, 184($sp)

sw	 $s0, -3540($sp)
# * ASSIGN            (ILocal 188)                        (ILocal -3536)    
lw	 $s0, 188($sp)

sw	 $s0, -3536($sp)
# * ASSIGN            (ILocal 192)                        (ILocal -3532)    
lw	 $s0, 192($sp)

sw	 $s0, -3532($sp)
# * ASSIGN            (ILocal 196)                        (ILocal -3528)    
lw	 $s0, 196($sp)

sw	 $s0, -3528($sp)
# * ASSIGN            (ILocal 200)                        (ILocal -3524)    
lw	 $s0, 200($sp)

sw	 $s0, -3524($sp)
# * ASSIGN            (ILocal 204)                        (ILocal -3520)    
lw	 $s0, 204($sp)

sw	 $s0, -3520($sp)
# * ASSIGN            (ILocal 208)                        (ILocal -3516)    
lw	 $s0, 208($sp)

sw	 $s0, -3516($sp)
# * ASSIGN            (ILocal 212)                        (ILocal -3512)    
lw	 $s0, 212($sp)

sw	 $s0, -3512($sp)
# * ASSIGN            (ILocal 216)                        (ILocal -3508)    
lw	 $s0, 216($sp)

sw	 $s0, -3508($sp)
# * ASSIGN            (ILocal 220)                        (ILocal -3504)    
lw	 $s0, 220($sp)

sw	 $s0, -3504($sp)
# * ASSIGN            (ILocal 224)                        (ILocal -3500)    
lw	 $s0, 224($sp)

sw	 $s0, -3500($sp)
# * ASSIGN            (ILocal 228)                        (ILocal -3496)    
lw	 $s0, 228($sp)

sw	 $s0, -3496($sp)
# * ASSIGN            (ILocal 232)                        (ILocal -3492)    
lw	 $s0, 232($sp)

sw	 $s0, -3492($sp)
# * ASSIGN            (ILocal 236)                        (ILocal -3488)    
lw	 $s0, 236($sp)

sw	 $s0, -3488($sp)
# * ASSIGN            (ILocal 240)                        (ILocal -3484)    
lw	 $s0, 240($sp)

sw	 $s0, -3484($sp)
# * ASSIGN            (ILocal 244)                        (ILocal -3480)    
lw	 $s0, 244($sp)

sw	 $s0, -3480($sp)
# * ASSIGN            (ILocal 248)                        (ILocal -3476)    
lw	 $s0, 248($sp)

sw	 $s0, -3476($sp)
# * ASSIGN            (ILocal 252)                        (ILocal -3472)    
lw	 $s0, 252($sp)

sw	 $s0, -3472($sp)
# * ASSIGN            (ILocal 256)                        (ILocal -3468)    
lw	 $s0, 256($sp)

sw	 $s0, -3468($sp)
# * ASSIGN            (ILocal 260)                        (ILocal -3464)    
lw	 $s0, 260($sp)

sw	 $s0, -3464($sp)
# * ASSIGN            (ILocal 264)                        (ILocal -3460)    
lw	 $s0, 264($sp)

sw	 $s0, -3460($sp)
# * ASSIGN            (ILocal 268)                        (ILocal -3456)    
lw	 $s0, 268($sp)

sw	 $s0, -3456($sp)
# * ASSIGN            (ILocal 272)                        (ILocal -3452)    
lw	 $s0, 272($sp)

sw	 $s0, -3452($sp)
# * ASSIGN            (ILocal 276)                        (ILocal -3448)    
lw	 $s0, 276($sp)

sw	 $s0, -3448($sp)
# * ASSIGN            (ILocal 280)                        (ILocal -3444)    
lw	 $s0, 280($sp)

sw	 $s0, -3444($sp)
# * ASSIGN            (ILocal 284)                        (ILocal -3440)    
lw	 $s0, 284($sp)

sw	 $s0, -3440($sp)
# * ASSIGN            (ILocal 288)                        (ILocal -3436)    
lw	 $s0, 288($sp)

sw	 $s0, -3436($sp)
# * ASSIGN            (ILocal 292)                        (ILocal -3432)    
lw	 $s0, 292($sp)

sw	 $s0, -3432($sp)
# * ASSIGN            (ILocal 296)                        (ILocal -3428)    
lw	 $s0, 296($sp)

sw	 $s0, -3428($sp)
# * ASSIGN            (ILocal 300)                        (ILocal -3424)    
lw	 $s0, 300($sp)

sw	 $s0, -3424($sp)
# * ASSIGN            (ILocal 304)                        (ILocal -3420)    
lw	 $s0, 304($sp)

sw	 $s0, -3420($sp)
# * ASSIGN            (ILocal 308)                        (ILocal -3416)    
lw	 $s0, 308($sp)

sw	 $s0, -3416($sp)
# * ASSIGN            (ILocal 312)                        (ILocal -3412)    
lw	 $s0, 312($sp)

sw	 $s0, -3412($sp)
# * ASSIGN            (ILocal 316)                        (ILocal -3408)    
lw	 $s0, 316($sp)

sw	 $s0, -3408($sp)
# * ASSIGN            (ILocal 320)                        (ILocal -3404)    
lw	 $s0, 320($sp)

sw	 $s0, -3404($sp)
# * ASSIGN            (ILocal 324)                        (ILocal -3400)    
lw	 $s0, 324($sp)

sw	 $s0, -3400($sp)
# * ASSIGN            (ILocal 328)                        (ILocal -3396)    
lw	 $s0, 328($sp)

sw	 $s0, -3396($sp)
# * ASSIGN            (ILocal 332)                        (ILocal -3392)    
lw	 $s0, 332($sp)

sw	 $s0, -3392($sp)
# * ASSIGN            (ILocal 336)                        (ILocal -3388)    
lw	 $s0, 336($sp)

sw	 $s0, -3388($sp)
# * ASSIGN            (ILocal 340)                        (ILocal -3384)    
lw	 $s0, 340($sp)

sw	 $s0, -3384($sp)
# * ASSIGN            (ILocal 344)                        (ILocal -3380)    
lw	 $s0, 344($sp)

sw	 $s0, -3380($sp)
# * ASSIGN            (ILocal 348)                        (ILocal -3376)    
lw	 $s0, 348($sp)

sw	 $s0, -3376($sp)
# * ASSIGN            (ILocal 352)                        (ILocal -3372)    
lw	 $s0, 352($sp)

sw	 $s0, -3372($sp)
# * ASSIGN            (ILocal 356)                        (ILocal -3368)    
lw	 $s0, 356($sp)

sw	 $s0, -3368($sp)
# * ASSIGN            (ILocal 360)                        (ILocal -3364)    
lw	 $s0, 360($sp)

sw	 $s0, -3364($sp)
# * ASSIGN            (ILocal 364)                        (ILocal -3360)    
lw	 $s0, 364($sp)

sw	 $s0, -3360($sp)
# * ASSIGN            (ILocal 368)                        (ILocal -3356)    
lw	 $s0, 368($sp)

sw	 $s0, -3356($sp)
# * ASSIGN            (ILocal 372)                        (ILocal -3352)    
lw	 $s0, 372($sp)

sw	 $s0, -3352($sp)
# * ASSIGN            (ILocal 376)                        (ILocal -3348)    
lw	 $s0, 376($sp)

sw	 $s0, -3348($sp)
# * ASSIGN            (ILocal 380)                        (ILocal -3344)    
lw	 $s0, 380($sp)

sw	 $s0, -3344($sp)
# * ASSIGN            (ILocal 384)                        (ILocal -3340)    
lw	 $s0, 384($sp)

sw	 $s0, -3340($sp)
# * ASSIGN            (ILocal 388)                        (ILocal -3336)    
lw	 $s0, 388($sp)

sw	 $s0, -3336($sp)
# * ASSIGN            (ILocal 392)                        (ILocal -3332)    
lw	 $s0, 392($sp)

sw	 $s0, -3332($sp)
# * ASSIGN            (ILocal 396)                        (ILocal -3328)    
lw	 $s0, 396($sp)

sw	 $s0, -3328($sp)
# * ASSIGN            (ILocal 400)                        (ILocal -3324)    
lw	 $s0, 400($sp)

sw	 $s0, -3324($sp)
# * ASSIGN            (ILocal 404)                        (ILocal -3320)    
lw	 $s0, 404($sp)

sw	 $s0, -3320($sp)
# * ASSIGN            (ILocal 408)                        (ILocal -3316)    
lw	 $s0, 408($sp)

sw	 $s0, -3316($sp)
# * ASSIGN            (ILocal 412)                        (ILocal -3312)    
lw	 $s0, 412($sp)

sw	 $s0, -3312($sp)
# * ASSIGN            (ILocal 416)                        (ILocal -3308)    
lw	 $s0, 416($sp)

sw	 $s0, -3308($sp)
# * ASSIGN            (ILocal 420)                        (ILocal -3304)    
lw	 $s0, 420($sp)

sw	 $s0, -3304($sp)
# * ASSIGN            (ILocal 424)                        (ILocal -3300)    
lw	 $s0, 424($sp)

sw	 $s0, -3300($sp)
# * ASSIGN            (ILocal 428)                        (ILocal -3296)    
lw	 $s0, 428($sp)

sw	 $s0, -3296($sp)
# * ASSIGN            (ILocal 432)                        (ILocal -3292)    
lw	 $s0, 432($sp)

sw	 $s0, -3292($sp)
# * ASSIGN            (ILocal 436)                        (ILocal -3288)    
lw	 $s0, 436($sp)

sw	 $s0, -3288($sp)
# * ASSIGN            (ILocal 440)                        (ILocal -3284)    
lw	 $s0, 440($sp)

sw	 $s0, -3284($sp)
# * ASSIGN            (ILocal 444)                        (ILocal -3280)    
lw	 $s0, 444($sp)

sw	 $s0, -3280($sp)
# * ASSIGN            (ILocal 448)                        (ILocal -3276)    
lw	 $s0, 448($sp)

sw	 $s0, -3276($sp)
# * ASSIGN            (ILocal 452)                        (ILocal -3272)    
lw	 $s0, 452($sp)

sw	 $s0, -3272($sp)
# * ASSIGN            (ILocal 456)                        (ILocal -3268)    
lw	 $s0, 456($sp)

sw	 $s0, -3268($sp)
# * ASSIGN            (ILocal 460)                        (ILocal -3264)    
lw	 $s0, 460($sp)

sw	 $s0, -3264($sp)
# * ASSIGN            (ILocal 464)                        (ILocal -3260)    
lw	 $s0, 464($sp)

sw	 $s0, -3260($sp)
# * ASSIGN            (ILocal 468)                        (ILocal -3256)    
lw	 $s0, 468($sp)

sw	 $s0, -3256($sp)
# * ASSIGN            (ILocal 472)                        (ILocal -3252)    
lw	 $s0, 472($sp)

sw	 $s0, -3252($sp)
# * ASSIGN            (ILocal 476)                        (ILocal -3248)    
lw	 $s0, 476($sp)

sw	 $s0, -3248($sp)
# * ASSIGN            (ILocal 480)                        (ILocal -3244)    
lw	 $s0, 480($sp)

sw	 $s0, -3244($sp)
# * ASSIGN            (ILocal 484)                        (ILocal -3240)    
lw	 $s0, 484($sp)

sw	 $s0, -3240($sp)
# * ASSIGN            (ILocal 488)                        (ILocal -3236)    
lw	 $s0, 488($sp)

sw	 $s0, -3236($sp)
# * ASSIGN            (ILocal 492)                        (ILocal -3232)    
lw	 $s0, 492($sp)

sw	 $s0, -3232($sp)
# * ASSIGN            (ILocal 496)                        (ILocal -3228)    
lw	 $s0, 496($sp)

sw	 $s0, -3228($sp)
# * ASSIGN            (ILocal 500)                        (ILocal -3224)    
lw	 $s0, 500($sp)

sw	 $s0, -3224($sp)
# * ASSIGN            (ILocal 504)                        (ILocal -3220)    
lw	 $s0, 504($sp)

sw	 $s0, -3220($sp)
# * ASSIGN            (ILocal 508)                        (ILocal -3216)    
lw	 $s0, 508($sp)

sw	 $s0, -3216($sp)
# * ASSIGN            (ILocal 512)                        (ILocal -3212)    
lw	 $s0, 512($sp)

sw	 $s0, -3212($sp)
# * ASSIGN            (ILocal 516)                        (ILocal -3208)    
lw	 $s0, 516($sp)

sw	 $s0, -3208($sp)
# * ASSIGN            (ILocal 520)                        (ILocal -3204)    
lw	 $s0, 520($sp)

sw	 $s0, -3204($sp)
# * ASSIGN            (ILocal 524)                        (ILocal -3200)    
lw	 $s0, 524($sp)

sw	 $s0, -3200($sp)
# * ASSIGN            (ILocal 528)                        (ILocal -3196)    
lw	 $s0, 528($sp)

sw	 $s0, -3196($sp)
# * ASSIGN            (ILocal 532)                        (ILocal -3192)    
lw	 $s0, 532($sp)

sw	 $s0, -3192($sp)
# * ASSIGN            (ILocal 536)                        (ILocal -3188)    
lw	 $s0, 536($sp)

sw	 $s0, -3188($sp)
# * ASSIGN            (ILocal 540)                        (ILocal -3184)    
lw	 $s0, 540($sp)

sw	 $s0, -3184($sp)
# * ASSIGN            (ILocal 544)                        (ILocal -3180)    
lw	 $s0, 544($sp)

sw	 $s0, -3180($sp)
# * ASSIGN            (ILocal 548)                        (ILocal -3176)    
lw	 $s0, 548($sp)

sw	 $s0, -3176($sp)
# * ASSIGN            (ILocal 552)                        (ILocal -3172)    
lw	 $s0, 552($sp)

sw	 $s0, -3172($sp)
# * ASSIGN            (ILocal 556)                        (ILocal -3168)    
lw	 $s0, 556($sp)

sw	 $s0, -3168($sp)
# * ASSIGN            (ILocal 560)                        (ILocal -3164)    
lw	 $s0, 560($sp)

sw	 $s0, -3164($sp)
# * ASSIGN            (ILocal 564)                        (ILocal -3160)    
lw	 $s0, 564($sp)

sw	 $s0, -3160($sp)
# * ASSIGN            (ILocal 568)                        (ILocal -3156)    
lw	 $s0, 568($sp)

sw	 $s0, -3156($sp)
# * ASSIGN            (ILocal 572)                        (ILocal -3152)    
lw	 $s0, 572($sp)

sw	 $s0, -3152($sp)
# * ASSIGN            (ILocal 576)                        (ILocal -3148)    
lw	 $s0, 576($sp)

sw	 $s0, -3148($sp)
# * ASSIGN            (ILocal 580)                        (ILocal -3144)    
lw	 $s0, 580($sp)

sw	 $s0, -3144($sp)
# * ASSIGN            (ILocal 584)                        (ILocal -3140)    
lw	 $s0, 584($sp)

sw	 $s0, -3140($sp)
# * ASSIGN            (ILocal 588)                        (ILocal -3136)    
lw	 $s0, 588($sp)

sw	 $s0, -3136($sp)
# * ASSIGN            (ILocal 592)                        (ILocal -3132)    
lw	 $s0, 592($sp)

sw	 $s0, -3132($sp)
# * ASSIGN            (ILocal 596)                        (ILocal -3128)    
lw	 $s0, 596($sp)

sw	 $s0, -3128($sp)
# * ASSIGN            (ILocal 600)                        (ILocal -3124)    
lw	 $s0, 600($sp)

sw	 $s0, -3124($sp)
# * ASSIGN            (ILocal 604)                        (ILocal -3120)    
lw	 $s0, 604($sp)

sw	 $s0, -3120($sp)
# * ASSIGN            (ILocal 608)                        (ILocal -3116)    
lw	 $s0, 608($sp)

sw	 $s0, -3116($sp)
# * ASSIGN            (ILocal 612)                        (ILocal -3112)    
lw	 $s0, 612($sp)

sw	 $s0, -3112($sp)
# * ASSIGN            (ILocal 616)                        (ILocal -3108)    
lw	 $s0, 616($sp)

sw	 $s0, -3108($sp)
# * ASSIGN            (ILocal 620)                        (ILocal -3104)    
lw	 $s0, 620($sp)

sw	 $s0, -3104($sp)
# * ASSIGN            (ILocal 624)                        (ILocal -3100)    
lw	 $s0, 624($sp)

sw	 $s0, -3100($sp)
# * ASSIGN            (ILocal 628)                        (ILocal -3096)    
lw	 $s0, 628($sp)

sw	 $s0, -3096($sp)
# * ASSIGN            (ILocal 632)                        (ILocal -3092)    
lw	 $s0, 632($sp)

sw	 $s0, -3092($sp)
# * ASSIGN            (ILocal 636)                        (ILocal -3088)    
lw	 $s0, 636($sp)

sw	 $s0, -3088($sp)
# * ASSIGN            (ILocal 640)                        (ILocal -3084)    
lw	 $s0, 640($sp)

sw	 $s0, -3084($sp)
# * ASSIGN            (ILocal 644)                        (ILocal -3080)    
lw	 $s0, 644($sp)

sw	 $s0, -3080($sp)
# * ASSIGN            (ILocal 648)                        (ILocal -3076)    
lw	 $s0, 648($sp)

sw	 $s0, -3076($sp)
# * ASSIGN            (ILocal 652)                        (ILocal -3072)    
lw	 $s0, 652($sp)

sw	 $s0, -3072($sp)
# * ASSIGN            (ILocal 656)                        (ILocal -3068)    
lw	 $s0, 656($sp)

sw	 $s0, -3068($sp)
# * ASSIGN            (ILocal 660)                        (ILocal -3064)    
lw	 $s0, 660($sp)

sw	 $s0, -3064($sp)
# * ASSIGN            (ILocal 664)                        (ILocal -3060)    
lw	 $s0, 664($sp)

sw	 $s0, -3060($sp)
# * ASSIGN            (ILocal 668)                        (ILocal -3056)    
lw	 $s0, 668($sp)

sw	 $s0, -3056($sp)
# * ASSIGN            (ILocal 672)                        (ILocal -3052)    
lw	 $s0, 672($sp)

sw	 $s0, -3052($sp)
# * ASSIGN            (ILocal 676)                        (ILocal -3048)    
lw	 $s0, 676($sp)

sw	 $s0, -3048($sp)
# * ASSIGN            (ILocal 680)                        (ILocal -3044)    
lw	 $s0, 680($sp)

sw	 $s0, -3044($sp)
# * ASSIGN            (ILocal 684)                        (ILocal -3040)    
lw	 $s0, 684($sp)

sw	 $s0, -3040($sp)
# * ASSIGN            (ILocal 688)                        (ILocal -3036)    
lw	 $s0, 688($sp)

sw	 $s0, -3036($sp)
# * ASSIGN            (ILocal 692)                        (ILocal -3032)    
lw	 $s0, 692($sp)

sw	 $s0, -3032($sp)
# * ASSIGN            (ILocal 696)                        (ILocal -3028)    
lw	 $s0, 696($sp)

sw	 $s0, -3028($sp)
# * ASSIGN            (ILocal 700)                        (ILocal -3024)    
lw	 $s0, 700($sp)

sw	 $s0, -3024($sp)
# * ASSIGN            (ILocal 704)                        (ILocal -3020)    
lw	 $s0, 704($sp)

sw	 $s0, -3020($sp)
# * ASSIGN            (ILocal 708)                        (ILocal -3016)    
lw	 $s0, 708($sp)

sw	 $s0, -3016($sp)
# * ASSIGN            (ILocal 712)                        (ILocal -3012)    
lw	 $s0, 712($sp)

sw	 $s0, -3012($sp)
# * ASSIGN            (ILocal 716)                        (ILocal -3008)    
lw	 $s0, 716($sp)

sw	 $s0, -3008($sp)
# * ASSIGN            (ILocal 720)                        (ILocal -3004)    
lw	 $s0, 720($sp)

sw	 $s0, -3004($sp)
# * ASSIGN            (ILocal 724)                        (ILocal -3000)    
lw	 $s0, 724($sp)

sw	 $s0, -3000($sp)
# * ASSIGN            (ILocal 728)                        (ILocal -2996)    
lw	 $s0, 728($sp)

sw	 $s0, -2996($sp)
# * ASSIGN            (ILocal 732)                        (ILocal -2992)    
lw	 $s0, 732($sp)

sw	 $s0, -2992($sp)
# * ASSIGN            (ILocal 736)                        (ILocal -2988)    
lw	 $s0, 736($sp)

sw	 $s0, -2988($sp)
# * ASSIGN            (ILocal 740)                        (ILocal -2984)    
lw	 $s0, 740($sp)

sw	 $s0, -2984($sp)
# * ASSIGN            (ILocal 744)                        (ILocal -2980)    
lw	 $s0, 744($sp)

sw	 $s0, -2980($sp)
# * ASSIGN            (ILocal 748)                        (ILocal -2976)    
lw	 $s0, 748($sp)

sw	 $s0, -2976($sp)
# * ASSIGN            (ILocal 752)                        (ILocal -2972)    
lw	 $s0, 752($sp)

sw	 $s0, -2972($sp)
# * ASSIGN            (ILocal 756)                        (ILocal -2968)    
lw	 $s0, 756($sp)

sw	 $s0, -2968($sp)
# * ASSIGN            (ILocal 760)                        (ILocal -2964)    
lw	 $s0, 760($sp)

sw	 $s0, -2964($sp)
# * ASSIGN            (ILocal 764)                        (ILocal -2960)    
lw	 $s0, 764($sp)

sw	 $s0, -2960($sp)
# * ASSIGN            (ILocal 768)                        (ILocal -2956)    
lw	 $s0, 768($sp)

sw	 $s0, -2956($sp)
# * ASSIGN            (ILocal 772)                        (ILocal -2952)    
lw	 $s0, 772($sp)

sw	 $s0, -2952($sp)
# * ASSIGN            (ILocal 776)                        (ILocal -2948)    
lw	 $s0, 776($sp)

sw	 $s0, -2948($sp)
# * ASSIGN            (ILocal 780)                        (ILocal -2944)    
lw	 $s0, 780($sp)

sw	 $s0, -2944($sp)
# * ASSIGN            (ILocal 784)                        (ILocal -2940)    
lw	 $s0, 784($sp)

sw	 $s0, -2940($sp)
# * ASSIGN            (ILocal 788)                        (ILocal -2936)    
lw	 $s0, 788($sp)

sw	 $s0, -2936($sp)
# * ASSIGN            (ILocal 792)                        (ILocal -2932)    
lw	 $s0, 792($sp)

sw	 $s0, -2932($sp)
# * ASSIGN            (ILocal 796)                        (ILocal -2928)    
lw	 $s0, 796($sp)

sw	 $s0, -2928($sp)
# * ASSIGN            (ILocal 800)                        (ILocal -2924)    
lw	 $s0, 800($sp)

sw	 $s0, -2924($sp)
# * ASSIGN            (ILocal 804)                        (ILocal -2920)    
lw	 $s0, 804($sp)

sw	 $s0, -2920($sp)
# * ASSIGN            (ILocal 808)                        (ILocal -2916)    
lw	 $s0, 808($sp)

sw	 $s0, -2916($sp)
# * ASSIGN            (ILocal 812)                        (ILocal -2912)    
lw	 $s0, 812($sp)

sw	 $s0, -2912($sp)
# * ASSIGN            (ILocal 816)                        (ILocal -2908)    
lw	 $s0, 816($sp)

sw	 $s0, -2908($sp)
# * ASSIGN            (ILocal 820)                        (ILocal -2904)    
lw	 $s0, 820($sp)

sw	 $s0, -2904($sp)
# * CALL                                                  (LABEL multiplyMatrices1)
jal	 multiplyMatrices1
# * ASSIGN            (ILocal -408)                       (ILocal -2072)    
lw	 $s0, -408($sp)

sw	 $s0, -2072($sp)
# * ASSIGN            (ILocal -404)                       (ILocal -2068)    
lw	 $s0, -404($sp)

sw	 $s0, -2068($sp)
# * ASSIGN            (ILocal -400)                       (ILocal -2064)    
lw	 $s0, -400($sp)

sw	 $s0, -2064($sp)
# * ASSIGN            (ILocal -396)                       (ILocal -2060)    
lw	 $s0, -396($sp)

sw	 $s0, -2060($sp)
# * ASSIGN            (ILocal -392)                       (ILocal -2056)    
lw	 $s0, -392($sp)

sw	 $s0, -2056($sp)
# * ASSIGN            (ILocal -388)                       (ILocal -2052)    
lw	 $s0, -388($sp)

sw	 $s0, -2052($sp)
# * ASSIGN            (ILocal -384)                       (ILocal -2048)    
lw	 $s0, -384($sp)

sw	 $s0, -2048($sp)
# * ASSIGN            (ILocal -380)                       (ILocal -2044)    
lw	 $s0, -380($sp)

sw	 $s0, -2044($sp)
# * ASSIGN            (ILocal -376)                       (ILocal -2040)    
lw	 $s0, -376($sp)

sw	 $s0, -2040($sp)
# * ASSIGN            (ILocal -372)                       (ILocal -2036)    
lw	 $s0, -372($sp)

sw	 $s0, -2036($sp)
# * ASSIGN            (ILocal -368)                       (ILocal -2032)    
lw	 $s0, -368($sp)

sw	 $s0, -2032($sp)
# * ASSIGN            (ILocal -364)                       (ILocal -2028)    
lw	 $s0, -364($sp)

sw	 $s0, -2028($sp)
# * ASSIGN            (ILocal -360)                       (ILocal -2024)    
lw	 $s0, -360($sp)

sw	 $s0, -2024($sp)
# * ASSIGN            (ILocal -356)                       (ILocal -2020)    
lw	 $s0, -356($sp)

sw	 $s0, -2020($sp)
# * ASSIGN            (ILocal -352)                       (ILocal -2016)    
lw	 $s0, -352($sp)

sw	 $s0, -2016($sp)
# * ASSIGN            (ILocal -348)                       (ILocal -2012)    
lw	 $s0, -348($sp)

sw	 $s0, -2012($sp)
# * ASSIGN            (ILocal -344)                       (ILocal -2008)    
lw	 $s0, -344($sp)

sw	 $s0, -2008($sp)
# * ASSIGN            (ILocal -340)                       (ILocal -2004)    
lw	 $s0, -340($sp)

sw	 $s0, -2004($sp)
# * ASSIGN            (ILocal -336)                       (ILocal -2000)    
lw	 $s0, -336($sp)

sw	 $s0, -2000($sp)
# * ASSIGN            (ILocal -332)                       (ILocal -1996)    
lw	 $s0, -332($sp)

sw	 $s0, -1996($sp)
# * ASSIGN            (ILocal -328)                       (ILocal -1992)    
lw	 $s0, -328($sp)

sw	 $s0, -1992($sp)
# * ASSIGN            (ILocal -324)                       (ILocal -1988)    
lw	 $s0, -324($sp)

sw	 $s0, -1988($sp)
# * ASSIGN            (ILocal -320)                       (ILocal -1984)    
lw	 $s0, -320($sp)

sw	 $s0, -1984($sp)
# * ASSIGN            (ILocal -316)                       (ILocal -1980)    
lw	 $s0, -316($sp)

sw	 $s0, -1980($sp)
# * ASSIGN            (ILocal -312)                       (ILocal -1976)    
lw	 $s0, -312($sp)

sw	 $s0, -1976($sp)
# * ASSIGN            (ILocal -308)                       (ILocal -1972)    
lw	 $s0, -308($sp)

sw	 $s0, -1972($sp)
# * ASSIGN            (ILocal -304)                       (ILocal -1968)    
lw	 $s0, -304($sp)

sw	 $s0, -1968($sp)
# * ASSIGN            (ILocal -300)                       (ILocal -1964)    
lw	 $s0, -300($sp)

sw	 $s0, -1964($sp)
# * ASSIGN            (ILocal -296)                       (ILocal -1960)    
lw	 $s0, -296($sp)

sw	 $s0, -1960($sp)
# * ASSIGN            (ILocal -292)                       (ILocal -1956)    
lw	 $s0, -292($sp)

sw	 $s0, -1956($sp)
# * ASSIGN            (ILocal -288)                       (ILocal -1952)    
lw	 $s0, -288($sp)

sw	 $s0, -1952($sp)
# * ASSIGN            (ILocal -284)                       (ILocal -1948)    
lw	 $s0, -284($sp)

sw	 $s0, -1948($sp)
# * ASSIGN            (ILocal -280)                       (ILocal -1944)    
lw	 $s0, -280($sp)

sw	 $s0, -1944($sp)
# * ASSIGN            (ILocal -276)                       (ILocal -1940)    
lw	 $s0, -276($sp)

sw	 $s0, -1940($sp)
# * ASSIGN            (ILocal -272)                       (ILocal -1936)    
lw	 $s0, -272($sp)

sw	 $s0, -1936($sp)
# * ASSIGN            (ILocal -268)                       (ILocal -1932)    
lw	 $s0, -268($sp)

sw	 $s0, -1932($sp)
# * ASSIGN            (ILocal -264)                       (ILocal -1928)    
lw	 $s0, -264($sp)

sw	 $s0, -1928($sp)
# * ASSIGN            (ILocal -260)                       (ILocal -1924)    
lw	 $s0, -260($sp)

sw	 $s0, -1924($sp)
# * ASSIGN            (ILocal -256)                       (ILocal -1920)    
lw	 $s0, -256($sp)

sw	 $s0, -1920($sp)
# * ASSIGN            (ILocal -252)                       (ILocal -1916)    
lw	 $s0, -252($sp)

sw	 $s0, -1916($sp)
# * ASSIGN            (ILocal -248)                       (ILocal -1912)    
lw	 $s0, -248($sp)

sw	 $s0, -1912($sp)
# * ASSIGN            (ILocal -244)                       (ILocal -1908)    
lw	 $s0, -244($sp)

sw	 $s0, -1908($sp)
# * ASSIGN            (ILocal -240)                       (ILocal -1904)    
lw	 $s0, -240($sp)

sw	 $s0, -1904($sp)
# * ASSIGN            (ILocal -236)                       (ILocal -1900)    
lw	 $s0, -236($sp)

sw	 $s0, -1900($sp)
# * ASSIGN            (ILocal -232)                       (ILocal -1896)    
lw	 $s0, -232($sp)

sw	 $s0, -1896($sp)
# * ASSIGN            (ILocal -228)                       (ILocal -1892)    
lw	 $s0, -228($sp)

sw	 $s0, -1892($sp)
# * ASSIGN            (ILocal -224)                       (ILocal -1888)    
lw	 $s0, -224($sp)

sw	 $s0, -1888($sp)
# * ASSIGN            (ILocal -220)                       (ILocal -1884)    
lw	 $s0, -220($sp)

sw	 $s0, -1884($sp)
# * ASSIGN            (ILocal -216)                       (ILocal -1880)    
lw	 $s0, -216($sp)

sw	 $s0, -1880($sp)
# * ASSIGN            (ILocal -212)                       (ILocal -1876)    
lw	 $s0, -212($sp)

sw	 $s0, -1876($sp)
# * ASSIGN            (ILocal -208)                       (ILocal -1872)    
lw	 $s0, -208($sp)

sw	 $s0, -1872($sp)
# * ASSIGN            (ILocal -204)                       (ILocal -1868)    
lw	 $s0, -204($sp)

sw	 $s0, -1868($sp)
# * ASSIGN            (ILocal -200)                       (ILocal -1864)    
lw	 $s0, -200($sp)

sw	 $s0, -1864($sp)
# * ASSIGN            (ILocal -196)                       (ILocal -1860)    
lw	 $s0, -196($sp)

sw	 $s0, -1860($sp)
# * ASSIGN            (ILocal -192)                       (ILocal -1856)    
lw	 $s0, -192($sp)

sw	 $s0, -1856($sp)
# * ASSIGN            (ILocal -188)                       (ILocal -1852)    
lw	 $s0, -188($sp)

sw	 $s0, -1852($sp)
# * ASSIGN            (ILocal -184)                       (ILocal -1848)    
lw	 $s0, -184($sp)

sw	 $s0, -1848($sp)
# * ASSIGN            (ILocal -180)                       (ILocal -1844)    
lw	 $s0, -180($sp)

sw	 $s0, -1844($sp)
# * ASSIGN            (ILocal -176)                       (ILocal -1840)    
lw	 $s0, -176($sp)

sw	 $s0, -1840($sp)
# * ASSIGN            (ILocal -172)                       (ILocal -1836)    
lw	 $s0, -172($sp)

sw	 $s0, -1836($sp)
# * ASSIGN            (ILocal -168)                       (ILocal -1832)    
lw	 $s0, -168($sp)

sw	 $s0, -1832($sp)
# * ASSIGN            (ILocal -164)                       (ILocal -1828)    
lw	 $s0, -164($sp)

sw	 $s0, -1828($sp)
# * ASSIGN            (ILocal -160)                       (ILocal -1824)    
lw	 $s0, -160($sp)

sw	 $s0, -1824($sp)
# * ASSIGN            (ILocal -156)                       (ILocal -1820)    
lw	 $s0, -156($sp)

sw	 $s0, -1820($sp)
# * ASSIGN            (ILocal -152)                       (ILocal -1816)    
lw	 $s0, -152($sp)

sw	 $s0, -1816($sp)
# * ASSIGN            (ILocal -148)                       (ILocal -1812)    
lw	 $s0, -148($sp)

sw	 $s0, -1812($sp)
# * ASSIGN            (ILocal -144)                       (ILocal -1808)    
lw	 $s0, -144($sp)

sw	 $s0, -1808($sp)
# * ASSIGN            (ILocal -140)                       (ILocal -1804)    
lw	 $s0, -140($sp)

sw	 $s0, -1804($sp)
# * ASSIGN            (ILocal -136)                       (ILocal -1800)    
lw	 $s0, -136($sp)

sw	 $s0, -1800($sp)
# * ASSIGN            (ILocal -132)                       (ILocal -1796)    
lw	 $s0, -132($sp)

sw	 $s0, -1796($sp)
# * ASSIGN            (ILocal -128)                       (ILocal -1792)    
lw	 $s0, -128($sp)

sw	 $s0, -1792($sp)
# * ASSIGN            (ILocal -124)                       (ILocal -1788)    
lw	 $s0, -124($sp)

sw	 $s0, -1788($sp)
# * ASSIGN            (ILocal -120)                       (ILocal -1784)    
lw	 $s0, -120($sp)

sw	 $s0, -1784($sp)
# * ASSIGN            (ILocal -116)                       (ILocal -1780)    
lw	 $s0, -116($sp)

sw	 $s0, -1780($sp)
# * ASSIGN            (ILocal -112)                       (ILocal -1776)    
lw	 $s0, -112($sp)

sw	 $s0, -1776($sp)
# * ASSIGN            (ILocal -108)                       (ILocal -1772)    
lw	 $s0, -108($sp)

sw	 $s0, -1772($sp)
# * ASSIGN            (ILocal -104)                       (ILocal -1768)    
lw	 $s0, -104($sp)

sw	 $s0, -1768($sp)
# * ASSIGN            (ILocal -100)                       (ILocal -1764)    
lw	 $s0, -100($sp)

sw	 $s0, -1764($sp)
# * ASSIGN            (ILocal -96)                        (ILocal -1760)    
lw	 $s0, -96($sp)

sw	 $s0, -1760($sp)
# * ASSIGN            (ILocal -92)                        (ILocal -1756)    
lw	 $s0, -92($sp)

sw	 $s0, -1756($sp)
# * ASSIGN            (ILocal -88)                        (ILocal -1752)    
lw	 $s0, -88($sp)

sw	 $s0, -1752($sp)
# * ASSIGN            (ILocal -84)                        (ILocal -1748)    
lw	 $s0, -84($sp)

sw	 $s0, -1748($sp)
# * ASSIGN            (ILocal -80)                        (ILocal -1744)    
lw	 $s0, -80($sp)

sw	 $s0, -1744($sp)
# * ASSIGN            (ILocal -76)                        (ILocal -1740)    
lw	 $s0, -76($sp)

sw	 $s0, -1740($sp)
# * ASSIGN            (ILocal -72)                        (ILocal -1736)    
lw	 $s0, -72($sp)

sw	 $s0, -1736($sp)
# * ASSIGN            (ILocal -68)                        (ILocal -1732)    
lw	 $s0, -68($sp)

sw	 $s0, -1732($sp)
# * ASSIGN            (ILocal -64)                        (ILocal -1728)    
lw	 $s0, -64($sp)

sw	 $s0, -1728($sp)
# * ASSIGN            (ILocal -60)                        (ILocal -1724)    
lw	 $s0, -60($sp)

sw	 $s0, -1724($sp)
# * ASSIGN            (ILocal -56)                        (ILocal -1720)    
lw	 $s0, -56($sp)

sw	 $s0, -1720($sp)
# * ASSIGN            (ILocal -52)                        (ILocal -1716)    
lw	 $s0, -52($sp)

sw	 $s0, -1716($sp)
# * ASSIGN            (ILocal -48)                        (ILocal -1712)    
lw	 $s0, -48($sp)

sw	 $s0, -1712($sp)
# * ASSIGN            (ILocal -44)                        (ILocal -1708)    
lw	 $s0, -44($sp)

sw	 $s0, -1708($sp)
# * ASSIGN            (ILocal -40)                        (ILocal -1704)    
lw	 $s0, -40($sp)

sw	 $s0, -1704($sp)
# * ASSIGN            (ILocal -36)                        (ILocal -1700)    
lw	 $s0, -36($sp)

sw	 $s0, -1700($sp)
# * ASSIGN            (ILocal -32)                        (ILocal -1696)    
lw	 $s0, -32($sp)

sw	 $s0, -1696($sp)
# * ASSIGN            (ILocal -28)                        (ILocal -1692)    
lw	 $s0, -28($sp)

sw	 $s0, -1692($sp)
# * ASSIGN            (ILocal -24)                        (ILocal -1688)    
lw	 $s0, -24($sp)

sw	 $s0, -1688($sp)
# * ASSIGN            (ILocal -20)                        (ILocal -1684)    
lw	 $s0, -20($sp)

sw	 $s0, -1684($sp)
# * ASSIGN            (ILocal -16)                        (ILocal -1680)    
lw	 $s0, -16($sp)

sw	 $s0, -1680($sp)
# * ASSIGN            (ILocal -12)                        (ILocal -1676)    
lw	 $s0, -12($sp)

sw	 $s0, -1676($sp)
# * ASSIGN            (ILocal -8)                         (ILocal -1672)    
lw	 $s0, -8($sp)

sw	 $s0, -1672($sp)
# * ASSIGN            (ILocal -4)                         (ILocal -1668)    
lw	 $s0, -4($sp)

sw	 $s0, -1668($sp)
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
# * PROCENTRY         (ICONS 2064)      (ICONS 408)                         
subi	$sp, $sp, 2064
sw	$ra, 1652($sp)
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
# * ASSIGN            (ILocal -4)                         (ILocal 1648)     
lw	 $s0, -4($sp)

sw	 $s0, 1648($sp)
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
# * ASSIGN            (ILocal -4)                         (ILocal 1244)     
lw	 $s0, -4($sp)

sw	 $s0, 1244($sp)
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
# * ASSIGN            (ICONS 1)                           (ILocal 1240)     
li	 $t0, 1

sw	 $t0, 1240($sp)
# * LABEL             (LABEL LL00000)                                       
LL00000:
# * MULT              (ILocal 1648)     (ILocal 1244)     (ITemp 0)         
lw	 $s0, 1648($sp)
lw	 $s1, 1244($sp)
mul	 $t0, $s0, $s1
# * LT                (ILocal 1240)     (ITemp 0)         (ITemp 1)         
lw	 $s2, 1240($sp)
slt	 $t0, $s2, $t0
# * BREQ              (ITemp 1)         (ICONS 0)         (LABEL LL00001)   
li	 $t1, 0
beq	 $t0, $t1, LL00001
# * MULT              (ILocal 1240)     (ICONS 10)        (ILocal 1240)     
li	 $t0, 10
mul	 $s2, $s2, $t0
sw	 $s2, 1240($sp)
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
# * GT                (ILocal 1240)     (ICONS 1)         (ITemp 2)         
lw	 $s0, 1240($sp)
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
# * MULT              (ILocal 1648)     (ILocal 1244)     (ITemp 3)         
lw	 $s1, 1648($sp)
lw	 $s2, 1244($sp)
mul	 $t0, $s1, $s2
# * MOD               (ITemp 3)         (ILocal 1240)     (ITemp 4)         
rem	 $t0, $t0, $s0
# * DIV               (ILocal 1240)     (ICONS 10)        (ITemp 5)         
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
sw	 $s0, 1240($sp)
sw	 $s1, 1648($sp)
sw	 $s2, 1244($sp)
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
# * DIV               (ILocal 1240)     (ICONS 10)        (ILocal 1240)     
lw	 $s0, 1240($sp)
li	 $t0, 10
div	 $s0, $s0, $t0
sw	 $s0, 1240($sp)
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
# * ASSIGN            (ICONS 0)                           (ILocal 1232)     
li	 $t0, 0

sw	 $t0, 1232($sp)
# * LABEL             (LABEL LL00004)                                       
LL00004:
# * LT                (ILocal 1232)     (ILocal 1648)     (ITemp 8)         
lw	 $s0, 1232($sp)
lw	 $s1, 1648($sp)
slt	 $t0, $s0, $s1
# * LT                (ILocal 1232)     (ICONS 10)        (ITemp 9)         
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
# * ASSIGN            (ICONS 0)                           (ILocal 1236)     
li	 $t0, 0

sw	 $t0, 1236($sp)
# * LABEL             (LABEL LL00006)                                       
LL00006:
# * LT                (ILocal 1236)     (ILocal 1244)     (ITemp 11)        
lw	 $s0, 1236($sp)
lw	 $s1, 1244($sp)
slt	 $t0, $s0, $s1
# * LT                (ILocal 1236)     (ICONS 10)        (ITemp 12)        
li	 $t1, 10
slt	 $t1, $s0, $t1
# * LAND              (ITemp 11)        (ITemp 12)        (ITemp 13)        
and	 $t0, $t0, $t1
# * BREQ              (ITemp 13)        (ICONS 0)         (LABEL LL00007)   
li	 $t1, 0
beq	 $t0, $t1, LL00007
# * CALL                                                  (LABEL readInt1)  
sw	 $s0, 1236($sp)
sw	 $s1, 1244($sp)
jal	 readInt1
# * MULT              (ILocal 1232)     (ICONS 40)        (ITemp 14)        
lw	 $s0, 1232($sp)
li	 $t0, 40
mul	 $t0, $s0, $t0
# * MULT              (ILocal 1236)     (ICONS 4)         (ITemp 15)        
lw	 $s1, 1236($sp)
li	 $t1, 4
mul	 $t1, $s1, $t1
# * ADD               (ITemp 14)        (ITemp 15)        (ITemp 16)        
add	 $t0, $t0, $t1
# * ADD               (ICONS 1248)      (ITemp 16)        (ITemp 17)        
li	 $t1, 1248
add	 $t0, $t1, $t0
# * OFFSET            (ITemp 17)                                            
add	 $t0, $t0, $sp
# * ASSIGN            (ILocal -4)                         (IINDR 17)        
lw	 $s2, -4($sp)
move	 $t1, $s2
sw	 $t1, ($t0)
# * ADD               (ILocal 1236)     (ICONS 1)         (ILocal 1236)     
li	 $t0, 1
add	 $s1, $s1, $t0
sw	 $s1, 1236($sp)
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
# * ADD               (ILocal 1232)     (ICONS 1)         (ILocal 1232)     
lw	 $s0, 1232($sp)
li	 $t0, 1
add	 $s0, $s0, $t0
sw	 $s0, 1232($sp)
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
# * ASSIGN            (ILocal 1244)                       (ILocal 1656)     
lw	 $s0, 1244($sp)

sw	 $s0, 1656($sp)
# * ASSIGN            (ILocal 1248)                       (ILocal 1660)     
lw	 $s0, 1248($sp)

sw	 $s0, 1660($sp)
# * ASSIGN            (ILocal 1252)                       (ILocal 1664)     
lw	 $s0, 1252($sp)

sw	 $s0, 1664($sp)
# * ASSIGN            (ILocal 1256)                       (ILocal 1668)     
lw	 $s0, 1256($sp)

sw	 $s0, 1668($sp)
# * ASSIGN            (ILocal 1260)                       (ILocal 1672)     
lw	 $s0, 1260($sp)

sw	 $s0, 1672($sp)
# * ASSIGN            (ILocal 1264)                       (ILocal 1676)     
lw	 $s0, 1264($sp)

sw	 $s0, 1676($sp)
# * ASSIGN            (ILocal 1268)                       (ILocal 1680)     
lw	 $s0, 1268($sp)

sw	 $s0, 1680($sp)
# * ASSIGN            (ILocal 1272)                       (ILocal 1684)     
lw	 $s0, 1272($sp)

sw	 $s0, 1684($sp)
# * ASSIGN            (ILocal 1276)                       (ILocal 1688)     
lw	 $s0, 1276($sp)

sw	 $s0, 1688($sp)
# * ASSIGN            (ILocal 1280)                       (ILocal 1692)     
lw	 $s0, 1280($sp)

sw	 $s0, 1692($sp)
# * ASSIGN            (ILocal 1284)                       (ILocal 1696)     
lw	 $s0, 1284($sp)

sw	 $s0, 1696($sp)
# * ASSIGN            (ILocal 1288)                       (ILocal 1700)     
lw	 $s0, 1288($sp)

sw	 $s0, 1700($sp)
# * ASSIGN            (ILocal 1292)                       (ILocal 1704)     
lw	 $s0, 1292($sp)

sw	 $s0, 1704($sp)
# * ASSIGN            (ILocal 1296)                       (ILocal 1708)     
lw	 $s0, 1296($sp)

sw	 $s0, 1708($sp)
# * ASSIGN            (ILocal 1300)                       (ILocal 1712)     
lw	 $s0, 1300($sp)

sw	 $s0, 1712($sp)
# * ASSIGN            (ILocal 1304)                       (ILocal 1716)     
lw	 $s0, 1304($sp)

sw	 $s0, 1716($sp)
# * ASSIGN            (ILocal 1308)                       (ILocal 1720)     
lw	 $s0, 1308($sp)

sw	 $s0, 1720($sp)
# * ASSIGN            (ILocal 1312)                       (ILocal 1724)     
lw	 $s0, 1312($sp)

sw	 $s0, 1724($sp)
# * ASSIGN            (ILocal 1316)                       (ILocal 1728)     
lw	 $s0, 1316($sp)

sw	 $s0, 1728($sp)
# * ASSIGN            (ILocal 1320)                       (ILocal 1732)     
lw	 $s0, 1320($sp)

sw	 $s0, 1732($sp)
# * ASSIGN            (ILocal 1324)                       (ILocal 1736)     
lw	 $s0, 1324($sp)

sw	 $s0, 1736($sp)
# * ASSIGN            (ILocal 1328)                       (ILocal 1740)     
lw	 $s0, 1328($sp)

sw	 $s0, 1740($sp)
# * ASSIGN            (ILocal 1332)                       (ILocal 1744)     
lw	 $s0, 1332($sp)

sw	 $s0, 1744($sp)
# * ASSIGN            (ILocal 1336)                       (ILocal 1748)     
lw	 $s0, 1336($sp)

sw	 $s0, 1748($sp)
# * ASSIGN            (ILocal 1340)                       (ILocal 1752)     
lw	 $s0, 1340($sp)

sw	 $s0, 1752($sp)
# * ASSIGN            (ILocal 1344)                       (ILocal 1756)     
lw	 $s0, 1344($sp)

sw	 $s0, 1756($sp)
# * ASSIGN            (ILocal 1348)                       (ILocal 1760)     
lw	 $s0, 1348($sp)

sw	 $s0, 1760($sp)
# * ASSIGN            (ILocal 1352)                       (ILocal 1764)     
lw	 $s0, 1352($sp)

sw	 $s0, 1764($sp)
# * ASSIGN            (ILocal 1356)                       (ILocal 1768)     
lw	 $s0, 1356($sp)

sw	 $s0, 1768($sp)
# * ASSIGN            (ILocal 1360)                       (ILocal 1772)     
lw	 $s0, 1360($sp)

sw	 $s0, 1772($sp)
# * ASSIGN            (ILocal 1364)                       (ILocal 1776)     
lw	 $s0, 1364($sp)

sw	 $s0, 1776($sp)
# * ASSIGN            (ILocal 1368)                       (ILocal 1780)     
lw	 $s0, 1368($sp)

sw	 $s0, 1780($sp)
# * ASSIGN            (ILocal 1372)                       (ILocal 1784)     
lw	 $s0, 1372($sp)

sw	 $s0, 1784($sp)
# * ASSIGN            (ILocal 1376)                       (ILocal 1788)     
lw	 $s0, 1376($sp)

sw	 $s0, 1788($sp)
# * ASSIGN            (ILocal 1380)                       (ILocal 1792)     
lw	 $s0, 1380($sp)

sw	 $s0, 1792($sp)
# * ASSIGN            (ILocal 1384)                       (ILocal 1796)     
lw	 $s0, 1384($sp)

sw	 $s0, 1796($sp)
# * ASSIGN            (ILocal 1388)                       (ILocal 1800)     
lw	 $s0, 1388($sp)

sw	 $s0, 1800($sp)
# * ASSIGN            (ILocal 1392)                       (ILocal 1804)     
lw	 $s0, 1392($sp)

sw	 $s0, 1804($sp)
# * ASSIGN            (ILocal 1396)                       (ILocal 1808)     
lw	 $s0, 1396($sp)

sw	 $s0, 1808($sp)
# * ASSIGN            (ILocal 1400)                       (ILocal 1812)     
lw	 $s0, 1400($sp)

sw	 $s0, 1812($sp)
# * ASSIGN            (ILocal 1404)                       (ILocal 1816)     
lw	 $s0, 1404($sp)

sw	 $s0, 1816($sp)
# * ASSIGN            (ILocal 1408)                       (ILocal 1820)     
lw	 $s0, 1408($sp)

sw	 $s0, 1820($sp)
# * ASSIGN            (ILocal 1412)                       (ILocal 1824)     
lw	 $s0, 1412($sp)

sw	 $s0, 1824($sp)
# * ASSIGN            (ILocal 1416)                       (ILocal 1828)     
lw	 $s0, 1416($sp)

sw	 $s0, 1828($sp)
# * ASSIGN            (ILocal 1420)                       (ILocal 1832)     
lw	 $s0, 1420($sp)

sw	 $s0, 1832($sp)
# * ASSIGN            (ILocal 1424)                       (ILocal 1836)     
lw	 $s0, 1424($sp)

sw	 $s0, 1836($sp)
# * ASSIGN            (ILocal 1428)                       (ILocal 1840)     
lw	 $s0, 1428($sp)

sw	 $s0, 1840($sp)
# * ASSIGN            (ILocal 1432)                       (ILocal 1844)     
lw	 $s0, 1432($sp)

sw	 $s0, 1844($sp)
# * ASSIGN            (ILocal 1436)                       (ILocal 1848)     
lw	 $s0, 1436($sp)

sw	 $s0, 1848($sp)
# * ASSIGN            (ILocal 1440)                       (ILocal 1852)     
lw	 $s0, 1440($sp)

sw	 $s0, 1852($sp)
# * ASSIGN            (ILocal 1444)                       (ILocal 1856)     
lw	 $s0, 1444($sp)

sw	 $s0, 1856($sp)
# * ASSIGN            (ILocal 1448)                       (ILocal 1860)     
lw	 $s0, 1448($sp)

sw	 $s0, 1860($sp)
# * ASSIGN            (ILocal 1452)                       (ILocal 1864)     
lw	 $s0, 1452($sp)

sw	 $s0, 1864($sp)
# * ASSIGN            (ILocal 1456)                       (ILocal 1868)     
lw	 $s0, 1456($sp)

sw	 $s0, 1868($sp)
# * ASSIGN            (ILocal 1460)                       (ILocal 1872)     
lw	 $s0, 1460($sp)

sw	 $s0, 1872($sp)
# * ASSIGN            (ILocal 1464)                       (ILocal 1876)     
lw	 $s0, 1464($sp)

sw	 $s0, 1876($sp)
# * ASSIGN            (ILocal 1468)                       (ILocal 1880)     
lw	 $s0, 1468($sp)

sw	 $s0, 1880($sp)
# * ASSIGN            (ILocal 1472)                       (ILocal 1884)     
lw	 $s0, 1472($sp)

sw	 $s0, 1884($sp)
# * ASSIGN            (ILocal 1476)                       (ILocal 1888)     
lw	 $s0, 1476($sp)

sw	 $s0, 1888($sp)
# * ASSIGN            (ILocal 1480)                       (ILocal 1892)     
lw	 $s0, 1480($sp)

sw	 $s0, 1892($sp)
# * ASSIGN            (ILocal 1484)                       (ILocal 1896)     
lw	 $s0, 1484($sp)

sw	 $s0, 1896($sp)
# * ASSIGN            (ILocal 1488)                       (ILocal 1900)     
lw	 $s0, 1488($sp)

sw	 $s0, 1900($sp)
# * ASSIGN            (ILocal 1492)                       (ILocal 1904)     
lw	 $s0, 1492($sp)

sw	 $s0, 1904($sp)
# * ASSIGN            (ILocal 1496)                       (ILocal 1908)     
lw	 $s0, 1496($sp)

sw	 $s0, 1908($sp)
# * ASSIGN            (ILocal 1500)                       (ILocal 1912)     
lw	 $s0, 1500($sp)

sw	 $s0, 1912($sp)
# * ASSIGN            (ILocal 1504)                       (ILocal 1916)     
lw	 $s0, 1504($sp)

sw	 $s0, 1916($sp)
# * ASSIGN            (ILocal 1508)                       (ILocal 1920)     
lw	 $s0, 1508($sp)

sw	 $s0, 1920($sp)
# * ASSIGN            (ILocal 1512)                       (ILocal 1924)     
lw	 $s0, 1512($sp)

sw	 $s0, 1924($sp)
# * ASSIGN            (ILocal 1516)                       (ILocal 1928)     
lw	 $s0, 1516($sp)

sw	 $s0, 1928($sp)
# * ASSIGN            (ILocal 1520)                       (ILocal 1932)     
lw	 $s0, 1520($sp)

sw	 $s0, 1932($sp)
# * ASSIGN            (ILocal 1524)                       (ILocal 1936)     
lw	 $s0, 1524($sp)

sw	 $s0, 1936($sp)
# * ASSIGN            (ILocal 1528)                       (ILocal 1940)     
lw	 $s0, 1528($sp)

sw	 $s0, 1940($sp)
# * ASSIGN            (ILocal 1532)                       (ILocal 1944)     
lw	 $s0, 1532($sp)

sw	 $s0, 1944($sp)
# * ASSIGN            (ILocal 1536)                       (ILocal 1948)     
lw	 $s0, 1536($sp)

sw	 $s0, 1948($sp)
# * ASSIGN            (ILocal 1540)                       (ILocal 1952)     
lw	 $s0, 1540($sp)

sw	 $s0, 1952($sp)
# * ASSIGN            (ILocal 1544)                       (ILocal 1956)     
lw	 $s0, 1544($sp)

sw	 $s0, 1956($sp)
# * ASSIGN            (ILocal 1548)                       (ILocal 1960)     
lw	 $s0, 1548($sp)

sw	 $s0, 1960($sp)
# * ASSIGN            (ILocal 1552)                       (ILocal 1964)     
lw	 $s0, 1552($sp)

sw	 $s0, 1964($sp)
# * ASSIGN            (ILocal 1556)                       (ILocal 1968)     
lw	 $s0, 1556($sp)

sw	 $s0, 1968($sp)
# * ASSIGN            (ILocal 1560)                       (ILocal 1972)     
lw	 $s0, 1560($sp)

sw	 $s0, 1972($sp)
# * ASSIGN            (ILocal 1564)                       (ILocal 1976)     
lw	 $s0, 1564($sp)

sw	 $s0, 1976($sp)
# * ASSIGN            (ILocal 1568)                       (ILocal 1980)     
lw	 $s0, 1568($sp)

sw	 $s0, 1980($sp)
# * ASSIGN            (ILocal 1572)                       (ILocal 1984)     
lw	 $s0, 1572($sp)

sw	 $s0, 1984($sp)
# * ASSIGN            (ILocal 1576)                       (ILocal 1988)     
lw	 $s0, 1576($sp)

sw	 $s0, 1988($sp)
# * ASSIGN            (ILocal 1580)                       (ILocal 1992)     
lw	 $s0, 1580($sp)

sw	 $s0, 1992($sp)
# * ASSIGN            (ILocal 1584)                       (ILocal 1996)     
lw	 $s0, 1584($sp)

sw	 $s0, 1996($sp)
# * ASSIGN            (ILocal 1588)                       (ILocal 2000)     
lw	 $s0, 1588($sp)

sw	 $s0, 2000($sp)
# * ASSIGN            (ILocal 1592)                       (ILocal 2004)     
lw	 $s0, 1592($sp)

sw	 $s0, 2004($sp)
# * ASSIGN            (ILocal 1596)                       (ILocal 2008)     
lw	 $s0, 1596($sp)

sw	 $s0, 2008($sp)
# * ASSIGN            (ILocal 1600)                       (ILocal 2012)     
lw	 $s0, 1600($sp)

sw	 $s0, 2012($sp)
# * ASSIGN            (ILocal 1604)                       (ILocal 2016)     
lw	 $s0, 1604($sp)

sw	 $s0, 2016($sp)
# * ASSIGN            (ILocal 1608)                       (ILocal 2020)     
lw	 $s0, 1608($sp)

sw	 $s0, 2020($sp)
# * ASSIGN            (ILocal 1612)                       (ILocal 2024)     
lw	 $s0, 1612($sp)

sw	 $s0, 2024($sp)
# * ASSIGN            (ILocal 1616)                       (ILocal 2028)     
lw	 $s0, 1616($sp)

sw	 $s0, 2028($sp)
# * ASSIGN            (ILocal 1620)                       (ILocal 2032)     
lw	 $s0, 1620($sp)

sw	 $s0, 2032($sp)
# * ASSIGN            (ILocal 1624)                       (ILocal 2036)     
lw	 $s0, 1624($sp)

sw	 $s0, 2036($sp)
# * ASSIGN            (ILocal 1628)                       (ILocal 2040)     
lw	 $s0, 1628($sp)

sw	 $s0, 2040($sp)
# * ASSIGN            (ILocal 1632)                       (ILocal 2044)     
lw	 $s0, 1632($sp)

sw	 $s0, 2044($sp)
# * ASSIGN            (ILocal 1636)                       (ILocal 2048)     
lw	 $s0, 1636($sp)

sw	 $s0, 2048($sp)
# * ASSIGN            (ILocal 1640)                       (ILocal 2052)     
lw	 $s0, 1640($sp)

sw	 $s0, 2052($sp)
# * ASSIGN            (ILocal 1644)                       (ILocal 2056)     
lw	 $s0, 1644($sp)

sw	 $s0, 2056($sp)
# * ASSIGN            (ILocal 1648)                       (ILocal 2060)     
lw	 $s0, 1648($sp)

sw	 $s0, 2060($sp)
# * RETURN            (ICONS 1652)      (ICONS 2064)                        
lw	 $ra, 1652($sp)
add	 $sp, $sp, 2064
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
# * RETURN            (ICONS 1652)      (ICONS 2064)                        
lw	 $ra, 1652($sp)
add	 $sp, $sp, 2064
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
# * PROCENTRY         (ICONS 2072)      (ICONS 0)                           
subi	$sp, $sp, 2072
sw	$ra, 2068($sp)
# ----------------------------
# | Original source          |
# ----------------------------
# * 	for (i = 0; i < m.rows && i < 10; i++) {
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ASSIGN            (ICONS 0)                           (ILocal 2060)     
li	 $t0, 0

sw	 $t0, 2060($sp)
# * LABEL             (LABEL LL00008)                                       
LL00008:
# * LT                (ILocal 2060)     (ILocal 404)      (ITemp 18)        
lw	 $s0, 2060($sp)
lw	 $s1, 404($sp)
slt	 $t0, $s0, $s1
# * LT                (ILocal 2060)     (ICONS 10)        (ITemp 19)        
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
# * ASSIGN            (ICONS 0)                           (ILocal 2064)     
li	 $t0, 0

sw	 $t0, 2064($sp)
# * LABEL             (LABEL LL00010)                                       
LL00010:
# * LT                (ILocal 2064)     (ILocal 0)        (ITemp 21)        
lw	 $s0, 2064($sp)
lw	 $s1, 0($sp)
slt	 $t0, $s0, $s1
# * LT                (ILocal 2064)     (ICONS 10)        (ITemp 22)        
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
# * MULT              (ILocal 2060)     (ICONS 40)        (ITemp 24)        
lw	 $s2, 2060($sp)
li	 $t0, 40
mul	 $t0, $s2, $t0
# * MULT              (ILocal 2064)     (ICONS 4)         (ITemp 25)        
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
sw	 $s0, 2064($sp)
sw	 $s1, 0($sp)
sw	 $s2, 2060($sp)
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
# * ADD               (ILocal 2064)     (ICONS 1)         (ILocal 2064)     
lw	 $s0, 2064($sp)
li	 $t0, 1
add	 $s0, $s0, $t0
sw	 $s0, 2064($sp)
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
# * ADD               (ILocal 2060)     (ICONS 1)         (ILocal 2060)     
lw	 $s0, 2060($sp)
li	 $t0, 1
add	 $s0, $s0, $t0
sw	 $s0, 2060($sp)
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
# * RETURN            (ICONS 2068)      (ICONS 2072)                        
lw	 $ra, 2068($sp)
add	 $sp, $sp, 2072
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
# * PROCENTRY         (ICONS 3716)      (ICONS 408)                         
subi	$sp, $sp, 3716
sw	$ra, 3304($sp)
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
# * ASSIGN            (ILocal 2896)                       (ILocal 3308)     
lw	 $s0, 2896($sp)

sw	 $s0, 3308($sp)
# * ASSIGN            (ILocal 2900)                       (ILocal 3312)     
lw	 $s0, 2900($sp)

sw	 $s0, 3312($sp)
# * ASSIGN            (ILocal 2904)                       (ILocal 3316)     
lw	 $s0, 2904($sp)

sw	 $s0, 3316($sp)
# * ASSIGN            (ILocal 2908)                       (ILocal 3320)     
lw	 $s0, 2908($sp)

sw	 $s0, 3320($sp)
# * ASSIGN            (ILocal 2912)                       (ILocal 3324)     
lw	 $s0, 2912($sp)

sw	 $s0, 3324($sp)
# * ASSIGN            (ILocal 2916)                       (ILocal 3328)     
lw	 $s0, 2916($sp)

sw	 $s0, 3328($sp)
# * ASSIGN            (ILocal 2920)                       (ILocal 3332)     
lw	 $s0, 2920($sp)

sw	 $s0, 3332($sp)
# * ASSIGN            (ILocal 2924)                       (ILocal 3336)     
lw	 $s0, 2924($sp)

sw	 $s0, 3336($sp)
# * ASSIGN            (ILocal 2928)                       (ILocal 3340)     
lw	 $s0, 2928($sp)

sw	 $s0, 3340($sp)
# * ASSIGN            (ILocal 2932)                       (ILocal 3344)     
lw	 $s0, 2932($sp)

sw	 $s0, 3344($sp)
# * ASSIGN            (ILocal 2936)                       (ILocal 3348)     
lw	 $s0, 2936($sp)

sw	 $s0, 3348($sp)
# * ASSIGN            (ILocal 2940)                       (ILocal 3352)     
lw	 $s0, 2940($sp)

sw	 $s0, 3352($sp)
# * ASSIGN            (ILocal 2944)                       (ILocal 3356)     
lw	 $s0, 2944($sp)

sw	 $s0, 3356($sp)
# * ASSIGN            (ILocal 2948)                       (ILocal 3360)     
lw	 $s0, 2948($sp)

sw	 $s0, 3360($sp)
# * ASSIGN            (ILocal 2952)                       (ILocal 3364)     
lw	 $s0, 2952($sp)

sw	 $s0, 3364($sp)
# * ASSIGN            (ILocal 2956)                       (ILocal 3368)     
lw	 $s0, 2956($sp)

sw	 $s0, 3368($sp)
# * ASSIGN            (ILocal 2960)                       (ILocal 3372)     
lw	 $s0, 2960($sp)

sw	 $s0, 3372($sp)
# * ASSIGN            (ILocal 2964)                       (ILocal 3376)     
lw	 $s0, 2964($sp)

sw	 $s0, 3376($sp)
# * ASSIGN            (ILocal 2968)                       (ILocal 3380)     
lw	 $s0, 2968($sp)

sw	 $s0, 3380($sp)
# * ASSIGN            (ILocal 2972)                       (ILocal 3384)     
lw	 $s0, 2972($sp)

sw	 $s0, 3384($sp)
# * ASSIGN            (ILocal 2976)                       (ILocal 3388)     
lw	 $s0, 2976($sp)

sw	 $s0, 3388($sp)
# * ASSIGN            (ILocal 2980)                       (ILocal 3392)     
lw	 $s0, 2980($sp)

sw	 $s0, 3392($sp)
# * ASSIGN            (ILocal 2984)                       (ILocal 3396)     
lw	 $s0, 2984($sp)

sw	 $s0, 3396($sp)
# * ASSIGN            (ILocal 2988)                       (ILocal 3400)     
lw	 $s0, 2988($sp)

sw	 $s0, 3400($sp)
# * ASSIGN            (ILocal 2992)                       (ILocal 3404)     
lw	 $s0, 2992($sp)

sw	 $s0, 3404($sp)
# * ASSIGN            (ILocal 2996)                       (ILocal 3408)     
lw	 $s0, 2996($sp)

sw	 $s0, 3408($sp)
# * ASSIGN            (ILocal 3000)                       (ILocal 3412)     
lw	 $s0, 3000($sp)

sw	 $s0, 3412($sp)
# * ASSIGN            (ILocal 3004)                       (ILocal 3416)     
lw	 $s0, 3004($sp)

sw	 $s0, 3416($sp)
# * ASSIGN            (ILocal 3008)                       (ILocal 3420)     
lw	 $s0, 3008($sp)

sw	 $s0, 3420($sp)
# * ASSIGN            (ILocal 3012)                       (ILocal 3424)     
lw	 $s0, 3012($sp)

sw	 $s0, 3424($sp)
# * ASSIGN            (ILocal 3016)                       (ILocal 3428)     
lw	 $s0, 3016($sp)

sw	 $s0, 3428($sp)
# * ASSIGN            (ILocal 3020)                       (ILocal 3432)     
lw	 $s0, 3020($sp)

sw	 $s0, 3432($sp)
# * ASSIGN            (ILocal 3024)                       (ILocal 3436)     
lw	 $s0, 3024($sp)

sw	 $s0, 3436($sp)
# * ASSIGN            (ILocal 3028)                       (ILocal 3440)     
lw	 $s0, 3028($sp)

sw	 $s0, 3440($sp)
# * ASSIGN            (ILocal 3032)                       (ILocal 3444)     
lw	 $s0, 3032($sp)

sw	 $s0, 3444($sp)
# * ASSIGN            (ILocal 3036)                       (ILocal 3448)     
lw	 $s0, 3036($sp)

sw	 $s0, 3448($sp)
# * ASSIGN            (ILocal 3040)                       (ILocal 3452)     
lw	 $s0, 3040($sp)

sw	 $s0, 3452($sp)
# * ASSIGN            (ILocal 3044)                       (ILocal 3456)     
lw	 $s0, 3044($sp)

sw	 $s0, 3456($sp)
# * ASSIGN            (ILocal 3048)                       (ILocal 3460)     
lw	 $s0, 3048($sp)

sw	 $s0, 3460($sp)
# * ASSIGN            (ILocal 3052)                       (ILocal 3464)     
lw	 $s0, 3052($sp)

sw	 $s0, 3464($sp)
# * ASSIGN            (ILocal 3056)                       (ILocal 3468)     
lw	 $s0, 3056($sp)

sw	 $s0, 3468($sp)
# * ASSIGN            (ILocal 3060)                       (ILocal 3472)     
lw	 $s0, 3060($sp)

sw	 $s0, 3472($sp)
# * ASSIGN            (ILocal 3064)                       (ILocal 3476)     
lw	 $s0, 3064($sp)

sw	 $s0, 3476($sp)
# * ASSIGN            (ILocal 3068)                       (ILocal 3480)     
lw	 $s0, 3068($sp)

sw	 $s0, 3480($sp)
# * ASSIGN            (ILocal 3072)                       (ILocal 3484)     
lw	 $s0, 3072($sp)

sw	 $s0, 3484($sp)
# * ASSIGN            (ILocal 3076)                       (ILocal 3488)     
lw	 $s0, 3076($sp)

sw	 $s0, 3488($sp)
# * ASSIGN            (ILocal 3080)                       (ILocal 3492)     
lw	 $s0, 3080($sp)

sw	 $s0, 3492($sp)
# * ASSIGN            (ILocal 3084)                       (ILocal 3496)     
lw	 $s0, 3084($sp)

sw	 $s0, 3496($sp)
# * ASSIGN            (ILocal 3088)                       (ILocal 3500)     
lw	 $s0, 3088($sp)

sw	 $s0, 3500($sp)
# * ASSIGN            (ILocal 3092)                       (ILocal 3504)     
lw	 $s0, 3092($sp)

sw	 $s0, 3504($sp)
# * ASSIGN            (ILocal 3096)                       (ILocal 3508)     
lw	 $s0, 3096($sp)

sw	 $s0, 3508($sp)
# * ASSIGN            (ILocal 3100)                       (ILocal 3512)     
lw	 $s0, 3100($sp)

sw	 $s0, 3512($sp)
# * ASSIGN            (ILocal 3104)                       (ILocal 3516)     
lw	 $s0, 3104($sp)

sw	 $s0, 3516($sp)
# * ASSIGN            (ILocal 3108)                       (ILocal 3520)     
lw	 $s0, 3108($sp)

sw	 $s0, 3520($sp)
# * ASSIGN            (ILocal 3112)                       (ILocal 3524)     
lw	 $s0, 3112($sp)

sw	 $s0, 3524($sp)
# * ASSIGN            (ILocal 3116)                       (ILocal 3528)     
lw	 $s0, 3116($sp)

sw	 $s0, 3528($sp)
# * ASSIGN            (ILocal 3120)                       (ILocal 3532)     
lw	 $s0, 3120($sp)

sw	 $s0, 3532($sp)
# * ASSIGN            (ILocal 3124)                       (ILocal 3536)     
lw	 $s0, 3124($sp)

sw	 $s0, 3536($sp)
# * ASSIGN            (ILocal 3128)                       (ILocal 3540)     
lw	 $s0, 3128($sp)

sw	 $s0, 3540($sp)
# * ASSIGN            (ILocal 3132)                       (ILocal 3544)     
lw	 $s0, 3132($sp)

sw	 $s0, 3544($sp)
# * ASSIGN            (ILocal 3136)                       (ILocal 3548)     
lw	 $s0, 3136($sp)

sw	 $s0, 3548($sp)
# * ASSIGN            (ILocal 3140)                       (ILocal 3552)     
lw	 $s0, 3140($sp)

sw	 $s0, 3552($sp)
# * ASSIGN            (ILocal 3144)                       (ILocal 3556)     
lw	 $s0, 3144($sp)

sw	 $s0, 3556($sp)
# * ASSIGN            (ILocal 3148)                       (ILocal 3560)     
lw	 $s0, 3148($sp)

sw	 $s0, 3560($sp)
# * ASSIGN            (ILocal 3152)                       (ILocal 3564)     
lw	 $s0, 3152($sp)

sw	 $s0, 3564($sp)
# * ASSIGN            (ILocal 3156)                       (ILocal 3568)     
lw	 $s0, 3156($sp)

sw	 $s0, 3568($sp)
# * ASSIGN            (ILocal 3160)                       (ILocal 3572)     
lw	 $s0, 3160($sp)

sw	 $s0, 3572($sp)
# * ASSIGN            (ILocal 3164)                       (ILocal 3576)     
lw	 $s0, 3164($sp)

sw	 $s0, 3576($sp)
# * ASSIGN            (ILocal 3168)                       (ILocal 3580)     
lw	 $s0, 3168($sp)

sw	 $s0, 3580($sp)
# * ASSIGN            (ILocal 3172)                       (ILocal 3584)     
lw	 $s0, 3172($sp)

sw	 $s0, 3584($sp)
# * ASSIGN            (ILocal 3176)                       (ILocal 3588)     
lw	 $s0, 3176($sp)

sw	 $s0, 3588($sp)
# * ASSIGN            (ILocal 3180)                       (ILocal 3592)     
lw	 $s0, 3180($sp)

sw	 $s0, 3592($sp)
# * ASSIGN            (ILocal 3184)                       (ILocal 3596)     
lw	 $s0, 3184($sp)

sw	 $s0, 3596($sp)
# * ASSIGN            (ILocal 3188)                       (ILocal 3600)     
lw	 $s0, 3188($sp)

sw	 $s0, 3600($sp)
# * ASSIGN            (ILocal 3192)                       (ILocal 3604)     
lw	 $s0, 3192($sp)

sw	 $s0, 3604($sp)
# * ASSIGN            (ILocal 3196)                       (ILocal 3608)     
lw	 $s0, 3196($sp)

sw	 $s0, 3608($sp)
# * ASSIGN            (ILocal 3200)                       (ILocal 3612)     
lw	 $s0, 3200($sp)

sw	 $s0, 3612($sp)
# * ASSIGN            (ILocal 3204)                       (ILocal 3616)     
lw	 $s0, 3204($sp)

sw	 $s0, 3616($sp)
# * ASSIGN            (ILocal 3208)                       (ILocal 3620)     
lw	 $s0, 3208($sp)

sw	 $s0, 3620($sp)
# * ASSIGN            (ILocal 3212)                       (ILocal 3624)     
lw	 $s0, 3212($sp)

sw	 $s0, 3624($sp)
# * ASSIGN            (ILocal 3216)                       (ILocal 3628)     
lw	 $s0, 3216($sp)

sw	 $s0, 3628($sp)
# * ASSIGN            (ILocal 3220)                       (ILocal 3632)     
lw	 $s0, 3220($sp)

sw	 $s0, 3632($sp)
# * ASSIGN            (ILocal 3224)                       (ILocal 3636)     
lw	 $s0, 3224($sp)

sw	 $s0, 3636($sp)
# * ASSIGN            (ILocal 3228)                       (ILocal 3640)     
lw	 $s0, 3228($sp)

sw	 $s0, 3640($sp)
# * ASSIGN            (ILocal 3232)                       (ILocal 3644)     
lw	 $s0, 3232($sp)

sw	 $s0, 3644($sp)
# * ASSIGN            (ILocal 3236)                       (ILocal 3648)     
lw	 $s0, 3236($sp)

sw	 $s0, 3648($sp)
# * ASSIGN            (ILocal 3240)                       (ILocal 3652)     
lw	 $s0, 3240($sp)

sw	 $s0, 3652($sp)
# * ASSIGN            (ILocal 3244)                       (ILocal 3656)     
lw	 $s0, 3244($sp)

sw	 $s0, 3656($sp)
# * ASSIGN            (ILocal 3248)                       (ILocal 3660)     
lw	 $s0, 3248($sp)

sw	 $s0, 3660($sp)
# * ASSIGN            (ILocal 3252)                       (ILocal 3664)     
lw	 $s0, 3252($sp)

sw	 $s0, 3664($sp)
# * ASSIGN            (ILocal 3256)                       (ILocal 3668)     
lw	 $s0, 3256($sp)

sw	 $s0, 3668($sp)
# * ASSIGN            (ILocal 3260)                       (ILocal 3672)     
lw	 $s0, 3260($sp)

sw	 $s0, 3672($sp)
# * ASSIGN            (ILocal 3264)                       (ILocal 3676)     
lw	 $s0, 3264($sp)

sw	 $s0, 3676($sp)
# * ASSIGN            (ILocal 3268)                       (ILocal 3680)     
lw	 $s0, 3268($sp)

sw	 $s0, 3680($sp)
# * ASSIGN            (ILocal 3272)                       (ILocal 3684)     
lw	 $s0, 3272($sp)

sw	 $s0, 3684($sp)
# * ASSIGN            (ILocal 3276)                       (ILocal 3688)     
lw	 $s0, 3276($sp)

sw	 $s0, 3688($sp)
# * ASSIGN            (ILocal 3280)                       (ILocal 3692)     
lw	 $s0, 3280($sp)

sw	 $s0, 3692($sp)
# * ASSIGN            (ILocal 3284)                       (ILocal 3696)     
lw	 $s0, 3284($sp)

sw	 $s0, 3696($sp)
# * ASSIGN            (ILocal 3288)                       (ILocal 3700)     
lw	 $s0, 3288($sp)

sw	 $s0, 3700($sp)
# * ASSIGN            (ILocal 3292)                       (ILocal 3704)     
lw	 $s0, 3292($sp)

sw	 $s0, 3704($sp)
# * ASSIGN            (ILocal 3296)                       (ILocal 3708)     
lw	 $s0, 3296($sp)

sw	 $s0, 3708($sp)
# * ASSIGN            (ILocal 3300)                       (ILocal 3712)     
lw	 $s0, 3300($sp)

sw	 $s0, 3712($sp)
# * RETURN            (ICONS 3304)      (ICONS 3716)                        
lw	 $ra, 3304($sp)
add	 $sp, $sp, 3716
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
# * ASSIGN            (ILocal 404)                        (ILocal 3300)     
lw	 $s0, 404($sp)

sw	 $s0, 3300($sp)
# ----------------------------
# | Original source          |
# ----------------------------
# * 	re.columns = m2.columns;
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ASSIGN            (ILocal 408)                        (ILocal 2896)     
lw	 $s0, 408($sp)

sw	 $s0, 2896($sp)
# ----------------------------
# | Original source          |
# ----------------------------
# * 	for (i = 0; i < m1.rows; i++) {
# ----------------------------
# | 3 Address Code           |
# ----------------------------
# | op                op1               op2               dest
# | ----------------- ----------------- ----------------- ------------------
# * ASSIGN            (ICONS 0)                           (ILocal 2884)     
li	 $t0, 0

sw	 $t0, 2884($sp)
# * LABEL             (LABEL LL00014)                                       
LL00014:
# * LT                (ILocal 2884)     (ILocal 404)      (ITemp 29)        
lw	 $s0, 2884($sp)
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
# * ASSIGN            (ICONS 0)                           (ILocal 2888)     
li	 $t0, 0

sw	 $t0, 2888($sp)
# * LABEL             (LABEL LL00016)                                       
LL00016:
# * LT                (ILocal 2888)     (ILocal 408)      (ITemp 30)        
lw	 $s0, 2888($sp)
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
# * MULT              (ILocal 2884)     (ICONS 40)        (ITemp 31)        
lw	 $s2, 2884($sp)
li	 $t0, 40
mul	 $t0, $s2, $t0
# * MULT              (ILocal 2888)     (ICONS 4)         (ITemp 32)        
li	 $t1, 4
mul	 $t1, $s0, $t1
# * ADD               (ITemp 31)        (ITemp 32)        (ITemp 33)        
add	 $t0, $t0, $t1
# * ADD               (ICONS 2900)      (ITemp 33)        (ITemp 34)        
li	 $t1, 2900
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
# * ASSIGN            (ICONS 0)                           (ILocal 2892)     
li	 $t0, 0

sw	 $t0, 2892($sp)
# * LABEL             (LABEL LL00018)                                       
LL00018:
# * LT                (ILocal 2892)     (ILocal 812)      (ITemp 35)        
lw	 $s0, 2892($sp)
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
# * MULT              (ILocal 2884)     (ICONS 40)        (ITemp 36)        
lw	 $s2, 2884($sp)
li	 $t0, 40
mul	 $t0, $s2, $t0
# * MULT              (ILocal 2888)     (ICONS 4)         (ITemp 37)        
lw	 $s3, 2888($sp)
li	 $t1, 4
mul	 $t1, $s3, $t1
# * ADD               (ITemp 36)        (ITemp 37)        (ITemp 38)        
add	 $t0, $t0, $t1
# * ADD               (ICONS 2900)      (ITemp 38)        (ITemp 39)        
li	 $t1, 2900
add	 $t0, $t1, $t0
# * OFFSET            (ITemp 39)                                            
add	 $t0, $t0, $sp
# * MULT              (ILocal 2884)     (ICONS 40)        (ITemp 40)        
li	 $t1, 40
mul	 $t1, $s2, $t1
# * MULT              (ILocal 2892)     (ICONS 4)         (ITemp 41)        
li	 $t2, 4
mul	 $t2, $s0, $t2
# * ADD               (ITemp 40)        (ITemp 41)        (ITemp 42)        
add	 $t1, $t1, $t2
# * ADD               (ICONS 4)         (ITemp 42)        (ITemp 43)        
li	 $t2, 4
add	 $t1, $t2, $t1
# * OFFSET            (ITemp 43)                                            
add	 $t1, $t1, $sp
# * MULT              (ILocal 2892)     (ICONS 40)        (ITemp 44)        
li	 $t2, 40
mul	 $t2, $s0, $t2
# * MULT              (ILocal 2888)     (ICONS 4)         (ITemp 45)        
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
# * ADD               (ILocal 2892)     (ICONS 1)         (ILocal 2892)     
li	 $t0, 1
add	 $s0, $s0, $t0
sw	 $s0, 2892($sp)
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
# * ADD               (ILocal 2888)     (ICONS 1)         (ILocal 2888)     
lw	 $s0, 2888($sp)
li	 $t0, 1
add	 $s0, $s0, $t0
sw	 $s0, 2888($sp)
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
# * ADD               (ILocal 2884)     (ICONS 1)         (ILocal 2884)     
lw	 $s0, 2884($sp)
li	 $t0, 1
add	 $s0, $s0, $t0
sw	 $s0, 2884($sp)
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
# * ASSIGN            (ILocal 2896)                       (ILocal 3308)     
lw	 $s0, 2896($sp)

sw	 $s0, 3308($sp)
# * ASSIGN            (ILocal 2900)                       (ILocal 3312)     
lw	 $s0, 2900($sp)

sw	 $s0, 3312($sp)
# * ASSIGN            (ILocal 2904)                       (ILocal 3316)     
lw	 $s0, 2904($sp)

sw	 $s0, 3316($sp)
# * ASSIGN            (ILocal 2908)                       (ILocal 3320)     
lw	 $s0, 2908($sp)

sw	 $s0, 3320($sp)
# * ASSIGN            (ILocal 2912)                       (ILocal 3324)     
lw	 $s0, 2912($sp)

sw	 $s0, 3324($sp)
# * ASSIGN            (ILocal 2916)                       (ILocal 3328)     
lw	 $s0, 2916($sp)

sw	 $s0, 3328($sp)
# * ASSIGN            (ILocal 2920)                       (ILocal 3332)     
lw	 $s0, 2920($sp)

sw	 $s0, 3332($sp)
# * ASSIGN            (ILocal 2924)                       (ILocal 3336)     
lw	 $s0, 2924($sp)

sw	 $s0, 3336($sp)
# * ASSIGN            (ILocal 2928)                       (ILocal 3340)     
lw	 $s0, 2928($sp)

sw	 $s0, 3340($sp)
# * ASSIGN            (ILocal 2932)                       (ILocal 3344)     
lw	 $s0, 2932($sp)

sw	 $s0, 3344($sp)
# * ASSIGN            (ILocal 2936)                       (ILocal 3348)     
lw	 $s0, 2936($sp)

sw	 $s0, 3348($sp)
# * ASSIGN            (ILocal 2940)                       (ILocal 3352)     
lw	 $s0, 2940($sp)

sw	 $s0, 3352($sp)
# * ASSIGN            (ILocal 2944)                       (ILocal 3356)     
lw	 $s0, 2944($sp)

sw	 $s0, 3356($sp)
# * ASSIGN            (ILocal 2948)                       (ILocal 3360)     
lw	 $s0, 2948($sp)

sw	 $s0, 3360($sp)
# * ASSIGN            (ILocal 2952)                       (ILocal 3364)     
lw	 $s0, 2952($sp)

sw	 $s0, 3364($sp)
# * ASSIGN            (ILocal 2956)                       (ILocal 3368)     
lw	 $s0, 2956($sp)

sw	 $s0, 3368($sp)
# * ASSIGN            (ILocal 2960)                       (ILocal 3372)     
lw	 $s0, 2960($sp)

sw	 $s0, 3372($sp)
# * ASSIGN            (ILocal 2964)                       (ILocal 3376)     
lw	 $s0, 2964($sp)

sw	 $s0, 3376($sp)
# * ASSIGN            (ILocal 2968)                       (ILocal 3380)     
lw	 $s0, 2968($sp)

sw	 $s0, 3380($sp)
# * ASSIGN            (ILocal 2972)                       (ILocal 3384)     
lw	 $s0, 2972($sp)

sw	 $s0, 3384($sp)
# * ASSIGN            (ILocal 2976)                       (ILocal 3388)     
lw	 $s0, 2976($sp)

sw	 $s0, 3388($sp)
# * ASSIGN            (ILocal 2980)                       (ILocal 3392)     
lw	 $s0, 2980($sp)

sw	 $s0, 3392($sp)
# * ASSIGN            (ILocal 2984)                       (ILocal 3396)     
lw	 $s0, 2984($sp)

sw	 $s0, 3396($sp)
# * ASSIGN            (ILocal 2988)                       (ILocal 3400)     
lw	 $s0, 2988($sp)

sw	 $s0, 3400($sp)
# * ASSIGN            (ILocal 2992)                       (ILocal 3404)     
lw	 $s0, 2992($sp)

sw	 $s0, 3404($sp)
# * ASSIGN            (ILocal 2996)                       (ILocal 3408)     
lw	 $s0, 2996($sp)

sw	 $s0, 3408($sp)
# * ASSIGN            (ILocal 3000)                       (ILocal 3412)     
lw	 $s0, 3000($sp)

sw	 $s0, 3412($sp)
# * ASSIGN            (ILocal 3004)                       (ILocal 3416)     
lw	 $s0, 3004($sp)

sw	 $s0, 3416($sp)
# * ASSIGN            (ILocal 3008)                       (ILocal 3420)     
lw	 $s0, 3008($sp)

sw	 $s0, 3420($sp)
# * ASSIGN            (ILocal 3012)                       (ILocal 3424)     
lw	 $s0, 3012($sp)

sw	 $s0, 3424($sp)
# * ASSIGN            (ILocal 3016)                       (ILocal 3428)     
lw	 $s0, 3016($sp)

sw	 $s0, 3428($sp)
# * ASSIGN            (ILocal 3020)                       (ILocal 3432)     
lw	 $s0, 3020($sp)

sw	 $s0, 3432($sp)
# * ASSIGN            (ILocal 3024)                       (ILocal 3436)     
lw	 $s0, 3024($sp)

sw	 $s0, 3436($sp)
# * ASSIGN            (ILocal 3028)                       (ILocal 3440)     
lw	 $s0, 3028($sp)

sw	 $s0, 3440($sp)
# * ASSIGN            (ILocal 3032)                       (ILocal 3444)     
lw	 $s0, 3032($sp)

sw	 $s0, 3444($sp)
# * ASSIGN            (ILocal 3036)                       (ILocal 3448)     
lw	 $s0, 3036($sp)

sw	 $s0, 3448($sp)
# * ASSIGN            (ILocal 3040)                       (ILocal 3452)     
lw	 $s0, 3040($sp)

sw	 $s0, 3452($sp)
# * ASSIGN            (ILocal 3044)                       (ILocal 3456)     
lw	 $s0, 3044($sp)

sw	 $s0, 3456($sp)
# * ASSIGN            (ILocal 3048)                       (ILocal 3460)     
lw	 $s0, 3048($sp)

sw	 $s0, 3460($sp)
# * ASSIGN            (ILocal 3052)                       (ILocal 3464)     
lw	 $s0, 3052($sp)

sw	 $s0, 3464($sp)
# * ASSIGN            (ILocal 3056)                       (ILocal 3468)     
lw	 $s0, 3056($sp)

sw	 $s0, 3468($sp)
# * ASSIGN            (ILocal 3060)                       (ILocal 3472)     
lw	 $s0, 3060($sp)

sw	 $s0, 3472($sp)
# * ASSIGN            (ILocal 3064)                       (ILocal 3476)     
lw	 $s0, 3064($sp)

sw	 $s0, 3476($sp)
# * ASSIGN            (ILocal 3068)                       (ILocal 3480)     
lw	 $s0, 3068($sp)

sw	 $s0, 3480($sp)
# * ASSIGN            (ILocal 3072)                       (ILocal 3484)     
lw	 $s0, 3072($sp)

sw	 $s0, 3484($sp)
# * ASSIGN            (ILocal 3076)                       (ILocal 3488)     
lw	 $s0, 3076($sp)

sw	 $s0, 3488($sp)
# * ASSIGN            (ILocal 3080)                       (ILocal 3492)     
lw	 $s0, 3080($sp)

sw	 $s0, 3492($sp)
# * ASSIGN            (ILocal 3084)                       (ILocal 3496)     
lw	 $s0, 3084($sp)

sw	 $s0, 3496($sp)
# * ASSIGN            (ILocal 3088)                       (ILocal 3500)     
lw	 $s0, 3088($sp)

sw	 $s0, 3500($sp)
# * ASSIGN            (ILocal 3092)                       (ILocal 3504)     
lw	 $s0, 3092($sp)

sw	 $s0, 3504($sp)
# * ASSIGN            (ILocal 3096)                       (ILocal 3508)     
lw	 $s0, 3096($sp)

sw	 $s0, 3508($sp)
# * ASSIGN            (ILocal 3100)                       (ILocal 3512)     
lw	 $s0, 3100($sp)

sw	 $s0, 3512($sp)
# * ASSIGN            (ILocal 3104)                       (ILocal 3516)     
lw	 $s0, 3104($sp)

sw	 $s0, 3516($sp)
# * ASSIGN            (ILocal 3108)                       (ILocal 3520)     
lw	 $s0, 3108($sp)

sw	 $s0, 3520($sp)
# * ASSIGN            (ILocal 3112)                       (ILocal 3524)     
lw	 $s0, 3112($sp)

sw	 $s0, 3524($sp)
# * ASSIGN            (ILocal 3116)                       (ILocal 3528)     
lw	 $s0, 3116($sp)

sw	 $s0, 3528($sp)
# * ASSIGN            (ILocal 3120)                       (ILocal 3532)     
lw	 $s0, 3120($sp)

sw	 $s0, 3532($sp)
# * ASSIGN            (ILocal 3124)                       (ILocal 3536)     
lw	 $s0, 3124($sp)

sw	 $s0, 3536($sp)
# * ASSIGN            (ILocal 3128)                       (ILocal 3540)     
lw	 $s0, 3128($sp)

sw	 $s0, 3540($sp)
# * ASSIGN            (ILocal 3132)                       (ILocal 3544)     
lw	 $s0, 3132($sp)

sw	 $s0, 3544($sp)
# * ASSIGN            (ILocal 3136)                       (ILocal 3548)     
lw	 $s0, 3136($sp)

sw	 $s0, 3548($sp)
# * ASSIGN            (ILocal 3140)                       (ILocal 3552)     
lw	 $s0, 3140($sp)

sw	 $s0, 3552($sp)
# * ASSIGN            (ILocal 3144)                       (ILocal 3556)     
lw	 $s0, 3144($sp)

sw	 $s0, 3556($sp)
# * ASSIGN            (ILocal 3148)                       (ILocal 3560)     
lw	 $s0, 3148($sp)

sw	 $s0, 3560($sp)
# * ASSIGN            (ILocal 3152)                       (ILocal 3564)     
lw	 $s0, 3152($sp)

sw	 $s0, 3564($sp)
# * ASSIGN            (ILocal 3156)                       (ILocal 3568)     
lw	 $s0, 3156($sp)

sw	 $s0, 3568($sp)
# * ASSIGN            (ILocal 3160)                       (ILocal 3572)     
lw	 $s0, 3160($sp)

sw	 $s0, 3572($sp)
# * ASSIGN            (ILocal 3164)                       (ILocal 3576)     
lw	 $s0, 3164($sp)

sw	 $s0, 3576($sp)
# * ASSIGN            (ILocal 3168)                       (ILocal 3580)     
lw	 $s0, 3168($sp)

sw	 $s0, 3580($sp)
# * ASSIGN            (ILocal 3172)                       (ILocal 3584)     
lw	 $s0, 3172($sp)

sw	 $s0, 3584($sp)
# * ASSIGN            (ILocal 3176)                       (ILocal 3588)     
lw	 $s0, 3176($sp)

sw	 $s0, 3588($sp)
# * ASSIGN            (ILocal 3180)                       (ILocal 3592)     
lw	 $s0, 3180($sp)

sw	 $s0, 3592($sp)
# * ASSIGN            (ILocal 3184)                       (ILocal 3596)     
lw	 $s0, 3184($sp)

sw	 $s0, 3596($sp)
# * ASSIGN            (ILocal 3188)                       (ILocal 3600)     
lw	 $s0, 3188($sp)

sw	 $s0, 3600($sp)
# * ASSIGN            (ILocal 3192)                       (ILocal 3604)     
lw	 $s0, 3192($sp)

sw	 $s0, 3604($sp)
# * ASSIGN            (ILocal 3196)                       (ILocal 3608)     
lw	 $s0, 3196($sp)

sw	 $s0, 3608($sp)
# * ASSIGN            (ILocal 3200)                       (ILocal 3612)     
lw	 $s0, 3200($sp)

sw	 $s0, 3612($sp)
# * ASSIGN            (ILocal 3204)                       (ILocal 3616)     
lw	 $s0, 3204($sp)

sw	 $s0, 3616($sp)
# * ASSIGN            (ILocal 3208)                       (ILocal 3620)     
lw	 $s0, 3208($sp)

sw	 $s0, 3620($sp)
# * ASSIGN            (ILocal 3212)                       (ILocal 3624)     
lw	 $s0, 3212($sp)

sw	 $s0, 3624($sp)
# * ASSIGN            (ILocal 3216)                       (ILocal 3628)     
lw	 $s0, 3216($sp)

sw	 $s0, 3628($sp)
# * ASSIGN            (ILocal 3220)                       (ILocal 3632)     
lw	 $s0, 3220($sp)

sw	 $s0, 3632($sp)
# * ASSIGN            (ILocal 3224)                       (ILocal 3636)     
lw	 $s0, 3224($sp)

sw	 $s0, 3636($sp)
# * ASSIGN            (ILocal 3228)                       (ILocal 3640)     
lw	 $s0, 3228($sp)

sw	 $s0, 3640($sp)
# * ASSIGN            (ILocal 3232)                       (ILocal 3644)     
lw	 $s0, 3232($sp)

sw	 $s0, 3644($sp)
# * ASSIGN            (ILocal 3236)                       (ILocal 3648)     
lw	 $s0, 3236($sp)

sw	 $s0, 3648($sp)
# * ASSIGN            (ILocal 3240)                       (ILocal 3652)     
lw	 $s0, 3240($sp)

sw	 $s0, 3652($sp)
# * ASSIGN            (ILocal 3244)                       (ILocal 3656)     
lw	 $s0, 3244($sp)

sw	 $s0, 3656($sp)
# * ASSIGN            (ILocal 3248)                       (ILocal 3660)     
lw	 $s0, 3248($sp)

sw	 $s0, 3660($sp)
# * ASSIGN            (ILocal 3252)                       (ILocal 3664)     
lw	 $s0, 3252($sp)

sw	 $s0, 3664($sp)
# * ASSIGN            (ILocal 3256)                       (ILocal 3668)     
lw	 $s0, 3256($sp)

sw	 $s0, 3668($sp)
# * ASSIGN            (ILocal 3260)                       (ILocal 3672)     
lw	 $s0, 3260($sp)

sw	 $s0, 3672($sp)
# * ASSIGN            (ILocal 3264)                       (ILocal 3676)     
lw	 $s0, 3264($sp)

sw	 $s0, 3676($sp)
# * ASSIGN            (ILocal 3268)                       (ILocal 3680)     
lw	 $s0, 3268($sp)

sw	 $s0, 3680($sp)
# * ASSIGN            (ILocal 3272)                       (ILocal 3684)     
lw	 $s0, 3272($sp)

sw	 $s0, 3684($sp)
# * ASSIGN            (ILocal 3276)                       (ILocal 3688)     
lw	 $s0, 3276($sp)

sw	 $s0, 3688($sp)
# * ASSIGN            (ILocal 3280)                       (ILocal 3692)     
lw	 $s0, 3280($sp)

sw	 $s0, 3692($sp)
# * ASSIGN            (ILocal 3284)                       (ILocal 3696)     
lw	 $s0, 3284($sp)

sw	 $s0, 3696($sp)
# * ASSIGN            (ILocal 3288)                       (ILocal 3700)     
lw	 $s0, 3288($sp)

sw	 $s0, 3700($sp)
# * ASSIGN            (ILocal 3292)                       (ILocal 3704)     
lw	 $s0, 3292($sp)

sw	 $s0, 3704($sp)
# * ASSIGN            (ILocal 3296)                       (ILocal 3708)     
lw	 $s0, 3296($sp)

sw	 $s0, 3708($sp)
# * ASSIGN            (ILocal 3300)                       (ILocal 3712)     
lw	 $s0, 3300($sp)

sw	 $s0, 3712($sp)
# * RETURN            (ICONS 3304)      (ICONS 3716)                        
lw	 $ra, 3304($sp)
add	 $sp, $sp, 3716
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
# * RETURN            (ICONS 3304)      (ICONS 3716)                        
lw	 $ra, 3304($sp)
add	 $sp, $sp, 3716
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
