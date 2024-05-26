   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.12.8.1 - 09 Jan 2023
   3                     ; Generator (Limited) V4.5.5 - 08 Nov 2022
  14                     	bsct
  15  0000               _iii:
  16  0000 0000          	dc.w	0
  17  0002               _ii:
  18  0002 0000          	dc.w	0
  19  0004               _y:
  20  0004 0000          	dc.w	0
  21  0006               _l:
  22  0006 000a          	dc.w	10
  23  0008               _i:
  24  0008 0000          	dc.w	0
  25  000a               _xx:
  26  000a 0000          	dc.w	0
  27  000c               _xxx:
  28  000c 0000          	dc.w	0
  29  000e               _swres:
  30  000e 00            	dc.b	0
  31  000f               _speed:
  32  000f 01c2          	dc.w	450
  33  0011               _butcount:
  34  0011 0000          	dc.w	0
  74                     ; 36  void delay(int n)
  74                     ; 37  {
  76                     	switch	.text
  77  0000               _delay:
  79  0000 89            	pushw	x
  80       00000000      OFST:	set	0
  83  0001 2007          	jra	L13
  84  0003               L72:
  85                     ; 38          while(n > 10) n--;
  87  0003 1e01          	ldw	x,(OFST+1,sp)
  88  0005 1d0001        	subw	x,#1
  89  0008 1f01          	ldw	(OFST+1,sp),x
  90  000a               L13:
  93  000a 9c            	rvf
  94  000b 1e01          	ldw	x,(OFST+1,sp)
  95  000d a3000b        	cpw	x,#11
  96  0010 2ef1          	jrsge	L72
  97                     ; 39  }
 100  0012 85            	popw	x
 101  0013 81            	ret
 128                     ; 41 @far @interrupt void EXTI3_IRQHandler(void) 
 128                     ; 42 {
 130                     	switch	.text
 131  0014               f_EXTI3_IRQHandler:
 135                     ; 43 	butcount = 0;
 137  0014 5f            	clrw	x
 138  0015 bf11          	ldw	_butcount,x
 139                     ; 44 	if (swres == 0) SB1 ++;
 141  0017 3d0e          	tnz	_swres
 142  0019 2602          	jrne	L75
 145  001b 3c02          	inc	_SB1
 146  001d               L75:
 147                     ; 45 	if (SB1 >= 5) SB1 = 0;
 149  001d b602          	ld	a,_SB1
 150  001f a105          	cp	a,#5
 151  0021 254c          	jrult	L56
 154  0023 3f02          	clr	_SB1
 155  0025 2048          	jra	L56
 156  0027               L36:
 157                     ; 47 	if (butcount < 10000){
 159  0027 be11          	ldw	x,_butcount
 160  0029 a32710        	cpw	x,#10000
 161  002c 2409          	jruge	L17
 162                     ; 48 			butcount ++;
 164  002e be11          	ldw	x,_butcount
 165  0030 1c0001        	addw	x,#1
 166  0033 bf11          	ldw	_butcount,x
 168  0035 2038          	jra	L56
 169  0037               L17:
 170                     ; 51 			swres = 1;
 172  0037 3501000e      	mov	_swres,#1
 173                     ; 52 	switch (SB1){
 175  003b b602          	ld	a,_SB1
 177                     ; 67 		break;
 178  003d 4d            	tnz	a
 179  003e 270e          	jreq	L53
 180  0040 4a            	dec	a
 181  0041 2712          	jreq	L73
 182  0043 4a            	dec	a
 183  0044 2716          	jreq	L14
 184  0046 4a            	dec	a
 185  0047 271a          	jreq	L34
 186  0049 4a            	dec	a
 187  004a 271e          	jreq	L54
 188  004c 2021          	jra	L56
 189  004e               L53:
 190                     ; 53 				case 0:
 190                     ; 54 		speed = 450;
 192  004e ae01c2        	ldw	x,#450
 193  0051 bf0f          	ldw	_speed,x
 194                     ; 55 		break;
 196  0053 201a          	jra	L56
 197  0055               L73:
 198                     ; 56 				case 1:
 198                     ; 57 		speed = 350;
 200  0055 ae015e        	ldw	x,#350
 201  0058 bf0f          	ldw	_speed,x
 202                     ; 58 		break;
 204  005a 2013          	jra	L56
 205  005c               L14:
 206                     ; 59 				case 2:
 206                     ; 60 		speed = 250;
 208  005c ae00fa        	ldw	x,#250
 209  005f bf0f          	ldw	_speed,x
 210                     ; 61 		break;
 212  0061 200c          	jra	L56
 213  0063               L34:
 214                     ; 62 				case 3:
 214                     ; 63 		speed = 150;
 216  0063 ae0096        	ldw	x,#150
 217  0066 bf0f          	ldw	_speed,x
 218                     ; 64 		break;
 220  0068 2005          	jra	L56
 221  006a               L54:
 222                     ; 65 				case 4:
 222                     ; 66 		speed = 50;
 224  006a ae0032        	ldw	x,#50
 225  006d bf0f          	ldw	_speed,x
 226                     ; 67 		break;
 228  006f               L77:
 229  006f               L56:
 230                     ; 46 	while (!((GPIOD->IDR & (1 << 3)))){//нажатие кнопки SB2 изменение скорости
 232  006f c65010        	ld	a,20496
 233  0072 a508          	bcp	a,#8
 234  0074 27b1          	jreq	L36
 235                     ; 71 return;
 238  0076 80            	iret
 263                     ; 74 void DS1307init (void){//
 265                     	switch	.text
 266  0077               _DS1307init:
 270                     ; 75 					I2C->CR1 |= (1<<0);//включаем I2C
 272  0077 72105210      	bset	21008,#0
 273                     ; 77 					I2C->CR2 |= (1<<0);//отправка посылки СТАРТ
 275  007b 72105211      	bset	21009,#0
 276                     ; 78 					xxx = I2C->SR1;//Очистка бита ADDR чтением регистра SR3
 278  007f c65217        	ld	a,21015
 279  0082 5f            	clrw	x
 280  0083 97            	ld	xl,a
 281  0084 bf0c          	ldw	_xxx,x
 282                     ; 80 					delay (500);//delay (250);
 284  0086 ae01f4        	ldw	x,#500
 285  0089 cd0000        	call	_delay
 287                     ; 82 					while(I2C->SR1 & (1 << 1) == 1){}//ждём конца передачи адрес 1
 290  008c 35d05216      	mov	21014,#208
 291                     ; 84 					delay (500);//delay (200);
 293  0090 ae01f4        	ldw	x,#500
 294  0093 cd0000        	call	_delay
 296                     ; 85 					xxx = I2C->SR1;//Очистка бита ADDR чтением регистра SR3
 298  0096 c65217        	ld	a,21015
 299  0099 5f            	clrw	x
 300  009a 97            	ld	xl,a
 301  009b bf0c          	ldw	_xxx,x
 302                     ; 86 					xxx = I2C->SR3;//Очистка бита ADDR чтением регистра SR3
 304  009d c65219        	ld	a,21017
 305  00a0 5f            	clrw	x
 306  00a1 97            	ld	xl,a
 307  00a2 bf0c          	ldw	_xxx,x
 309  00a4               L511:
 310                     ; 87 					while((I2C->SR1 & (1 << 2)) && (I2C->SR1 & (1 << 7)) == 1){}//
 312  00a4 c65217        	ld	a,21015
 313  00a7 a504          	bcp	a,#4
 314  00a9 2709          	jreq	L121
 316  00ab c65217        	ld	a,21015
 317  00ae a480          	and	a,#128
 318  00b0 a101          	cp	a,#1
 319  00b2 27f0          	jreq	L511
 320  00b4               L121:
 321                     ; 88           xxx = I2C->SR3;//Очистка бита ADDR чтением регистра SR3
 323  00b4 c65219        	ld	a,21017
 324  00b7 5f            	clrw	x
 325  00b8 97            	ld	xl,a
 326  00b9 bf0c          	ldw	_xxx,x
 327                     ; 89 					I2C->DR = 0b00000000;//вызов регистра секунд
 329  00bb 725f5216      	clr	21014
 330                     ; 90 					delay (350);//delay (450);
 332  00bf ae015e        	ldw	x,#350
 333  00c2 cd0000        	call	_delay
 335                     ; 92 					I2C->DR &= ~(1 << 7);//отправка данных
 337  00c5 721f5216      	bres	21014,#7
 338                     ; 94 					I2C->CR2 |= (1<<1);//отправка посылки СТОП
 340  00c9 72125211      	bset	21009,#1
 341                     ; 95 					alar = 1;
 343  00cd 3501009a      	mov	_alar,#1
 344                     ; 99 					delay (5000);//delay (250);
 346  00d1 ae1388        	ldw	x,#5000
 347  00d4 cd0000        	call	_delay
 349                     ; 100 					I2C->CR2 |= (1<<0);//отправка посылки СТАРТ
 351  00d7 72105211      	bset	21009,#0
 352                     ; 102 					while(I2C->SR1 & (1 << 0) != 1){}//ждём установки стартового бита 1
 355  00db c65217        	ld	a,21015
 356  00de 5f            	clrw	x
 357  00df 97            	ld	xl,a
 358  00e0 bf0c          	ldw	_xxx,x
 359                     ; 103 					delay (500);//delay (50);
 361  00e2 ae01f4        	ldw	x,#500
 362  00e5 cd0000        	call	_delay
 364                     ; 105 					while(I2C->SR1 & (1 << 1) == 1){}//ждём конца передачи адрес 1
 367  00e8 35d05216      	mov	21014,#208
 368                     ; 107 					delay (500);//delay (100);
 370  00ec ae01f4        	ldw	x,#500
 371  00ef cd0000        	call	_delay
 373                     ; 108 					xxx = I2C->SR1;//Очистка бита ADDR чтением регистра SR3
 375  00f2 c65217        	ld	a,21015
 376  00f5 5f            	clrw	x
 377  00f6 97            	ld	xl,a
 378  00f7 bf0c          	ldw	_xxx,x
 379                     ; 109 					xxx = I2C->SR3;//Очистка бита ADDR чтением регистра SR3
 381  00f9 c65219        	ld	a,21017
 382  00fc 5f            	clrw	x
 383  00fd 97            	ld	xl,a
 384  00fe bf0c          	ldw	_xxx,x
 386  0100               L721:
 387                     ; 110 					while((I2C->SR1 & (1 << 2)) && (I2C->SR1 & (1 << 7)) == 1){}//
 389  0100 c65217        	ld	a,21015
 390  0103 a504          	bcp	a,#4
 391  0105 2709          	jreq	L331
 393  0107 c65217        	ld	a,21015
 394  010a a480          	and	a,#128
 395  010c a101          	cp	a,#1
 396  010e 27f0          	jreq	L721
 397  0110               L331:
 398                     ; 111           xxx = I2C->SR3;//Очистка бита ADDR чтением регистра SR3
 400  0110 c65219        	ld	a,21017
 401  0113 5f            	clrw	x
 402  0114 97            	ld	xl,a
 403  0115 bf0c          	ldw	_xxx,x
 404                     ; 112 					I2C->DR = 0b00000111;//вызов регистра clock out  0b00000111
 406  0117 35075216      	mov	21014,#7
 407                     ; 113 					delay (600);//delay (250);
 409  011b ae0258        	ldw	x,#600
 410  011e cd0000        	call	_delay
 412                     ; 115 					while(I2C->SR1 & (1 << 7) == 1){}//ждём освобождения регистра данны
 415  0121 35105216      	mov	21014,#16
 416                     ; 116 					I2C->CR2 |= (1<<1);//отправка посылки СТОП		
 418  0125 72125211      	bset	21009,#1
 419                     ; 118 					return;
 422  0129 81            	ret
 448                     ; 121 int DS07read (void){//чтение секунд
 449                     	switch	.text
 450  012a               _DS07read:
 454                     ; 122 					delay (5000);//delay (250);
 456  012a ae1388        	ldw	x,#5000
 457  012d cd0000        	call	_delay
 459                     ; 124 					I2C->CR2 |= (1<<0);//отправка посылки СТАРТ
 461  0130 72105211      	bset	21009,#0
 462                     ; 126 					while(I2C->SR1 & (1 << 0) != 1){}//ждём установки стартового бита 1
 465  0134 c65217        	ld	a,21015
 466  0137 5f            	clrw	x
 467  0138 97            	ld	xl,a
 468  0139 bf0c          	ldw	_xxx,x
 469                     ; 127 					delay (500);//delay (50);
 471  013b ae01f4        	ldw	x,#500
 472  013e cd0000        	call	_delay
 474                     ; 129 					while(I2C->SR1 & (1 << 1) == 1){}//ждём конца передачи адрес 1
 477  0141 35d05216      	mov	21014,#208
 478                     ; 131 					delay (500);//delay (100);
 480  0145 ae01f4        	ldw	x,#500
 481  0148 cd0000        	call	_delay
 483                     ; 132 					xxx = I2C->SR1;//Очистка бита ADDR чтением регистра SR3
 485  014b c65217        	ld	a,21015
 486  014e 5f            	clrw	x
 487  014f 97            	ld	xl,a
 488  0150 bf0c          	ldw	_xxx,x
 489                     ; 133 					xxx = I2C->SR3;//Очистка бита ADDR чтением регистра SR3
 491  0152 c65219        	ld	a,21017
 492  0155 5f            	clrw	x
 493  0156 97            	ld	xl,a
 494  0157 bf0c          	ldw	_xxx,x
 496  0159               L151:
 497                     ; 134 					while((I2C->SR1 & (1 << 2)) && (I2C->SR1 & (1 << 7)) == 1){}//
 499  0159 c65217        	ld	a,21015
 500  015c a504          	bcp	a,#4
 501  015e 2709          	jreq	L551
 503  0160 c65217        	ld	a,21015
 504  0163 a480          	and	a,#128
 505  0165 a101          	cp	a,#1
 506  0167 27f0          	jreq	L151
 507  0169               L551:
 508                     ; 135           xxx = I2C->SR3;//Очистка бита ADDR чтением регистра SR3
 510  0169 c65219        	ld	a,21017
 511  016c 5f            	clrw	x
 512  016d 97            	ld	xl,a
 513  016e bf0c          	ldw	_xxx,x
 514                     ; 136 					I2C->DR = 0b00000001;//вызов регистра минут
 516  0170 35015216      	mov	21014,#1
 517                     ; 137 					delay (600);//delay (250);
 519  0174 ae0258        	ldw	x,#600
 520  0177 cd0000        	call	_delay
 522                     ; 140 					I2C->CR2 |= (1<<1);//отправка посылки СТОП
 524  017a 72125211      	bset	21009,#1
 525                     ; 148 					I2C->CR2 |= (1<<0);//отправка посылки СТАРТ
 527  017e 72105211      	bset	21009,#0
 528                     ; 150 					while(I2C->SR1 & (1 << 0) != 1){}//ждём установки стартового бита 1
 531  0182 c65217        	ld	a,21015
 532  0185 5f            	clrw	x
 533  0186 97            	ld	xl,a
 534  0187 bf0c          	ldw	_xxx,x
 535                     ; 151 					delay (500);//delay (50);
 537  0189 ae01f4        	ldw	x,#500
 538  018c cd0000        	call	_delay
 540                     ; 153 					while(I2C->SR1 & (1 << 1) == 1){}//ждём конца передачи адрес 1
 543  018f 35d15216      	mov	21014,#209
 544                     ; 155 					delay (500);//delay (100);
 546  0193 ae01f4        	ldw	x,#500
 547  0196 cd0000        	call	_delay
 549                     ; 156 					xxx = I2C->SR1;//Очистка бита ADDR чтением регистра SR3
 551  0199 c65217        	ld	a,21015
 552  019c 5f            	clrw	x
 553  019d 97            	ld	xl,a
 554  019e bf0c          	ldw	_xxx,x
 555                     ; 157 					xxx = I2C->SR3;//Очистка бита ADDR чтением регистра SR3
 557  01a0 c65219        	ld	a,21017
 558  01a3 5f            	clrw	x
 559  01a4 97            	ld	xl,a
 560  01a5 bf0c          	ldw	_xxx,x
 561                     ; 158 					delay (600);//delay (100);
 563  01a7 ae0258        	ldw	x,#600
 564  01aa cd0000        	call	_delay
 566                     ; 160 					next = I2C->DR;
 568  01ad c65216        	ld	a,21014
 569  01b0 5f            	clrw	x
 570  01b1 97            	ld	xl,a
 571  01b2 bf9d          	ldw	_next,x
 572                     ; 162 					I2C->CR2 |= (1<<1);//отправка посылки СТОП
 574  01b4 72125211      	bset	21009,#1
 575                     ; 164 					next = next & 0b11110000;
 577  01b8 b69e          	ld	a,_next+1
 578  01ba a4f0          	and	a,#240
 579  01bc b79e          	ld	_next+1,a
 580  01be 3f9d          	clr	_next
 581                     ; 165 					if ((next & 0b11110000) == 0) next = 1;
 583  01c0 b69e          	ld	a,_next+1
 584  01c2 a5f0          	bcp	a,#240
 585  01c4 2605          	jrne	L751
 588  01c6 ae0001        	ldw	x,#1
 589  01c9 bf9d          	ldw	_next,x
 590  01cb               L751:
 591                     ; 166 return;
 594  01cb 81            	ret
 649                     ; 169 	void raand(unsigned int jk)
 649                     ; 170 		 {
 650                     	switch	.text
 651  01cc               _raand:
 653  01cc 89            	pushw	x
 654  01cd 5203          	subw	sp,#3
 655       00000003      OFST:	set	3
 658                     ; 177 		 if (jk > 20) next = 2;
 660  01cf a30015        	cpw	x,#21
 661  01d2 2505          	jrult	L702
 664  01d4 ae0002        	ldw	x,#2
 665  01d7 bf9d          	ldw	_next,x
 666  01d9               L702:
 667                     ; 178 		 for (i2 = 0; i2 < 36; i2++){
 669  01d9 0f01          	clr	(OFST-2,sp)
 671  01db               L112:
 672                     ; 179 		 jk = jk * 1103515;//1103515245
 674  01db 1e04          	ldw	x,(OFST+1,sp)
 675  01dd 90aed69b      	ldw	y,#54939
 676  01e1 cd0000        	call	c_imul
 678  01e4 1f04          	ldw	(OFST+1,sp),x
 679                     ; 180 		   next2 = (jk / 655) * 276;// next2 = (next / 65536) * 2768
 681  01e6 1e04          	ldw	x,(OFST+1,sp)
 682  01e8 90ae028f      	ldw	y,#655
 683  01ec 65            	divw	x,y
 684  01ed 90ae0114      	ldw	y,#276
 685  01f1 cd0000        	call	c_imul
 687  01f4 bf9b          	ldw	_next2,x
 688                     ; 181 		   xy = next2 % (327 - 8 + 1) + 8;//x = next2 % (32767 - 8 + 1) + 8
 690  01f6 be9b          	ldw	x,_next2
 691  01f8 90ae0140      	ldw	y,#320
 692  01fc 65            	divw	x,y
 693  01fd 51            	exgw	x,y
 694  01fe 1c0008        	addw	x,#8
 695  0201 1f02          	ldw	(OFST-1,sp),x
 697                     ; 182 		   if (xy > 327) xy = xy - 327;//if (x > 32767) x = x - 32767;
 699  0203 9c            	rvf
 700  0204 1e02          	ldw	x,(OFST-1,sp)
 701  0206 a30148        	cpw	x,#328
 702  0209 2f07          	jrslt	L712
 705  020b 1e02          	ldw	x,(OFST-1,sp)
 706  020d 1d0147        	subw	x,#327
 707  0210 1f02          	ldw	(OFST-1,sp),x
 709  0212               L712:
 710                     ; 183 		 eff111[i2] = xy;//0
 712  0212 7b01          	ld	a,(OFST-2,sp)
 713  0214 5f            	clrw	x
 714  0215 97            	ld	xl,a
 715  0216 58            	sllw	x
 716  0217 1602          	ldw	y,(OFST-1,sp)
 717  0219 ef52          	ldw	(_eff111,x),y
 718                     ; 178 		 for (i2 = 0; i2 < 36; i2++){
 720  021b 0c01          	inc	(OFST-2,sp)
 724  021d 7b01          	ld	a,(OFST-2,sp)
 725  021f a124          	cp	a,#36
 726  0221 25b8          	jrult	L112
 727                     ; 185 	}
 730  0223 5b05          	addw	sp,#5
 731  0225 81            	ret
 766                     ; 187  void clear_matrix(void)
 766                     ; 188  {
 767                     	switch	.text
 768  0226               _clear_matrix:
 770  0226 88            	push	a
 771       00000001      OFST:	set	1
 774                     ; 190  	 for (i = 0;i < 49; i++){
 776  0227 0f01          	clr	(OFST+0,sp)
 778  0229               L732:
 779                     ; 191  		 eff111[i] = 0;
 781  0229 7b01          	ld	a,(OFST+0,sp)
 782  022b 5f            	clrw	x
 783  022c 97            	ld	xl,a
 784  022d 58            	sllw	x
 785  022e 905f          	clrw	y
 786  0230 ef52          	ldw	(_eff111,x),y
 787                     ; 190  	 for (i = 0;i < 49; i++){
 789  0232 0c01          	inc	(OFST+0,sp)
 793  0234 7b01          	ld	a,(OFST+0,sp)
 794  0236 a131          	cp	a,#49
 795  0238 25ef          	jrult	L732
 796                     ; 193  }
 799  023a 84            	pop	a
 800  023b 81            	ret
 846                     ; 195 	void fraim_out (int o, int e){
 847                     	switch	.text
 848  023c               _fraim_out:
 852                     ; 196 			if (iii > 48) {//Перезапись массива
 854  023c 9c            	rvf
 855  023d be00          	ldw	x,_iii
 856  023f a30031        	cpw	x,#49
 857  0242 2f0d          	jrslt	L362
 858                     ; 198 	 			raand(DS07read());
 860  0244 cd012a        	call	_DS07read
 862  0247 ad83          	call	_raand
 864                     ; 199 	 			iii = 0;
 866  0249 5f            	clrw	x
 867  024a bf00          	ldw	_iii,x
 868                     ; 200 				fraim = 1;
 870  024c ae0001        	ldw	x,#1
 871  024f bf08          	ldw	_fraim,x
 872  0251               L362:
 873                     ; 204 						iii++;
 875  0251 be00          	ldw	x,_iii
 876  0253 1c0001        	addw	x,#1
 877  0256 bf00          	ldw	_iii,x
 878                     ; 205 						buf[35] = eff111[0];//Считали 1ю колонку в буфер
 880  0258 be52          	ldw	x,_eff111
 881  025a bf50          	ldw	_buf+70,x
 882                     ; 206 						for ( ii = 0; ii < 35; ii++){
 884  025c 5f            	clrw	x
 885  025d bf02          	ldw	_ii,x
 886  025f               L562:
 887                     ; 207 						eff111[ii] = eff111[ii + 1];//Сдвинули матрицу на один столбец влево
 889  025f be02          	ldw	x,_ii
 890  0261 58            	sllw	x
 891  0262 9093          	ldw	y,x
 892  0264 90ee54        	ldw	y,(_eff111+2,y)
 893  0267 ef52          	ldw	(_eff111,x),y
 894                     ; 206 						for ( ii = 0; ii < 35; ii++){
 896  0269 be02          	ldw	x,_ii
 897  026b 1c0001        	addw	x,#1
 898  026e bf02          	ldw	_ii,x
 901  0270 9c            	rvf
 902  0271 be02          	ldw	x,_ii
 903  0273 a30023        	cpw	x,#35
 904  0276 2fe7          	jrslt	L562
 905                     ; 209 						eff111[35] = buf[35];//Записали содержимое буфера (первую колонку) в конец матрицы
 907  0278 be50          	ldw	x,_buf+70
 908  027a bf98          	ldw	_eff111+70,x
 909                     ; 221 	for ( ip = 0; ip < speed; ++ip){//400  speed
 911  027c 5f            	clrw	x
 912  027d bf00          	ldw	_ip,x
 914  027f 2050          	jra	L772
 915  0281               L372:
 916                     ; 223 						GPIOC->ODR = eff111[l];//	
 918  0281 be06          	ldw	x,_l
 919  0283 58            	sllw	x
 920  0284 e653          	ld	a,(_eff111+1,x)
 921  0286 c7500a        	ld	20490,a
 922                     ; 232 					GPIOD->ODR &= ~(1<<6);
 924  0289 721d500f      	bres	20495,#6
 925                     ; 233 					delay (500);//скорость бега строки1000
 927  028d ae01f4        	ldw	x,#500
 928  0290 cd0000        	call	_delay
 930                     ; 234 					GPIOD->ODR |= (1<<6);
 932  0293 721c500f      	bset	20495,#6
 933                     ; 236 					GPIOC->ODR &= ~((1<<7) | (1<<6) | (1<<5) | (1<<4) | (1<<3));//очистка строк ++
 935  0297 c6500a        	ld	a,20490
 936  029a a407          	and	a,#7
 937  029c c7500a        	ld	20490,a
 938                     ; 237 					l--;
 940  029f be06          	ldw	x,_l
 941  02a1 1d0001        	subw	x,#1
 942  02a4 bf06          	ldw	_l,x
 943                     ; 238 	 	 			y++;
 945  02a6 be04          	ldw	x,_y
 946  02a8 1c0001        	addw	x,#1
 947  02ab bf04          	ldw	_y,x
 948                     ; 239 	 	 			if (y == 8){
 950  02ad be04          	ldw	x,_y
 951  02af a30008        	cpw	x,#8
 952  02b2 2616          	jrne	L303
 953                     ; 240 	 	 				y = 0;
 955  02b4 5f            	clrw	x
 956  02b5 bf04          	ldw	_y,x
 957                     ; 241 	 	 				l = 8;
 959  02b7 ae0008        	ldw	x,#8
 960  02ba bf06          	ldw	_l,x
 961                     ; 247 						GPIOA->ODR |= (1<<3);//переключение столбца CLOCK ИЕ8
 963  02bc 72165000      	bset	20480,#3
 964                     ; 248 						delay (20);
 966  02c0 ae0014        	ldw	x,#20
 967  02c3 cd0000        	call	_delay
 969                     ; 249 						GPIOA->ODR &= ~(1<<3);//переключение столбца CLOCK ИЕ8
 971  02c6 72175000      	bres	20480,#3
 972  02ca               L303:
 973                     ; 221 	for ( ip = 0; ip < speed; ++ip){//400  speed
 975  02ca be00          	ldw	x,_ip
 976  02cc 1c0001        	addw	x,#1
 977  02cf bf00          	ldw	_ip,x
 978  02d1               L772:
 981  02d1 be00          	ldw	x,_ip
 982  02d3 b30f          	cpw	x,_speed
 983  02d5 25aa          	jrult	L372
 984                     ; 252 	}
 987  02d7 81            	ret
1018                     ; 254 int main(void)
1018                     ; 255 {
1019                     	switch	.text
1020  02d8               _main:
1024                     ; 264   CLK->ECKR |= (1<<0);//Включение HSE осцилятора
1026  02d8 721050c1      	bset	20673,#0
1027                     ; 265 	CLK->SWCR |= (1<<1);//Разрешаем переключить источник тактирования
1029  02dc 721250c5      	bset	20677,#1
1030                     ; 267 	CLK->CKDIVR = 0b00011000;//Делитель частоты внутреннего осцилятора = 0; тактовой частоты ЦПУ -2  11000
1032  02e0 351850c6      	mov	20678,#24
1033                     ; 269 while (CLK->SWCR & (1<<1) == 1){}// Ждем готовности переключения
1036  02e4 35b450c4      	mov	20676,#180
1037                     ; 270 	CLK->PCKENR1 = 0b00000001;//включаем тактирование I2C
1039  02e8 350150c7      	mov	20679,#1
1040                     ; 273 	GPIOA->DDR |= (1<<3);// | (1<<2) | (1<<1);// | (1<<5) | (1<<4) | (1<<3);//Выход
1042  02ec 72165002      	bset	20482,#3
1043                     ; 274 	GPIOA->CR1 |= (1<<3);// | (1<<2) | (1<<1);// | (1<<5) | (1<<4) | (1<<3);//Выход типа Push-pull
1045  02f0 72165003      	bset	20483,#3
1046                     ; 275 	GPIOA->CR2 |= (1<<3);// | (1<<2) | (1<<1);// | (1<<5) | (1<<4) | (1<<3);//Скорость переключения - до 10 МГц.
1048  02f4 72165004      	bset	20484,#3
1049                     ; 277 	GPIOD->DDR &= ~((1<<5) | (1<<3) | (1<<2) | (1<<1));//Вход | (1<<4)
1051  02f8 c65011        	ld	a,20497
1052  02fb a4d1          	and	a,#209
1053  02fd c75011        	ld	20497,a
1054                     ; 278 	GPIOD->CR1 |= (1<<3) | (1<<2) | (1<<1);//Вход с подтягивающим резистором
1056  0300 c65012        	ld	a,20498
1057  0303 aa0e          	or	a,#14
1058  0305 c75012        	ld	20498,a
1059                     ; 279 	GPIOD->CR2 |= (1<<3) | (1<<2) | (1<<1);//Прерывание включено
1061  0308 c65013        	ld	a,20499
1062  030b aa0e          	or	a,#14
1063  030d c75013        	ld	20499,a
1064                     ; 280 	GPIOD->DDR |= (1<<6) | (1<<4);//Выход
1066  0310 c65011        	ld	a,20497
1067  0313 aa50          	or	a,#80
1068  0315 c75011        	ld	20497,a
1069                     ; 281   GPIOD->CR1 |= (1<<6) | (1<<4);//
1071  0318 c65012        	ld	a,20498
1072  031b aa50          	or	a,#80
1073  031d c75012        	ld	20498,a
1074                     ; 282 	GPIOD->CR2 |= (1<<6) | (1<<4);//
1076  0320 c65013        	ld	a,20499
1077  0323 aa50          	or	a,#80
1078  0325 c75013        	ld	20499,a
1079                     ; 284 	GPIOC->DDR |= (1<<7) | (1<<6) | (1<<5) | (1<<4) | (1<<3);//выход
1081  0328 c6500c        	ld	a,20492
1082  032b aaf8          	or	a,#248
1083  032d c7500c        	ld	20492,a
1084                     ; 285 	GPIOC->CR1 |= (1<<7) | (1<<6) | (1<<5) | (1<<4) | (1<<3);//Выход типа Push-pull 
1086  0330 c6500d        	ld	a,20493
1087  0333 aaf8          	or	a,#248
1088  0335 c7500d        	ld	20493,a
1089                     ; 286 	GPIOC->CR2 |= (1<<7) | (1<<6) | (1<<5) | (1<<4) | (1<<3);//Скорость переключения - до 10 МГц.
1091  0338 c6500e        	ld	a,20494
1092  033b aaf8          	or	a,#248
1093  033d c7500e        	ld	20494,a
1094                     ; 288 	GPIOB->ODR |= (1<<5) | (1<<4);//устанавливаем 1
1096  0340 c65005        	ld	a,20485
1097  0343 aa30          	or	a,#48
1098  0345 c75005        	ld	20485,a
1099                     ; 289 	GPIOB->DDR |= (1<<5) | (1<<4);//Выход
1101  0348 c65007        	ld	a,20487
1102  034b aa30          	or	a,#48
1103  034d c75007        	ld	20487,a
1104                     ; 290 	GPIOB->CR1 &= ~((1<<5) | (1<<4));//Выход типа Open Drain
1106  0350 c65008        	ld	a,20488
1107  0353 a4cf          	and	a,#207
1108  0355 c75008        	ld	20488,a
1109                     ; 291 	GPIOB->CR2 &= ~((1<<5) | (1<<4));//Скорость переключения - до 10 МГц.
1111  0358 c65009        	ld	a,20489
1112  035b a4cf          	and	a,#207
1113  035d c75009        	ld	20489,a
1114                     ; 293 		I2C->CR1 &= ~(1<<0);//отключаем I2C перед настройкой
1116  0360 72115210      	bres	21008,#0
1117                     ; 294 		I2C->FREQR = 8;//частота переферии 8МГц
1119  0364 35085212      	mov	21010,#8
1120                     ; 295 		I2C->CCRL = 80;//100kHz
1122  0368 3550521b      	mov	21019,#80
1123                     ; 296 		I2C->CCRH = 0;
1125  036c 725f521c      	clr	21020
1126                     ; 303 		I2C->TRISER = 9;//rise time 1000ns
1128  0370 3509521d      	mov	21021,#9
1129                     ; 306 		I2C->ITR = 0;                  // enable error interrupts
1131  0374 725f521a      	clr	21018
1132                     ; 307 		I2C->CR2 |= 0x04;              // ACK=1, Ack enable
1134  0378 72145211      	bset	21009,#2
1135                     ; 308 		I2C->CR1 |= 0x01;              // PE=1
1137  037c 72105210      	bset	21008,#0
1138                     ; 315 	GPIOA->ODR |= (1<<3);
1140  0380 72165000      	bset	20480,#3
1141                     ; 316 	delay (20);
1143  0384 ae0014        	ldw	x,#20
1144  0387 cd0000        	call	_delay
1146                     ; 317 	GPIOA->ODR &= ~(1<<3);
1148  038a 72175000      	bres	20480,#3
1149                     ; 319 	delay (5000);
1151  038e ae1388        	ldw	x,#5000
1152  0391 cd0000        	call	_delay
1154                     ; 320     DS1307init();
1156  0394 cd0077        	call	_DS1307init
1158                     ; 321 	delay (5000);	
1160  0397 ae1388        	ldw	x,#5000
1161  039a cd0000        	call	_delay
1163                     ; 323 			delay (50000);
1165  039d aec350        	ldw	x,#50000
1166  03a0 cd0000        	call	_delay
1168                     ; 324 		raand(DS07read());
1170  03a3 cd012a        	call	_DS07read
1172  03a6 cd01cc        	call	_raand
1174                     ; 327 ITC->ISPR2 &= ~((1<<5) | (1<<4));//+
1176  03a9 c67f71        	ld	a,32625
1177  03ac a4cf          	and	a,#207
1178  03ae c77f71        	ld	32625,a
1179                     ; 328 ITC->ISPR2 |= (1<<5) | (1<<4);//+
1181  03b1 c67f71        	ld	a,32625
1182  03b4 aa30          	or	a,#48
1183  03b6 c77f71        	ld	32625,a
1184                     ; 333 EXTI->CR1 = 0b10000000;//Прерывание по заднему фронту
1186  03b9 358050a0      	mov	20640,#128
1187                     ; 336 rim();
1190  03bd 9a            rim
1192  03be               L513:
1193                     ; 344 		fraim_out(fraim, 0);
1195  03be 5f            	clrw	x
1196  03bf 89            	pushw	x
1197  03c0 be08          	ldw	x,_fraim
1198  03c2 cd023c        	call	_fraim_out
1200  03c5 85            	popw	x
1201                     ; 346 swres = 0;//Разрешение переключения скорости
1203  03c6 3f0e          	clr	_swres
1205  03c8 20f4          	jra	L513
1420                     	xdef	_main
1421                     	xdef	_fraim_out
1422                     	xdef	_clear_matrix
1423                     	xdef	_raand
1424                     	xdef	_DS07read
1425                     	xdef	_DS1307init
1426                     	xdef	f_EXTI3_IRQHandler
1427                     	xdef	_delay
1428                     	xdef	_butcount
1429                     	xdef	_speed
1430                     	switch	.ubsct
1431  0000               _ip:
1432  0000 0000          	ds.b	2
1433                     	xdef	_ip
1434                     	xdef	_swres
1435  0002               _SB1:
1436  0002 00            	ds.b	1
1437                     	xdef	_SB1
1438  0003               _hour:
1439  0003 00            	ds.b	1
1440                     	xdef	_hour
1441  0004               _min:
1442  0004 00            	ds.b	1
1443                     	xdef	_min
1444  0005               _sec:
1445  0005 00            	ds.b	1
1446                     	xdef	_sec
1447                     	xdef	_xxx
1448                     	xdef	_xx
1449  0006               _x:
1450  0006 0000          	ds.b	2
1451                     	xdef	_x
1452  0008               _fraim:
1453  0008 0000          	ds.b	2
1454                     	xdef	_fraim
1455                     	xdef	_i
1456                     	xdef	_l
1457                     	xdef	_y
1458                     	xdef	_ii
1459                     	xdef	_iii
1460  000a               _buf:
1461  000a 000000000000  	ds.b	72
1462                     	xdef	_buf
1463  0052               _eff111:
1464  0052 000000000000  	ds.b	72
1465                     	xdef	_eff111
1466  009a               _alar:
1467  009a 00            	ds.b	1
1468                     	xdef	_alar
1469  009b               _next2:
1470  009b 0000          	ds.b	2
1471                     	xdef	_next2
1472  009d               _next:
1473  009d 0000          	ds.b	2
1474                     	xdef	_next
1475                     	xref.b	c_x
1495                     	xref	c_imul
1496                     	end
