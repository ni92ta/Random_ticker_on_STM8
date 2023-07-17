   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.12.8.1 - 09 Jan 2023
   3                     ; Generator (Limited) V4.5.5 - 08 Nov 2022
  14                     	bsct
  15  0000               _next:
  16  0000 0002          	dc.w	2
  17  0002               _eff111:
  18  0002 04a8          	dc.w	1192
  19  0004 000000000000  	ds.b	70
  20  004a               _iii:
  21  004a 0000          	dc.w	0
  22  004c               _ii:
  23  004c 0000          	dc.w	0
  24  004e               _y:
  25  004e 0000          	dc.w	0
  26  0050               _l:
  27  0050 000a          	dc.w	10
  28  0052               _i:
  29  0052 0000          	dc.w	0
  30  0054               _xx:
  31  0054 0000          	dc.w	0
  83                     ; 33 	 void raand(void)
  83                     ; 34 		 {
  85                     	switch	.text
  86  0000               _raand:
  88  0000 5203          	subw	sp,#3
  89       00000003      OFST:	set	3
  92                     ; 37 			next++;
  94  0002 be00          	ldw	x,_next
  95  0004 1c0001        	addw	x,#1
  96  0007 bf00          	ldw	_next,x
  97                     ; 38 		 if (next > 20) next = 2;
  99  0009 be00          	ldw	x,_next
 100  000b a30015        	cpw	x,#21
 101  000e 2505          	jrult	L33
 104  0010 ae0002        	ldw	x,#2
 105  0013 bf00          	ldw	_next,x
 106  0015               L33:
 107                     ; 39 		 for (i2 = 0; i2 < 36; i2++){
 109  0015 0f01          	clr	(OFST-2,sp)
 111  0017               L53:
 112                     ; 40 		 next = next * 1103515;//1103515245
 114  0017 be00          	ldw	x,_next
 115  0019 90aed69b      	ldw	y,#54939
 116  001d cd0000        	call	c_imul
 118  0020 bf00          	ldw	_next,x
 119                     ; 41 		   next2 = (next / 655) * 276;// next2 = (next / 65536) * 2768
 121  0022 be00          	ldw	x,_next
 122  0024 90ae028f      	ldw	y,#655
 123  0028 65            	divw	x,y
 124  0029 90ae0114      	ldw	y,#276
 125  002d cd0000        	call	c_imul
 127  0030 bf4e          	ldw	_next2,x
 128                     ; 42 		   xy = next2 % (327 - 8 + 1) + 8;//x = next2 % (32767 - 8 + 1) + 8
 130  0032 be4e          	ldw	x,_next2
 131  0034 90ae0140      	ldw	y,#320
 132  0038 65            	divw	x,y
 133  0039 51            	exgw	x,y
 134  003a 1c0008        	addw	x,#8
 135  003d 1f02          	ldw	(OFST-1,sp),x
 137                     ; 43 		   if (xy > 327) xy = xy - 327;//if (x > 32767) x = x - 32767;
 139  003f 9c            	rvf
 140  0040 1e02          	ldw	x,(OFST-1,sp)
 141  0042 a30148        	cpw	x,#328
 142  0045 2f07          	jrslt	L34
 145  0047 1e02          	ldw	x,(OFST-1,sp)
 146  0049 1d0147        	subw	x,#327
 147  004c 1f02          	ldw	(OFST-1,sp),x
 149  004e               L34:
 150                     ; 46 		 eff111[i2] = xy;//0b01010111;
 152  004e 7b01          	ld	a,(OFST-2,sp)
 153  0050 5f            	clrw	x
 154  0051 97            	ld	xl,a
 155  0052 58            	sllw	x
 156  0053 1602          	ldw	y,(OFST-1,sp)
 157  0055 ef02          	ldw	(_eff111,x),y
 158                     ; 39 		 for (i2 = 0; i2 < 36; i2++){
 160  0057 0c01          	inc	(OFST-2,sp)
 164  0059 7b01          	ld	a,(OFST-2,sp)
 165  005b a124          	cp	a,#36
 166  005d 25b8          	jrult	L53
 167                     ; 48 		 }
 170  005f 5b03          	addw	sp,#3
 171  0061 81            	ret
 205                     ; 50  void delay(int n)
 205                     ; 51  {
 206                     	switch	.text
 207  0062               _delay:
 209  0062 89            	pushw	x
 210       00000000      OFST:	set	0
 213  0063 2007          	jra	L56
 214  0065               L36:
 215                     ; 52          while(n > 10) n--;
 217  0065 1e01          	ldw	x,(OFST+1,sp)
 218  0067 1d0001        	subw	x,#1
 219  006a 1f01          	ldw	(OFST+1,sp),x
 220  006c               L56:
 223  006c 9c            	rvf
 224  006d 1e01          	ldw	x,(OFST+1,sp)
 225  006f a3000b        	cpw	x,#11
 226  0072 2ef1          	jrsge	L36
 227                     ; 53  }
 230  0074 85            	popw	x
 231  0075 81            	ret
 266                     ; 55  void clear_matrix(void)
 266                     ; 56  {
 267                     	switch	.text
 268  0076               _clear_matrix:
 270  0076 88            	push	a
 271       00000001      OFST:	set	1
 274                     ; 58  	 for (i = 0;i < 49; i++){
 276  0077 0f01          	clr	(OFST+0,sp)
 278  0079               L701:
 279                     ; 59  		 eff111[i] = 0;
 281  0079 7b01          	ld	a,(OFST+0,sp)
 282  007b 5f            	clrw	x
 283  007c 97            	ld	xl,a
 284  007d 58            	sllw	x
 285  007e 905f          	clrw	y
 286  0080 ef02          	ldw	(_eff111,x),y
 287                     ; 58  	 for (i = 0;i < 49; i++){
 289  0082 0c01          	inc	(OFST+0,sp)
 293  0084 7b01          	ld	a,(OFST+0,sp)
 294  0086 a131          	cp	a,#49
 295  0088 25ef          	jrult	L701
 296                     ; 61  }
 299  008a 84            	pop	a
 300  008b 81            	ret
 342                     ; 63 	 	 	void fraim_out (int o, int e){
 343                     	switch	.text
 344  008c               _fraim_out:
 348                     ; 67 	 iii++;
 350  008c be4a          	ldw	x,_iii
 351  008e 1c0001        	addw	x,#1
 352  0091 bf4a          	ldw	_iii,x
 353                     ; 68 	 	 			buf[35] = eff111[0]; // Считали 1ю колонку в буфер
 355  0093 be02          	ldw	x,_eff111
 356  0095 bf4c          	ldw	_buf+70,x
 357                     ; 70 	 	 			for ( ii = 0; ii < 35; ii++)//
 359  0097 5f            	clrw	x
 360  0098 bf4c          	ldw	_ii,x
 361  009a               L331:
 362                     ; 72 	 	 				eff111[ii] = eff111[ii + 1]; // Сдвинули матрицу на один столбец влево
 364  009a be4c          	ldw	x,_ii
 365  009c 58            	sllw	x
 366  009d 9093          	ldw	y,x
 367  009f 90ee04        	ldw	y,(_eff111+2,y)
 368  00a2 ef02          	ldw	(_eff111,x),y
 369                     ; 70 	 	 			for ( ii = 0; ii < 35; ii++)//
 371  00a4 be4c          	ldw	x,_ii
 372  00a6 1c0001        	addw	x,#1
 373  00a9 bf4c          	ldw	_ii,x
 376  00ab 9c            	rvf
 377  00ac be4c          	ldw	x,_ii
 378  00ae a30023        	cpw	x,#35
 379  00b1 2fe7          	jrslt	L331
 380                     ; 74 	 	 			eff111[35] = buf[35]; // Записали содержимое буфера (первую колонку) в конец матрицы
 382  00b3 be4c          	ldw	x,_buf+70
 383  00b5 bf48          	ldw	_eff111+70,x
 384                     ; 77 for ( ip = 0; ip < 20000; ++ip) 
 386  00b7 5f            	clrw	x
 387  00b8 bf00          	ldw	_ip,x
 388  00ba               L141:
 389                     ; 79           GPIOC->ODR = eff111[l];// & 0b11111000;
 391  00ba be50          	ldw	x,_l
 392  00bc 58            	sllw	x
 393  00bd e603          	ld	a,(_eff111+1,x)
 394  00bf c7500a        	ld	20490,a
 395                     ; 80 					GPIOD->ODR &= ~(1<<6);
 397  00c2 721d500f      	bres	20495,#6
 398                     ; 81 					delay (300);
 400  00c6 ae012c        	ldw	x,#300
 401  00c9 ad97          	call	_delay
 403                     ; 82 					GPIOD->ODR |= (1<<6);
 405  00cb 721c500f      	bset	20495,#6
 406                     ; 83 					l--;
 408  00cf be50          	ldw	x,_l
 409  00d1 1d0001        	subw	x,#1
 410  00d4 bf50          	ldw	_l,x
 411                     ; 84 	 	 			y++;
 413  00d6 be4e          	ldw	x,_y
 414  00d8 1c0001        	addw	x,#1
 415  00db bf4e          	ldw	_y,x
 416                     ; 85 	 	 			if (y == 8) {
 418  00dd be4e          	ldw	x,_y
 419  00df a30008        	cpw	x,#8
 420  00e2 261e          	jrne	L741
 421                     ; 86 						GPIOC->ODR |= (1<<7) | (1<<6) | (1<<5) | (1<<4) | (1<<3);//очистка строк ++
 423  00e4 c6500a        	ld	a,20490
 424  00e7 aaf8          	or	a,#248
 425  00e9 c7500a        	ld	20490,a
 426                     ; 87 	 	 				y = 0;
 428  00ec 5f            	clrw	x
 429  00ed bf4e          	ldw	_y,x
 430                     ; 88 	 	 				l = 8;
 432  00ef ae0008        	ldw	x,#8
 433  00f2 bf50          	ldw	_l,x
 434                     ; 89 				GPIOA->ODR |= (1<<3);
 436  00f4 72165000      	bset	20480,#3
 437                     ; 90 				delay (20);
 439  00f8 ae0014        	ldw	x,#20
 440  00fb cd0062        	call	_delay
 442                     ; 91 				GPIOA->ODR &= ~(1<<3);
 444  00fe 72175000      	bres	20480,#3
 445  0102               L741:
 446                     ; 77 for ( ip = 0; ip < 20000; ++ip) 
 448  0102 be00          	ldw	x,_ip
 449  0104 1c0001        	addw	x,#1
 450  0107 bf00          	ldw	_ip,x
 453  0109 be00          	ldw	x,_ip
 454  010b a34e20        	cpw	x,#20000
 455  010e 25aa          	jrult	L141
 456                     ; 94 	 	 	}
 459  0110 81            	ret
 487                     ; 96 int main(void)
 487                     ; 97 {
 488                     	switch	.text
 489  0111               _main:
 493                     ; 102   CLK->ECKR |= (1<<0);//Включение HSE осцилятора
 495  0111 721050c1      	bset	20673,#0
 496                     ; 103 	CLK->SWCR |= (1<<1);//Разрешаем переключить источник тактирования
 498  0115 721250c5      	bset	20677,#1
 499                     ; 105 	CLK->CKDIVR = 0b00011000;//Делитель частоты внутреннего осцилятора = 0; тактовой частоты ЦПУ -2
 501  0119 351850c6      	mov	20678,#24
 502                     ; 107 while (CLK->SWCR & (1<<1) == 1){}// Ждем готовности переключения
 505  011d 35b450c4      	mov	20676,#180
 506                     ; 109 	GPIOA->DDR |= (1<<3);// | (1<<2) | (1<<1);// | (1<<5) | (1<<4) | (1<<3);//Выход
 508  0121 72165002      	bset	20482,#3
 509                     ; 110 	GPIOA->CR1 |= (1<<3);// | (1<<2) | (1<<1);// | (1<<5) | (1<<4) | (1<<3);//Выход типа Push-pull
 511  0125 72165003      	bset	20483,#3
 512                     ; 111 	GPIOA->CR2 |= (1<<3);// | (1<<2) | (1<<1);// | (1<<5) | (1<<4) | (1<<3);//Скорость переключения - до 10 МГц.
 514  0129 72165004      	bset	20484,#3
 515                     ; 113 	GPIOD->DDR &= ~((1<<5) | (1<<4) | (1<<3) | (1<<2) | (1<<1));//Вход
 517  012d c65011        	ld	a,20497
 518  0130 a4c1          	and	a,#193
 519  0132 c75011        	ld	20497,a
 520                     ; 114 	GPIOD->CR1 |= (1<<5) | (1<<4) | (1<<3) | (1<<2) | (1<<1);//Вход с подтягивающим резистором
 522  0135 c65012        	ld	a,20498
 523  0138 aa3e          	or	a,#62
 524  013a c75012        	ld	20498,a
 525                     ; 115 	GPIOD->CR2 |= (1<<5) | (1<<4) | (1<<3) | (1<<2) | (1<<1);//Скорость переключения - до 10 МГц.
 527  013d c65013        	ld	a,20499
 528  0140 aa3e          	or	a,#62
 529  0142 c75013        	ld	20499,a
 530                     ; 116 	GPIOD->DDR |= (1<<6);//Выход
 532  0145 721c5011      	bset	20497,#6
 533                     ; 117   GPIOD->CR1 |= (1<<6);//
 535  0149 721c5012      	bset	20498,#6
 536                     ; 118 	GPIOD->CR2 |= (1<<6);//
 538  014d 721c5013      	bset	20499,#6
 539                     ; 120 	GPIOC->DDR |= (1<<7) | (1<<6) | (1<<5) | (1<<4) | (1<<3);//выход
 541  0151 c6500c        	ld	a,20492
 542  0154 aaf8          	or	a,#248
 543  0156 c7500c        	ld	20492,a
 544                     ; 121 	GPIOC->CR1 |= (1<<7) | (1<<6) | (1<<5) | (1<<4) | (1<<3);//Выход типа Push-pull 
 546  0159 c6500d        	ld	a,20493
 547  015c aaf8          	or	a,#248
 548  015e c7500d        	ld	20493,a
 549                     ; 122 	GPIOC->CR2 |= (1<<7) | (1<<6) | (1<<5) | (1<<4) | (1<<3);//Скорость переключения - до 10 МГц.
 551  0161 c6500e        	ld	a,20494
 552  0164 aaf8          	or	a,#248
 553  0166 c7500e        	ld	20494,a
 554                     ; 124 	raand();
 556  0169 cd0000        	call	_raand
 558                     ; 125 	GPIOA->ODR |= (1<<3);
 560  016c 72165000      	bset	20480,#3
 561                     ; 126 	delay (20);
 563  0170 ae0014        	ldw	x,#20
 564  0173 cd0062        	call	_delay
 566                     ; 127 	GPIOA->ODR &= ~(1<<3);
 568  0176 72175000      	bres	20480,#3
 569  017a               L161:
 570                     ; 131 	if (iii > 36) {
 572  017a 9c            	rvf
 573  017b be4a          	ldw	x,_iii
 574  017d a30025        	cpw	x,#37
 575  0180 2f06          	jrslt	L561
 576                     ; 132 	 			raand();
 578  0182 cd0000        	call	_raand
 580                     ; 133 	 			iii = 0;
 582  0185 5f            	clrw	x
 583  0186 bf4a          	ldw	_iii,x
 584  0188               L561:
 585                     ; 135 			fraim_out(fraim, 0);  
 587  0188 5f            	clrw	x
 588  0189 89            	pushw	x
 589  018a be04          	ldw	x,_fraim
 590  018c cd008c        	call	_fraim_out
 592  018f 85            	popw	x
 594  0190 20e8          	jra	L161
 728                     	xdef	_main
 729                     	xdef	_fraim_out
 730                     	xdef	_clear_matrix
 731                     	xdef	_delay
 732                     	xdef	_raand
 733                     	switch	.ubsct
 734  0000               _ip:
 735  0000 0000          	ds.b	2
 736                     	xdef	_ip
 737                     	xdef	_xx
 738  0002               _x:
 739  0002 0000          	ds.b	2
 740                     	xdef	_x
 741  0004               _fraim:
 742  0004 0000          	ds.b	2
 743                     	xdef	_fraim
 744                     	xdef	_i
 745                     	xdef	_l
 746                     	xdef	_y
 747                     	xdef	_ii
 748                     	xdef	_iii
 749  0006               _buf:
 750  0006 000000000000  	ds.b	72
 751                     	xdef	_buf
 752                     	xdef	_eff111
 753  004e               _next2:
 754  004e 0000          	ds.b	2
 755                     	xdef	_next2
 756                     	xdef	_next
 757                     	xref.b	c_x
 777                     	xref	c_imul
 778                     	end
