   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.12.8.1 - 09 Jan 2023
   3                     ; Generator (Limited) V4.5.5 - 08 Nov 2022
  14                     	bsct
  15  0000               _next:
  16  0000 02            	dc.b	2
  17  0001               _eff111:
  18  0001 04a8          	dc.w	1192
  19  0003 000000000000  	ds.b	96
  20  0063               _iii:
  21  0063 00            	dc.b	0
  22  0064               _ii:
  23  0064 00            	dc.b	0
  75                     ; 20 	 void raand(void)
  75                     ; 21 		 {
  77                     	switch	.text
  78  0000               _raand:
  80  0000 5203          	subw	sp,#3
  81       00000003      OFST:	set	3
  84                     ; 25          next++;
  86  0002 3c00          	inc	_next
  87                     ; 26 		 if (next > 20) next = 2;
  89  0004 b600          	ld	a,_next
  90  0006 a115          	cp	a,#21
  91  0008 2504          	jrult	L33
  94  000a 35020000      	mov	_next,#2
  95  000e               L33:
  96                     ; 27 		 for (i = 0;i < 20; i++){
  98  000e 0f03          	clr	(OFST+0,sp)
 100  0010               L53:
 101                     ; 28 		 next = next * 1103515245;//1103515245
 103  0010 ae4e6d        	ldw	x,#20077
 104  0013 b600          	ld	a,_next
 105  0015 42            	mul	x,a
 106  0016 9f            	ld	a,xl
 107  0017 b700          	ld	_next,a
 108                     ; 29 		   next2 = (next / 65536) * 2768;// next2 = (next / 65536) * 2768
 110  0019 3f67          	clr	_next2
 111                     ; 30 		   x = next2 % (32767 - 8 + 1) + 8;//x = next2 % (32767 - 8 + 1) + 8
 113                     ; 32 		 eff111[i] = x;
 115  001b 7b03          	ld	a,(OFST+0,sp)
 116  001d 5f            	clrw	x
 117  001e 97            	ld	xl,a
 118  001f 58            	sllw	x
 119  0020 90ae0008      	ldw	y,#8
 120  0024 ef01          	ldw	(_eff111,x),y
 121                     ; 27 		 for (i = 0;i < 20; i++){
 123  0026 0c03          	inc	(OFST+0,sp)
 127  0028 7b03          	ld	a,(OFST+0,sp)
 128  002a a114          	cp	a,#20
 129  002c 25e2          	jrult	L53
 130                     ; 34 		 }
 133  002e 5b03          	addw	sp,#3
 134  0030 81            	ret
 168                     ; 36  void delay(int n)
 168                     ; 37  {
 169                     	switch	.text
 170  0031               _delay:
 172  0031 89            	pushw	x
 173       00000000      OFST:	set	0
 176  0032 2007          	jra	L36
 177  0034               L16:
 178                     ; 38          while(n>0) n--;
 180  0034 1e01          	ldw	x,(OFST+1,sp)
 181  0036 1d0001        	subw	x,#1
 182  0039 1f01          	ldw	(OFST+1,sp),x
 183  003b               L36:
 186  003b 9c            	rvf
 187  003c 1e01          	ldw	x,(OFST+1,sp)
 188  003e 2cf4          	jrsgt	L16
 189                     ; 39  }
 192  0040 85            	popw	x
 193  0041 81            	ret
 228                     ; 41  void clear_matrix(void)
 228                     ; 42  {
 229                     	switch	.text
 230  0042               _clear_matrix:
 232  0042 88            	push	a
 233       00000001      OFST:	set	1
 236                     ; 44  	 for (i = 0;i < 49; i++){
 238  0043 0f01          	clr	(OFST+0,sp)
 240  0045               L501:
 241                     ; 45  		 eff111[i] = 0;
 243  0045 7b01          	ld	a,(OFST+0,sp)
 244  0047 5f            	clrw	x
 245  0048 97            	ld	xl,a
 246  0049 58            	sllw	x
 247  004a 905f          	clrw	y
 248  004c ef01          	ldw	(_eff111,x),y
 249                     ; 44  	 for (i = 0;i < 49; i++){
 251  004e 0c01          	inc	(OFST+0,sp)
 255  0050 7b01          	ld	a,(OFST+0,sp)
 256  0052 a131          	cp	a,#49
 257  0054 25ef          	jrult	L501
 258                     ; 48  }
 261  0056 84            	pop	a
 262  0057 81            	ret
 304                     ; 50 	 	 	void fraim_out (unsigned char o, unsigned char e){
 305                     	switch	.text
 306  0058               _fraim_out:
 310                     ; 53 	 iii++;
 312  0058 3c63          	inc	_iii
 313                     ; 54 	 	 			buf[14] = eff111[0]; // Считали 1ю колонку в буфер
 315  005a be01          	ldw	x,_eff111
 316  005c bf21          	ldw	_buf+28,x
 317                     ; 56 	 	 			for ( ii = 0; ii < 50; ii++)//
 319  005e 3f64          	clr	_ii
 320  0060               L131:
 321                     ; 58 	 	 				eff111[ii] = eff111[ii + 1]; // Сдвинули матрицу на один столбец влево
 323  0060 b664          	ld	a,_ii
 324  0062 5f            	clrw	x
 325  0063 97            	ld	xl,a
 326  0064 58            	sllw	x
 327  0065 9093          	ldw	y,x
 328  0067 90ee03        	ldw	y,(_eff111+2,y)
 329  006a ef01          	ldw	(_eff111,x),y
 330                     ; 56 	 	 			for ( ii = 0; ii < 50; ii++)//
 332  006c 3c64          	inc	_ii
 335  006e b664          	ld	a,_ii
 336  0070 a132          	cp	a,#50
 337  0072 25ec          	jrult	L131
 338                     ; 60 	 	 			eff111[49] = buf[49]; // Записали содержимое буфера (первую колонку) в конец матрицы
 340  0074 be67          	ldw	x,_buf+98
 341  0076 bf63          	ldw	_eff111+98,x
 342                     ; 62 	 	 		for ( i = 0; i < 2000; ++i) {//4000
 344  0078 5f            	clrw	x
 345  0079 bf01          	ldw	_i,x
 346  007b               L731:
 347                     ; 63                     GPIOC->ODR = eff111[l];
 349  007b b603          	ld	a,_l
 350  007d 5f            	clrw	x
 351  007e 97            	ld	xl,a
 352  007f 58            	sllw	x
 353  0080 e602          	ld	a,(_eff111+1,x)
 354  0082 c7500a        	ld	20490,a
 355                     ; 64 										GPIOD->ODR &= ~(1<<6);
 357  0085 721d500f      	bres	20495,#6
 358                     ; 65 										delay (150);
 360  0089 ae0096        	ldw	x,#150
 361  008c ada3          	call	_delay
 363                     ; 66                     GPIOD->ODR |= (1<<6);
 365  008e 721c500f      	bset	20495,#6
 366                     ; 68 	 	 			l++;
 368  0092 3c03          	inc	_l
 369                     ; 69 	 	 			y++;
 371  0094 3c04          	inc	_y
 372                     ; 70                     GPIOC->ODR &= ~0xF8;//очистка строк ++
 374  0096 c6500a        	ld	a,20490
 375  0099 a407          	and	a,#7
 376  009b c7500a        	ld	20490,a
 377                     ; 71 	 	 			if (y == 8) {
 379  009e b604          	ld	a,_y
 380  00a0 a108          	cp	a,#8
 381  00a2 2608          	jrne	L541
 382                     ; 72 	 	 				y = 0;
 384  00a4 3f04          	clr	_y
 385                     ; 73 	 	 				l -= 8;
 387  00a6 b603          	ld	a,_l
 388  00a8 a008          	sub	a,#8
 389  00aa b703          	ld	_l,a
 390  00ac               L541:
 391                     ; 62 	 	 		for ( i = 0; i < 2000; ++i) {//4000
 393  00ac be01          	ldw	x,_i
 394  00ae 1c0001        	addw	x,#1
 395  00b1 bf01          	ldw	_i,x
 398  00b3 be01          	ldw	x,_i
 399  00b5 a307d0        	cpw	x,#2000
 400  00b8 25c1          	jrult	L731
 401                     ; 76 GPIOC->ODR &= ~0xF8;//очистка строк
 403  00ba c6500a        	ld	a,20490
 404  00bd a407          	and	a,#7
 405  00bf c7500a        	ld	20490,a
 406                     ; 78 	 	 	}
 409  00c2 81            	ret
 436                     ; 80 int main(void)
 436                     ; 81 {
 437                     	switch	.text
 438  00c3               _main:
 442                     ; 86   CLK->ECKR |= (1<<0);//Включение HSE осцилятора
 444  00c3 721050c1      	bset	20673,#0
 445                     ; 87 	CLK->SWCR |= (1<<1);//Разрешаем переключить источник тактирования
 447  00c7 721250c5      	bset	20677,#1
 448                     ; 89 	CLK->CKDIVR = 0b00000001;//Делитель частоты внутреннего осцилятора = 0; тактовой частоты ЦПУ -2
 450  00cb 350150c6      	mov	20678,#1
 451                     ; 91 while (CLK->SWCR & (1<<1) == 1){}// Ждем готовности переключения
 454  00cf 35b450c4      	mov	20676,#180
 455                     ; 97 	GPIOD->DDR &= ~((1<<5) | (1<<4) | (1<<3) | (1<<2) | (1<<1));//Вход
 457  00d3 c65011        	ld	a,20497
 458  00d6 a4c1          	and	a,#193
 459  00d8 c75011        	ld	20497,a
 460                     ; 98 	GPIOD->CR1 |= (1<<5) | (1<<4) | (1<<3) | (1<<2) | (1<<1);//Вход с подтягивающим резистором
 462  00db c65012        	ld	a,20498
 463  00de aa3e          	or	a,#62
 464  00e0 c75012        	ld	20498,a
 465                     ; 99 	GPIOD->CR2 |= (1<<5) | (1<<4) | (1<<3) | (1<<2) | (1<<1);//Скорость переключения - до 10 МГц.
 467  00e3 c65013        	ld	a,20499
 468  00e6 aa3e          	or	a,#62
 469  00e8 c75013        	ld	20499,a
 470                     ; 104 	GPIOC->DDR |= (1<<7) | (1<<6) | (1<<5) | (1<<4) | (1<<3);//выход
 472  00eb c6500c        	ld	a,20492
 473  00ee aaf8          	or	a,#248
 474  00f0 c7500c        	ld	20492,a
 475                     ; 105 	GPIOC->CR1 |= (1<<7) | (1<<6) | (1<<5) | (1<<4) | (1<<3);//Выход типа Push-pull 
 477  00f3 c6500d        	ld	a,20493
 478  00f6 aaf8          	or	a,#248
 479  00f8 c7500d        	ld	20493,a
 480                     ; 106 	GPIOC->CR2 |= (1<<7) | (1<<6) | (1<<5) | (1<<4) | (1<<3);//Скорость переключения - до 10 МГц.
 482  00fb c6500e        	ld	a,20494
 483  00fe aaf8          	or	a,#248
 484  0100 c7500e        	ld	20494,a
 485                     ; 108 	raand();
 487  0103 cd0000        	call	_raand
 489  0106               L751:
 490                     ; 109 	while (1);{
 492  0106 20fe          	jra	L751
 599                     	xdef	_main
 600                     	xdef	_fraim_out
 601                     	xdef	_clear_matrix
 602                     	xdef	_delay
 603                     	xdef	_raand
 604                     	switch	.ubsct
 605  0000               _fraim:
 606  0000 00            	ds.b	1
 607                     	xdef	_fraim
 608  0001               _i:
 609  0001 0000          	ds.b	2
 610                     	xdef	_i
 611  0003               _l:
 612  0003 00            	ds.b	1
 613                     	xdef	_l
 614  0004               _y:
 615  0004 00            	ds.b	1
 616                     	xdef	_y
 617                     	xdef	_ii
 618                     	xdef	_iii
 619                     	xdef	_eff111
 620  0005               _buf:
 621  0005 000000000000  	ds.b	98
 622                     	xdef	_buf
 623  0067               _next2:
 624  0067 00            	ds.b	1
 625                     	xdef	_next2
 626                     	xdef	_next
 646                     	end
