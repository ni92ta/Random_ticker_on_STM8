   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.12.8.1 - 09 Jan 2023
   3                     ; Generator (Limited) V4.5.5 - 08 Nov 2022
  14                     	bsct
  15  0000               _next:
  16  0000 0002          	dc.w	2
  17  0002               _numbers:
  18  0002 00            	dc.b	0
  19  0003 70            	dc.b	112
  20  0004 88            	dc.b	136
  21  0005 70            	dc.b	112
  22  0006 00            	dc.b	0
  23  0007 00            	dc.b	0
  24  0008 88            	dc.b	136
  25  0009 f8            	dc.b	248
  26  000a 08            	dc.b	8
  27  000b 00            	dc.b	0
  28  000c 00            	dc.b	0
  29  000d 98            	dc.b	152
  30  000e a8            	dc.b	168
  31  000f c8            	dc.b	200
  32  0010 00            	dc.b	0
  33  0011 00            	dc.b	0
  34  0012 a8            	dc.b	168
  35  0013 a8            	dc.b	168
  36  0014 70            	dc.b	112
  37  0015 00            	dc.b	0
  38  0016 00            	dc.b	0
  39  0017 e0            	dc.b	224
  40  0018 20            	dc.b	32
  41  0019 f8            	dc.b	248
  42  001a 00            	dc.b	0
  43  001b 00            	dc.b	0
  44  001c e8            	dc.b	232
  45  001d a8            	dc.b	168
  46  001e b8            	dc.b	184
  47  001f 00            	dc.b	0
  48  0020 00            	dc.b	0
  49  0021 78            	dc.b	120
  50  0022 a8            	dc.b	168
  51  0023 b8            	dc.b	184
  52  0024 00            	dc.b	0
  53  0025 00            	ds.b	1
  54  0026               _iii:
  55  0026 0000          	dc.w	0
  56  0028               _ii:
  57  0028 0000          	dc.w	0
  58  002a               _y:
  59  002a 0000          	dc.w	0
  60  002c               _l:
  61  002c 000a          	dc.w	10
  62  002e               _i:
  63  002e 0000          	dc.w	0
  64  0030               _xx:
  65  0030 0000          	dc.w	0
 117                     ; 32 	 void raand(void)
 117                     ; 33 		 {
 119                     	switch	.text
 120  0000               _raand:
 122  0000 5203          	subw	sp,#3
 123       00000003      OFST:	set	3
 126                     ; 36 			next++;
 128  0002 be00          	ldw	x,_next
 129  0004 1c0001        	addw	x,#1
 130  0007 bf00          	ldw	_next,x
 131                     ; 37 		 if (next > 20) next = 2;
 133  0009 be00          	ldw	x,_next
 134  000b a30015        	cpw	x,#21
 135  000e 2505          	jrult	L33
 138  0010 ae0002        	ldw	x,#2
 139  0013 bf00          	ldw	_next,x
 140  0015               L33:
 141                     ; 38 		 for (i2 = 0; i2 < 36; i2++){
 143  0015 0f01          	clr	(OFST-2,sp)
 145  0017               L53:
 146                     ; 39 		 next = next * 1103515;//1103515245
 148  0017 be00          	ldw	x,_next
 149  0019 90aed69b      	ldw	y,#54939
 150  001d cd0000        	call	c_imul
 152  0020 bf00          	ldw	_next,x
 153                     ; 40 		   next2 = (next / 655) * 276;// next2 = (next / 65536) * 2768
 155  0022 be00          	ldw	x,_next
 156  0024 90ae028f      	ldw	y,#655
 157  0028 65            	divw	x,y
 158  0029 90ae0114      	ldw	y,#276
 159  002d cd0000        	call	c_imul
 161  0030 bf96          	ldw	_next2,x
 162                     ; 41 		   xy = next2 % (327 - 8 + 1) + 8;//x = next2 % (32767 - 8 + 1) + 8
 164  0032 be96          	ldw	x,_next2
 165  0034 90ae0140      	ldw	y,#320
 166  0038 65            	divw	x,y
 167  0039 51            	exgw	x,y
 168  003a 1c0008        	addw	x,#8
 169  003d 1f02          	ldw	(OFST-1,sp),x
 171                     ; 42 		   if (xy > 327) xy = xy - 327;//if (x > 32767) x = x - 32767;
 173  003f 9c            	rvf
 174  0040 1e02          	ldw	x,(OFST-1,sp)
 175  0042 a30148        	cpw	x,#328
 176  0045 2f07          	jrslt	L34
 179  0047 1e02          	ldw	x,(OFST-1,sp)
 180  0049 1d0147        	subw	x,#327
 181  004c 1f02          	ldw	(OFST-1,sp),x
 183  004e               L34:
 184                     ; 45 		 eff111[i2] = xy;//0b01010111;
 186  004e 7b01          	ld	a,(OFST-2,sp)
 187  0050 5f            	clrw	x
 188  0051 97            	ld	xl,a
 189  0052 58            	sllw	x
 190  0053 1602          	ldw	y,(OFST-1,sp)
 191  0055 ef4e          	ldw	(_eff111,x),y
 192                     ; 38 		 for (i2 = 0; i2 < 36; i2++){
 194  0057 0c01          	inc	(OFST-2,sp)
 198  0059 7b01          	ld	a,(OFST-2,sp)
 199  005b a124          	cp	a,#36
 200  005d 25b8          	jrult	L53
 201                     ; 47 		 }
 204  005f 5b03          	addw	sp,#3
 205  0061 81            	ret
 239                     ; 49  void delay(int n)
 239                     ; 50  {
 240                     	switch	.text
 241  0062               _delay:
 243  0062 89            	pushw	x
 244       00000000      OFST:	set	0
 247  0063 2007          	jra	L56
 248  0065               L36:
 249                     ; 51          while(n > 10) n--;
 251  0065 1e01          	ldw	x,(OFST+1,sp)
 252  0067 1d0001        	subw	x,#1
 253  006a 1f01          	ldw	(OFST+1,sp),x
 254  006c               L56:
 257  006c 9c            	rvf
 258  006d 1e01          	ldw	x,(OFST+1,sp)
 259  006f a3000b        	cpw	x,#11
 260  0072 2ef1          	jrsge	L36
 261                     ; 52  }
 264  0074 85            	popw	x
 265  0075 81            	ret
 300                     ; 54  void clear_matrix(void)
 300                     ; 55  {
 301                     	switch	.text
 302  0076               _clear_matrix:
 304  0076 88            	push	a
 305       00000001      OFST:	set	1
 308                     ; 57  	 for (i = 0;i < 49; i++){
 310  0077 0f01          	clr	(OFST+0,sp)
 312  0079               L701:
 313                     ; 58  		 eff111[i] = 0;
 315  0079 7b01          	ld	a,(OFST+0,sp)
 316  007b 5f            	clrw	x
 317  007c 97            	ld	xl,a
 318  007d 58            	sllw	x
 319  007e 905f          	clrw	y
 320  0080 ef4e          	ldw	(_eff111,x),y
 321                     ; 57  	 for (i = 0;i < 49; i++){
 323  0082 0c01          	inc	(OFST+0,sp)
 327  0084 7b01          	ld	a,(OFST+0,sp)
 328  0086 a131          	cp	a,#49
 329  0088 25ef          	jrult	L701
 330                     ; 60  }
 333  008a 84            	pop	a
 334  008b 81            	ret
 376                     ; 62 	 	 	void fraim_out (int o, int e){
 377                     	switch	.text
 378  008c               _fraim_out:
 382                     ; 66 	 iii++;
 384  008c be26          	ldw	x,_iii
 385  008e 1c0001        	addw	x,#1
 386  0091 bf26          	ldw	_iii,x
 387                     ; 67 	 	 			buf[35] = eff111[0];//Считали 1ю колонку в буфер
 389  0093 be4e          	ldw	x,_eff111
 390  0095 bf4c          	ldw	_buf+70,x
 391                     ; 70 	 	 			for ( ii = 0; ii < 35; ii++)
 393  0097 5f            	clrw	x
 394  0098 bf28          	ldw	_ii,x
 395  009a               L331:
 396                     ; 72 	 	 				eff111[ii] = eff111[ii + 1];//Сдвинули матрицу на один столбец влево
 398  009a be28          	ldw	x,_ii
 399  009c 58            	sllw	x
 400  009d 9093          	ldw	y,x
 401  009f 90ee50        	ldw	y,(_eff111+2,y)
 402  00a2 ef4e          	ldw	(_eff111,x),y
 403                     ; 70 	 	 			for ( ii = 0; ii < 35; ii++)
 405  00a4 be28          	ldw	x,_ii
 406  00a6 1c0001        	addw	x,#1
 407  00a9 bf28          	ldw	_ii,x
 410  00ab 9c            	rvf
 411  00ac be28          	ldw	x,_ii
 412  00ae a30023        	cpw	x,#35
 413  00b1 2fe7          	jrslt	L331
 414                     ; 75 	 	 			eff111[35] = buf[35];//Записали содержимое буфера (первую колонку) в конец матрицы
 416  00b3 be4c          	ldw	x,_buf+70
 417  00b5 bf94          	ldw	_eff111+70,x
 418                     ; 79 for ( ip = 0; ip < 400; ++ip) 
 420  00b7 5f            	clrw	x
 421  00b8 bf00          	ldw	_ip,x
 422  00ba               L141:
 423                     ; 81           GPIOC->ODR = eff111[l];//
 425  00ba be2c          	ldw	x,_l
 426  00bc 58            	sllw	x
 427  00bd e64f          	ld	a,(_eff111+1,x)
 428  00bf c7500a        	ld	20490,a
 429                     ; 83 					GPIOD->ODR &= ~(1<<6);
 431  00c2 721d500f      	bres	20495,#6
 432                     ; 84 					delay (500);//
 434  00c6 ae01f4        	ldw	x,#500
 435  00c9 ad97          	call	_delay
 437                     ; 85 					GPIOD->ODR |= (1<<6);
 439  00cb 721c500f      	bset	20495,#6
 440                     ; 86 					GPIOC->ODR &= ~((1<<7) | (1<<6) | (1<<5) | (1<<4) | (1<<3));//очистка строк ++
 442  00cf c6500a        	ld	a,20490
 443  00d2 a407          	and	a,#7
 444  00d4 c7500a        	ld	20490,a
 445                     ; 87 					l--;
 447  00d7 be2c          	ldw	x,_l
 448  00d9 1d0001        	subw	x,#1
 449  00dc bf2c          	ldw	_l,x
 450                     ; 88 	 	 			y++;
 452  00de be2a          	ldw	x,_y
 453  00e0 1c0001        	addw	x,#1
 454  00e3 bf2a          	ldw	_y,x
 455                     ; 89 	 	 			if (y == 8) {
 457  00e5 be2a          	ldw	x,_y
 458  00e7 a30008        	cpw	x,#8
 459  00ea 2616          	jrne	L741
 460                     ; 90 	 	 				y = 0;
 462  00ec 5f            	clrw	x
 463  00ed bf2a          	ldw	_y,x
 464                     ; 91 	 	 				l = 8;
 466  00ef ae0008        	ldw	x,#8
 467  00f2 bf2c          	ldw	_l,x
 468                     ; 92 				GPIOA->ODR |= (1<<3);
 470  00f4 72165000      	bset	20480,#3
 471                     ; 93 				delay (20);
 473  00f8 ae0014        	ldw	x,#20
 474  00fb cd0062        	call	_delay
 476                     ; 94 				GPIOA->ODR &= ~(1<<3);
 478  00fe 72175000      	bres	20480,#3
 479  0102               L741:
 480                     ; 79 for ( ip = 0; ip < 400; ++ip) 
 482  0102 be00          	ldw	x,_ip
 483  0104 1c0001        	addw	x,#1
 484  0107 bf00          	ldw	_ip,x
 487  0109 be00          	ldw	x,_ip
 488  010b a30190        	cpw	x,#400
 489  010e 25aa          	jrult	L141
 490                     ; 97 	 	 	}
 493  0110 81            	ret
 521                     ; 99 int main(void)
 521                     ; 100 {
 522                     	switch	.text
 523  0111               _main:
 527                     ; 105   CLK->ECKR |= (1<<0);//Включение HSE осцилятора
 529  0111 721050c1      	bset	20673,#0
 530                     ; 106 	CLK->SWCR |= (1<<1);//Разрешаем переключить источник тактирования
 532  0115 721250c5      	bset	20677,#1
 533                     ; 108 	CLK->CKDIVR = 0b00011000;//Делитель частоты внутреннего осцилятора = 0; тактовой частоты ЦПУ -2
 535  0119 351850c6      	mov	20678,#24
 536                     ; 110 while (CLK->SWCR & (1<<1) == 1){}// Ждем готовности переключения
 539  011d 35b450c4      	mov	20676,#180
 540                     ; 112 	GPIOA->DDR |= (1<<3);// | (1<<2) | (1<<1);// | (1<<5) | (1<<4) | (1<<3);//Выход
 542  0121 72165002      	bset	20482,#3
 543                     ; 113 	GPIOA->CR1 |= (1<<3);// | (1<<2) | (1<<1);// | (1<<5) | (1<<4) | (1<<3);//Выход типа Push-pull
 545  0125 72165003      	bset	20483,#3
 546                     ; 114 	GPIOA->CR2 |= (1<<3);// | (1<<2) | (1<<1);// | (1<<5) | (1<<4) | (1<<3);//Скорость переключения - до 10 МГц.
 548  0129 72165004      	bset	20484,#3
 549                     ; 116 	GPIOD->DDR &= ~((1<<5) | (1<<4) | (1<<3) | (1<<2) | (1<<1));//Вход
 551  012d c65011        	ld	a,20497
 552  0130 a4c1          	and	a,#193
 553  0132 c75011        	ld	20497,a
 554                     ; 117 	GPIOD->CR1 |= (1<<5) | (1<<4) | (1<<3) | (1<<2) | (1<<1);//Вход с подтягивающим резистором
 556  0135 c65012        	ld	a,20498
 557  0138 aa3e          	or	a,#62
 558  013a c75012        	ld	20498,a
 559                     ; 118 	GPIOD->CR2 |= (1<<5) | (1<<4) | (1<<3) | (1<<2) | (1<<1);//Скорость переключения - до 10 МГц.
 561  013d c65013        	ld	a,20499
 562  0140 aa3e          	or	a,#62
 563  0142 c75013        	ld	20499,a
 564                     ; 119 	GPIOD->DDR |= (1<<6);//Выход
 566  0145 721c5011      	bset	20497,#6
 567                     ; 120   GPIOD->CR1 |= (1<<6);//
 569  0149 721c5012      	bset	20498,#6
 570                     ; 121 	GPIOD->CR2 |= (1<<6);//
 572  014d 721c5013      	bset	20499,#6
 573                     ; 123 	GPIOC->DDR |= (1<<7) | (1<<6) | (1<<5) | (1<<4) | (1<<3);//выход
 575  0151 c6500c        	ld	a,20492
 576  0154 aaf8          	or	a,#248
 577  0156 c7500c        	ld	20492,a
 578                     ; 124 	GPIOC->CR1 |= (1<<7) | (1<<6) | (1<<5) | (1<<4) | (1<<3);//Выход типа Push-pull 
 580  0159 c6500d        	ld	a,20493
 581  015c aaf8          	or	a,#248
 582  015e c7500d        	ld	20493,a
 583                     ; 125 	GPIOC->CR2 |= (1<<7) | (1<<6) | (1<<5) | (1<<4) | (1<<3);//Скорость переключения - до 10 МГц.
 585  0161 c6500e        	ld	a,20494
 586  0164 aaf8          	or	a,#248
 587  0166 c7500e        	ld	20494,a
 588                     ; 127 	raand();
 590  0169 cd0000        	call	_raand
 592                     ; 128 	GPIOA->ODR |= (1<<3);
 594  016c 72165000      	bset	20480,#3
 595                     ; 129 	delay (20);
 597  0170 ae0014        	ldw	x,#20
 598  0173 cd0062        	call	_delay
 600                     ; 130 	GPIOA->ODR &= ~(1<<3);
 602  0176 72175000      	bres	20480,#3
 603  017a               L161:
 604                     ; 134 	if (iii > 36) {
 606  017a 9c            	rvf
 607  017b be26          	ldw	x,_iii
 608  017d a30025        	cpw	x,#37
 609  0180 2f06          	jrslt	L561
 610                     ; 135 	 			raand();
 612  0182 cd0000        	call	_raand
 614                     ; 136 	 			iii = 0;
 616  0185 5f            	clrw	x
 617  0186 bf26          	ldw	_iii,x
 618  0188               L561:
 619                     ; 138 			fraim_out(fraim, 0);
 621  0188 5f            	clrw	x
 622  0189 89            	pushw	x
 623  018a be04          	ldw	x,_fraim
 624  018c cd008c        	call	_fraim_out
 626  018f 85            	popw	x
 628  0190 20e8          	jra	L161
 772                     	xdef	_main
 773                     	xdef	_fraim_out
 774                     	xdef	_clear_matrix
 775                     	xdef	_delay
 776                     	xdef	_raand
 777                     	switch	.ubsct
 778  0000               _ip:
 779  0000 0000          	ds.b	2
 780                     	xdef	_ip
 781                     	xdef	_xx
 782  0002               _x:
 783  0002 0000          	ds.b	2
 784                     	xdef	_x
 785  0004               _fraim:
 786  0004 0000          	ds.b	2
 787                     	xdef	_fraim
 788                     	xdef	_i
 789                     	xdef	_l
 790                     	xdef	_y
 791                     	xdef	_ii
 792                     	xdef	_iii
 793  0006               _buf:
 794  0006 000000000000  	ds.b	72
 795                     	xdef	_buf
 796                     	xdef	_numbers
 797  004e               _eff111:
 798  004e 000000000000  	ds.b	72
 799                     	xdef	_eff111
 800  0096               _next2:
 801  0096 0000          	ds.b	2
 802                     	xdef	_next2
 803                     	xdef	_next
 804                     	xref.b	c_x
 824                     	xref	c_imul
 825                     	end
