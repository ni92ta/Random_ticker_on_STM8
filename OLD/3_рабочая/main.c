/* MAIN.C file
 * ���� �������� 03.07.2023
 �����: ������
 ��������� ������� ������ �� ������ STM8S003F3P6
 * Copyright (c) 2002-2005 STMicroelectronics
 */
#include "stm8s.h"

unsigned int next = 2;
unsigned int next2;
int eff111[36] = {1192};
//int eff111[36];
/*int eff111[36] = {
			 0x0,0x0,0x0,0x0,0x0,//������
			 0xF8,0x20,0x20,0xF8,0x0,//�
			 0xF8,0x10,0x20,0xF8,0x0,//�
			 0xF8,0x20,0xD8,0x0,0x0,//�
			 0xF8,0x10,0x20,0xF8,0x0,//�
			 0x80,0xF8,0x80,0x0,0x0,//�
			 0x38,0x50,0xF8,0x0,0x0//,//�
	 };*/
int buf[36];
int iii = 0;
int ii = 0;
int y = 0;
int l = 10;
int i = 0;	
int fraim;
int x;
int xx = 0;
unsigned int ip;
//=================================================================
	 void raand(void)
		 {
		 unsigned char i2;
			int xy;
			next++;
		 if (next > 20) next = 2;
		 for (i2 = 0; i2 < 36; i2++){
		 next = next * 1103515;//1103515245
		   next2 = (next / 655) * 276;// next2 = (next / 65536) * 2768
		   xy = next2 % (327 - 8 + 1) + 8;//x = next2 % (32767 - 8 + 1) + 8
		   if (xy > 327) xy = xy - 327;//if (x > 32767) x = x - 32767;
			 //xy = xy;//(xy & 0b11111000);
			 
		 eff111[i2] = xy;//0b01010111;
		 }
		 }
//=========================��������================================
 void delay(int n)
 {
         while(n > 10) n--;
 }
 //=====================
 void clear_matrix(void)
 {
 	 unsigned char i;
 	 for (i = 0;i < 49; i++){
 		 eff111[i] = 0;
 	 }
 }
//==========================����� ������======================================
	 	 	void fraim_out (int o, int e){
										//int ip;
										int ipp;
	 	 			if (1) {
	 iii++;
	 	 			buf[35] = eff111[0]; // ������� 1� ������� � �����

	 	 			for ( ii = 0; ii < 35; ii++)//
	 	 				{
	 	 				eff111[ii] = eff111[ii + 1]; // �������� ������� �� ���� ������� �����
	 	 				 }
	 	 			eff111[35] = buf[35]; // �������� ���������� ������ (������ �������) � ����� �������
	 	 		
}
for ( ip = 0; ip < 1000; ++ip) 
				{
          GPIOC->ODR = eff111[l];// & 0b11111000;
					GPIOD->ODR &= ~(1<<6);
					delay (200);
					GPIOD->ODR |= (1<<6);
					l--;
	 	 			y++;
	 	 			if (y == 8) {
						GPIOC->ODR |= (1<<7) | (1<<6) | (1<<5) | (1<<4) | (1<<3);//������� ����� ++
	 	 				y = 0;
	 	 				l = 8;
				GPIOA->ODR |= (1<<3);
				delay (20);
				GPIOA->ODR &= ~(1<<3);
	 	 			}
			  }
	 	 	}
//==============================================================================
int main(void)
{
//ODR ������� �������� ������
//IDR ������� ������� ������
//DDR ������� ����������� ������
//��������� ������
  CLK->ECKR |= (1<<0);//��������� HSE ����������
	CLK->SWCR |= (1<<1);//��������� ����������� �������� ������������
while(CLK->ECKR & (1<<1) == 1){}//���� ���������� ��������� ������������
	CLK->CKDIVR = 0b00011000;//�������� ������� ����������� ���������� = 0; �������� ������� ��� -2
  CLK->SWR = 0b10110100;//HSE �������� �������� �������������
while (CLK->SWCR & (1<<1) == 1){}// ���� ���������� ������������
	
	GPIOA->DDR |= (1<<3);// | (1<<2) | (1<<1);// | (1<<5) | (1<<4) | (1<<3);//�����
	GPIOA->CR1 |= (1<<3);// | (1<<2) | (1<<1);// | (1<<5) | (1<<4) | (1<<3);//����� ���� Push-pull
	GPIOA->CR2 |= (1<<3);// | (1<<2) | (1<<1);// | (1<<5) | (1<<4) | (1<<3);//�������� ������������ - �� 10 ���.
	
	GPIOD->DDR &= ~((1<<5) | (1<<4) | (1<<3) | (1<<2) | (1<<1));//����
	GPIOD->CR1 |= (1<<5) | (1<<4) | (1<<3) | (1<<2) | (1<<1);//���� � ������������� ����������
	GPIOD->CR2 |= (1<<5) | (1<<4) | (1<<3) | (1<<2) | (1<<1);//�������� ������������ - �� 10 ���.
	GPIOD->DDR |= (1<<6);//�����
  GPIOD->CR1 |= (1<<6);//
	GPIOD->CR2 |= (1<<6);//
	
	GPIOC->DDR |= (1<<7) | (1<<6) | (1<<5) | (1<<4) | (1<<3);//�����
	GPIOC->CR1 |= (1<<7) | (1<<6) | (1<<5) | (1<<4) | (1<<3);//����� ���� Push-pull 
	GPIOC->CR2 |= (1<<7) | (1<<6) | (1<<5) | (1<<4) | (1<<3);//�������� ������������ - �� 10 ���.
	
	raand();
	GPIOA->ODR |= (1<<3);
	delay (20);
	GPIOA->ODR &= ~(1<<3);
    
	while (1){
		unsigned char iu;
	if (iii > 36) {
	 			raand();
	 			iii = 0;
	 		}
			fraim_out(fraim, 0);  
		//raand();
		/*y++;
				GPIOC->ODR |= (1<<7) | (1<<6) | (1<<5) | (1<<4) | (1<<3);
				GPIOD->ODR &= ~(1<<6);
				delay (30000);
				delay (30000);
        GPIOC->ODR &= ~((1<<7) | (1<<6) | (1<<5) | (1<<4) | (1<<3));
				GPIOD->ODR |= (1<<6);
				delay (30000);
				delay (30000);
				if (y == 8){
				y = 0;
				GPIOA->ODR |= (1<<3);
				delay (20);
				GPIOA->ODR &= ~(1<<3);
				}*/
				
						}
}



