   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.12.8.1 - 09 Jan 2023
   3                     ; Generator (Limited) V4.5.5 - 08 Nov 2022
  14                     	bsct
  15  0000               _next:
  16  0000 0002          	dc.w	2
  17  0002               _iii:
  18  0002 0000          	dc.w	0
  19  0004               _ii:
  20  0004 0000          	dc.w	0
  21  0006               _y:
  22  0006 0000          	dc.w	0
  23  0008               _l:
  24  0008 000a          	dc.w	10
  25  000a               _i:
  26  000a 0000          	dc.w	0
  27  000c               _xx:
  28  000c 0000          	dc.w	0
  80                     ; 37 	 void raand(void)
  80                     ; 38 		 {
  82                     	switch	.text
  83  0000               _raand:
  85  0000 5203          	subw	sp,#3
  86       00000003      OFST:	set	3
  89                     ; 41 			next++;
  91  0002 be00          	ldw	x,_next
  92  0004 1c0001        	addw	x,#1
  93  0007 bf00          	ldw	_next,x
  94                     ; 42 		 if (next > 20) next = 2;
  96  0009 be00          	ldw	x,_next
  97  000b a30015        	cpw	x,#21
  98  000e 2505          	jrult	L33
 101  0010 ae0002        	ldw	x,#2
 102  0013 bf00          	ldw	_next,x
 103  0015               L33:
 104                     ; 43 		 for (i2 = 0; i2 < 36; i2++){
 106  0015 0f01          	clr	(OFST-2,sp)
 108  0017               L53:
 109                     ; 44 		 next = next * 1103515;//1103515245
 111  0017 be00          	ldw	x,_next
 112  0019 90aed69b      	ldw	y,#54939
 113  001d cd0000        	call	c_imul
 115  0020 bf00          	ldw	_next,x
 116                     ; 45 		   next2 = (next / 655) * 276;// next2 = (next / 65536) * 2768
 118  0022 be00          	ldw	x,_next
 119  0024 90ae028f      	ldw	y,#655
 120  0028 65            	divw	x,y
 121  0029 90ae0114      	ldw	y,#276
 122  002d cd0000        	call	c_imul
 124  0030 bf96          	ldw	_next2,x
 125                     ; 46 		   xy = next2 % (327 - 8 + 1) + 8;//x = next2 % (32767 - 8 + 1) + 8
 127  0032 be96          	ldw	x,_next2
 128  0034 90ae0140      	ldw	y,#320
 129  0038 65            	divw	x,y
 130  0039 51            	exgw	x,y
 131  003a 1c0008        	addw	x,#8
 132  003d 1f02          	ldw	(OFST-1,sp),x
 134                     ; 47 		   if (xy > 327) xy = xy - 327;//if (x > 32767) x = x - 32767;
 136  003f 9c            	rvf
 137  0040 1e02          	ldw	x,(OFST-1,sp)
 138  0042 a30148        	cpw	x,#328
 139  0045 2f07          	jrslt	L34
 142  0047 1e02          	ldw	x,(OFST-1,sp)
 143  0049 1d0147        	subw	x,#327
 144  004c 1f02          	ldw	(OFST-1,sp),x
 146  004e               L34:
 147                     ; 50 		 eff111[i2] = xy;//0b01010111;
 149  004e 7b01          	ld	a,(OFST-2,sp)
 150  0050 5f            	clrw	x
 151  0051 97            	ld	xl,a
 152  0052 58            	sllw	x
 153  0053 1602          	ldw	y,(OFST-1,sp)
 154  0055 ef4e          	ldw	(_eff111,x),y
 155                     ; 43 		 for (i2 = 0; i2 < 36; i2++){
 157  0057 0c01          	inc	(OFST-2,sp)
 161  0059 7b01          	ld	a,(OFST-2,sp)
 162  005b a124          	cp	a,#36
 163  005d 25b8          	jrult	L53
 164                     ; 52 		 }
 167  005f 5b03          	addw	sp,#3
 168  0061 81            	ret
 202                     ; 54  void delay(int n)
 202                     ; 55  {
 203                     	switch	.text
 204  0062               _delay:
 206  0062 89            	pushw	x
 207       00000000      OFST:	set	0
 210  0063 2007          	jra	L56
 211  0065               L36:
 212                     ; 56          while(n > 10) n--;
 214  0065 1e01          	ldw	x,(OFST+1,sp)
 215  0067 1d0001        	subw	x,#1
 216  006a 1f01          	ldw	(OFST+1,sp),x
 217  006c               L56:
 220  006c 9c            	rvf
 221  006d 1e01          	ldw	x,(OFST+1,sp)
 222  006f a3000b        	cpw	x,#11
 223  0072 2ef1          	jrsge	L36
 224                     ; 57  }
 227  0074 85            	popw	x
 228  0075 81            	ret
 263                     ; 59  void clear_matrix(void)
 263                     ; 60  {
 264                     	switch	.text
 265  0076               _clear_matrix:
 267  0076 88            	push	a
 268       00000001      OFST:	set	1
 271                     ; 62  	 for (i = 0;i < 49; i++){
 273  0077 0f01          	clr	(OFST+0,sp)
 275  0079               L701:
 276                     ; 63  		 eff111[i] = 0;
 278  0079 7b01          	ld	a,(OFST+0,sp)
 279  007b 5f            	clrw	x
 280  007c 97            	ld	xl,a
 281  007d 58            	sllw	x
 282  007e 905f          	clrw	y
 283  0080 ef4e          	ldw	(_eff111,x),y
 284                     ; 62  	 for (i = 0;i < 49; i++){
 286  0082 0c01          	inc	(OFST+0,sp)
 290  0084 7b01          	ld	a,(OFST+0,sp)
 291  0086 a131          	cp	a,#49
 292  0088 25ef          	jrult	L701
 293                     ; 65  }
 296  008a 84            	pop	a
 297  008b 81            	ret
 339                     ; 67 	 	 	void fraim_out (int o, int e){
 340                     	switch	.text
 341  008c               _fraim_out:
 345                     ; 70 	 iii++;
 347  008c be02          	ldw	x,_iii
 348  008e 1c0001        	addw	x,#1
 349  0091 bf02          	ldw	_iii,x
 350                     ; 71 	 	 			buf[35] = eff111[0];//Считали 1ю колонку в буфер
 352  0093 be4e          	ldw	x,_eff111
 353  0095 bf4c          	ldw	_buf+70,x
 354                     ; 74 	 	 			for ( ii = 0; ii < 35; ii++)
 356  0097 5f            	clrw	x
 357  0098 bf04          	ldw	_ii,x
 358  009a               L331:
 359                     ; 77 	 	 				eff111[ii] = eff111[ii + 1];//Сдвинули матрицу на один столбец влево
 361  009a be04          	ldw	x,_ii
 362  009c 58            	sllw	x
 363  009d 9093          	ldw	y,x
 364  009f 90ee50        	ldw	y,(_eff111+2,y)
 365  00a2 ef4e          	ldw	(_eff111,x),y
 366                     ; 74 	 	 			for ( ii = 0; ii < 35; ii++)
 368  00a4 be04          	ldw	x,_ii
 369  00a6 1c0001        	addw	x,#1
 370  00a9 bf04          	ldw	_ii,x
 373  00ab 9c            	rvf
 374  00ac be04          	ldw	x,_ii
 375  00ae a30023        	cpw	x,#35
 376  00b1 2fe7          	jrslt	L331
 377                     ; 80 	 	 			eff111[35] = buf[35];//Записали содержимое буфера (первую колонку) в конец матрицы
 379  00b3 be4c          	ldw	x,_buf+70
 380  00b5 bf94          	ldw	_eff111+70,x
 381                     ; 84 for ( ip = 0; ip < 400; ++ip) 
 383  00b7 5f            	clrw	x
 384  00b8 bf00          	ldw	_ip,x
 385  00ba               L141:
 386                     ; 86           GPIOC->ODR = eff111[l];//
 388  00ba be08          	ldw	x,_l
 389  00bc 58            	sllw	x
 390  00bd e64f          	ld	a,(_eff111+1,x)
 391  00bf c7500a        	ld	20490,a
 392                     ; 88 					GPIOD->ODR &= ~(1<<6);
 394  00c2 721d500f      	bres	20495,#6
 395                     ; 89 					delay (500);//
 397  00c6 ae01f4        	ldw	x,#500
 398  00c9 ad97          	call	_delay
 400                     ; 90 					GPIOD->ODR |= (1<<6);
 402  00cb 721c500f      	bset	20495,#6
 403                     ; 91 					GPIOC->ODR &= ~((1<<7) | (1<<6) | (1<<5) | (1<<4) | (1<<3));//очистка строк ++
 405  00cf c6500a        	ld	a,20490
 406  00d2 a407          	and	a,#7
 407  00d4 c7500a        	ld	20490,a
 408                     ; 92 					l--;
 410  00d7 be08          	ldw	x,_l
 411  00d9 1d0001        	subw	x,#1
 412  00dc bf08          	ldw	_l,x
 413                     ; 93 	 	 			y++;
 415  00de be06          	ldw	x,_y
 416  00e0 1c0001        	addw	x,#1
 417  00e3 bf06          	ldw	_y,x
 418                     ; 94 	 	 			if (y == 8) {
 420  00e5 be06          	ldw	x,_y
 421  00e7 a30008        	cpw	x,#8
 422  00ea 2616          	jrne	L741
 423                     ; 95 	 	 				y = 0;
 425  00ec 5f            	clrw	x
 426  00ed bf06          	ldw	_y,x
 427                     ; 96 	 	 				l = 8;
 429  00ef ae0008        	ldw	x,#8
 430  00f2 bf08          	ldw	_l,x
 431                     ; 97 				GPIOA->ODR |= (1<<3);
 433  00f4 72165000      	bset	20480,#3
 434                     ; 98 				delay (20);
 436  00f8 ae0014        	ldw	x,#20
 437  00fb cd0062        	call	_delay
 439                     ; 99 				GPIOA->ODR &= ~(1<<3);
 441  00fe 72175000      	bres	20480,#3
 442  0102               L741:
 443                     ; 84 for ( ip = 0; ip < 400; ++ip) 
 445  0102 be00          	ldw	x,_ip
 446  0104 1c0001        	addw	x,#1
 447  0107 bf00          	ldw	_ip,x
 450  0109 be00          	ldw	x,_ip
 451  010b a30190        	cpw	x,#400
 452  010e 25aa          	jrult	L141
 453                     ; 102 	 	 	}
 456  0110 81            	ret
 485                     ; 104 int main(void)
 485                     ; 105 {
 486                     	switch	.text
 487  0111               _main:
 491                     ; 110   CLK->ECKR |= (1<<0);//Включение HSE осцилятора
 493  0111 721050c1      	bset	20673,#0
 494                     ; 111 	CLK->SWCR |= (1<<1);//Разрешаем переключить источник тактирования
 496  0115 721250c5      	bset	20677,#1
 497                     ; 113 	CLK->CKDIVR = 0b00011000;//Делитель частоты внутреннего осцилятора = 0; тактовой частоты ЦПУ -2
 499  0119 351850c6      	mov	20678,#24
 500                     ; 115 while (CLK->SWCR & (1<<1) == 1){}// Ждем готовности переключения
 503  011d 35b450c4      	mov	20676,#180
 504                     ; 117 	GPIOA->DDR |= (1<<3);// | (1<<2) | (1<<1);// | (1<<5) | (1<<4) | (1<<3);//Выход
 506  0121 72165002      	bset	20482,#3
 507                     ; 118 	GPIOA->CR1 |= (1<<3);// | (1<<2) | (1<<1);// | (1<<5) | (1<<4) | (1<<3);//Выход типа Push-pull
 509  0125 72165003      	bset	20483,#3
 510                     ; 119 	GPIOA->CR2 |= (1<<3);// | (1<<2) | (1<<1);// | (1<<5) | (1<<4) | (1<<3);//Скорость переключения - до 10 МГц.
 512  0129 72165004      	bset	20484,#3
 513                     ; 121 	GPIOD->DDR &= ~((1<<5) | (1<<4) | (1<<3) | (1<<2) | (1<<1));//Вход
 515  012d c65011        	ld	a,20497
 516  0130 a4c1          	and	a,#193
 517  0132 c75011        	ld	20497,a
 518                     ; 122 	GPIOD->CR1 |= (1<<5) | (1<<4) | (1<<3) | (1<<2) | (1<<1);//Вход с подтягивающим резистором
 520  0135 c65012        	ld	a,20498
 521  0138 aa3e          	or	a,#62
 522  013a c75012        	ld	20498,a
 523                     ; 123 	GPIOD->CR2 |= (1<<5) | (1<<4) | (1<<3) | (1<<2) | (1<<1);//Скорость переключения - до 10 МГц.
 525  013d c65013        	ld	a,20499
 526  0140 aa3e          	or	a,#62
 527  0142 c75013        	ld	20499,a
 528                     ; 124 	GPIOD->DDR |= (1<<6);//Выход
 530  0145 721c5011      	bset	20497,#6
 531                     ; 125   GPIOD->CR1 |= (1<<6);//
 533  0149 721c5012      	bset	20498,#6
 534                     ; 126 	GPIOD->CR2 |= (1<<6);//
 536  014d 721c5013      	bset	20499,#6
 537                     ; 128 	GPIOC->DDR |= (1<<7) | (1<<6) | (1<<5) | (1<<4) | (1<<3);//выход
 539  0151 c6500c        	ld	a,20492
 540  0154 aaf8          	or	a,#248
 541  0156 c7500c        	ld	20492,a
 542                     ; 129 	GPIOC->CR1 |= (1<<7) | (1<<6) | (1<<5) | (1<<4) | (1<<3);//Выход типа Push-pull 
 544  0159 c6500d        	ld	a,20493
 545  015c aaf8          	or	a,#248
 546  015e c7500d        	ld	20493,a
 547                     ; 130 	GPIOC->CR2 |= (1<<7) | (1<<6) | (1<<5) | (1<<4) | (1<<3);//Скорость переключения - до 10 МГц.
 549  0161 c6500e        	ld	a,20494
 550  0164 aaf8          	or	a,#248
 551  0166 c7500e        	ld	20494,a
 552                     ; 133 	 x = I2C->DR;
 554  0169 c65216        	ld	a,21014
 555  016c 5f            	clrw	x
 556  016d 97            	ld	xl,a
 557  016e bf02          	ldw	_x,x
 558                     ; 135 	raand();
 560  0170 cd0000        	call	_raand
 562                     ; 136 	GPIOA->ODR |= (1<<3);
 564  0173 72165000      	bset	20480,#3
 565                     ; 137 	delay (20);
 567  0177 ae0014        	ldw	x,#20
 568  017a cd0062        	call	_delay
 570                     ; 138 	GPIOA->ODR &= ~(1<<3);
 572  017d 72175000      	bres	20480,#3
 573  0181               L161:
 574                     ; 142 	if (iii > 36) {
 576  0181 9c            	rvf
 577  0182 be02          	ldw	x,_iii
 578  0184 a30025        	cpw	x,#37
 579  0187 2f06          	jrslt	L561
 580                     ; 143 	 			raand();
 582  0189 cd0000        	call	_raand
 584                     ; 144 	 			iii = 0;
 586  018c 5f            	clrw	x
 587  018d bf02          	ldw	_iii,x
 588  018f               L561:
 589                     ; 146 			fraim_out(fraim, 0);
 591  018f 5f            	clrw	x
 592  0190 89            	pushw	x
 593  0191 be04          	ldw	x,_fraim
 594  0193 cd008c        	call	_fraim_out
 596  0196 85            	popw	x
 598  0197 20e8          	jra	L161
 732                     	xdef	_main
 733                     	xdef	_fraim_out
 734                     	xdef	_clear_matrix
 735                     	xdef	_delay
 736                     	xdef	_raand
 737                     	switch	.ubsct
 738  0000               _ip:
 739  0000 0000          	ds.b	2
 740                     	xdef	_ip
 741                     	xdef	_xx
 742  0002               _x:
 743  0002 0000          	ds.b	2
 744                     	xdef	_x
 745  0004               _fraim:
 746  0004 0000          	ds.b	2
 747                     	xdef	_fraim
 748                     	xdef	_i
 749                     	xdef	_l
 750                     	xdef	_y
 751                     	xdef	_ii
 752                     	xdef	_iii
 753  0006               _buf:
 754  0006 000000000000  	ds.b	72
 755                     	xdef	_buf
 756  004e               _eff111:
 757  004e 000000000000  	ds.b	72
 758                     	xdef	_eff111
 759  0096               _next2:
 760  0096 0000          	ds.b	2
 761                     	xdef	_next2
 762                     	xdef	_next
 763                     	xref.b	c_x
 783                     	xref	c_imul
 784                     	end
