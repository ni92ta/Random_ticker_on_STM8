/* MAIN.C file
 * ���� �������� 03.07.2023
 �����: ������
 ��������� ������� ������ �� ������ STM8S003F3P6
 * Copyright (c) 2002-2005 STMicroelectronics
 */
#include "stm8s.h"

unsigned int next = 2;
unsigned int next2;
int buf[49];
//int eff111[49] = {1192};
/*int eff111[49] = {0b11111000, 0b11110000, 0b11101000, 0b11011000, 0b10111000, 
                  0b01111000, 0b10111000, 0b11011000, 0b11101000, 0b11110000, 
									0b11101000, 0b11011000, 0b10111000, 0b01111000, 0b10111000,
									0b11011000, 0b11101000, 0b11110000, 0b11101000, 0b11011000,
									0b10111000, 0b01111000, 0b10111000, 0b11011000, 0b11101000,
									0b11110000, 0b11101000, 0b11011000, 0b10111000, 0b01111000,
									0b10111000, 0b11011000, 0b11101000, 0b11110000, 0b11101000,
									0b11011000, 0b10111000, 0b01111000, 0b10111000, 0b11011000,
									0b11101000, 0b11110000, 0b11101000, 0b11011000, 0b10111000,
									0b01111000, 0b10111000, 0b11011000, 0b11101000
};*/
/*int eff111[49] = {0b10000000, 0b01000000, 0b00100000, 0b00010000, 0b00001000, 
                  0b00010000, 0b00100000, 0b01000000, 0b10000000, 0b01000000, 
									0b00100000, 0b00010000, 0b00001000, 0b00010000, 0b00100000,
									0b01000000, 0b10000000, 0b01000000, 0b00100000, 0b00010000,
									0b00001000, 0b00010000, 0b00100000, 0b01000000, 0b10000000,
									0b01000000, 0b00100000, 0b00010000, 0b00001000, 0b00010000,
									0b00100000, 0b01000000, 0b10000000, 0b01000000, 0b00010000,
									0b00010000, 0b00001000, 0b00010000, 0b00100000, 0b01000000,
									0b00100000, 0b00010000, 0b00001000, 0b00010000, 0b00100000,
									0b01000000, 0b10000000, 0b01000000, 0b00100000
};*/
/*int eff111[49] = {0b10000000, 0b10000000, 0b10000000, 0b10000000, 0b10000000, 0b10000000, 0b10000000, 0b10000000,
                  0b01000000, 0b01000000, 0b010000000, 0b01000000, 0b0100000, 0b01000000, 0b01000000, 0b01000000, 
									0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 
									0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000,
									0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000,
									0b00000000,0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000
};*/
	 int eff111[49] = {
			 0xF8,0x20,0x20,0xF8,0x0,//�
			 0xF8,0x10,0x20,0xF8,0x0,//�
			 0xF8,0x20,0xD8,0x0,0x0,//�
			 0xF8,0x10,0x20,0xF8,0x0,//�
			 0x80,0xF8,0x80,0x0,0x0,//�
			 0x38,0x50,0x80,0x0,0x0,//�
			 0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0//������
	 };


int iii = 0;
int ii = 0;
int y;
int l;
int i = 0;	
int fraim;
int x;
//=================================================================
	 void raand(void)
		 {

		 unsigned char i;
		 //int  unsigned char
         next++;
		 if (next > 20) next = 2;
		 for (i = 0;i < 49; i++){
		 next = next * 1103515245;//1103515245
		   next2 = (next / 65536) * 2768;// next2 = (next / 65536) * 2768
		   x = next2 % (32767 - 8 + 1) + 8;//x = next2 % (32767 - 8 + 1) + 8
		   if (x > 32767) x = x - 32767;//if (x > 32767) x = x - 32767;
		 eff111[i] = x;
		 }
		 }
//=========================��������================================
 void delay(int n)
 {
         while(n>0) n--;
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
	 	 		if (1) {
					
	
					
	 iii++;
	 	 			buf[49] = eff111[0]; // ������� 1� ������� � �����

	 	 			for ( ii = 0; ii < 50; ii++)//
	 	 				{
	 	 				eff111[ii] = eff111[ii + 1]; // �������� ������� �� ���� ������� �����
	 	 				 }
	 	 			eff111[49] = buf[49]; // �������� ���������� ������ (������ �������) � ����� �������
	 	 		}



	 	 		for ( i = 0; i < 3000; ++i) {//4000

                    GPIOC->ODR = eff111[l];
                    GPIOD->ODR |= (1<<6);
										delay (100);
										GPIOD->ODR &= ~(1<<6);
                    
	 	 			l++;
	 	 			y++;
					GPIOC->ODR = 0b00000000;//������� �����		
                   // GPIOC->ODR &= ~0xF8;//������� ����� ++
	 	 			if (y == 6) {
	 	 				y = 0;
	 	 				l -= 6;
	 	 			}
	 	 		}

	GPIOC->ODR = 0b00000000;//������� �����			
//GPIOC->ODR &= ~0xF8;//������� �����
                
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
	CLK->CKDIVR = 0b00000001;//�������� ������� ����������� ���������� = 0; �������� ������� ��� -2
  CLK->SWR = 0b10110100;//HSE �������� �������� �������������
while (CLK->SWCR & (1<<1) == 1){}// ���� ���������� ������������
	
	//GPIOA->DDR |= (1<<3) | (1<<2) | (1<<1);// | (1<<5) | (1<<4) | (1<<3);//�����
	//GPIOA->CR1 |= (1<<3) | (1<<2) | (1<<1);// | (1<<5) | (1<<4) | (1<<3);//����� ���� Push-pull
	//GPIOA->CR2 |= (1<<3) | (1<<2) | (1<<1);// | (1<<5) | (1<<4) | (1<<3);//�������� ������������ - �� 10 ���.
	
	GPIOD->DDR &= ~((1<<5) | (1<<4) | (1<<3) | (1<<2) | (1<<1));//����
	GPIOD->CR1 |= (1<<5) | (1<<4) | (1<<3) | (1<<2) | (1<<1);//���� � ������������� ����������
	GPIOD->CR2 |= (1<<5) | (1<<4) | (1<<3) | (1<<2) | (1<<1);//�������� ������������ - �� 10 ���.
	GPIOD->DDR |= (1<<6);//�����
  GPIOD->CR1 |= (1<<6);//
	GPIOD->CR2 |= (1<<6);//
	
	GPIOC->DDR |= (1<<7) | (1<<6) | (1<<5) | (1<<4) | (1<<3);//�����
	GPIOC->CR1 |= (1<<7) | (1<<6) | (1<<5) | (1<<4) | (1<<3);//����� ���� Push-pull 
	GPIOC->CR2 |= (1<<7) | (1<<6) | (1<<5) | (1<<4) | (1<<3);//�������� ������������ - �� 10 ���.
	
	//raand();
	while (1){
	if (iii > 300) {
	 			//raand();
	 			iii = 0;
	 		}
        //GPIOC->ODR &= ~0xF8;//������� �����
				GPIOC->ODR = 0b00000000;//������� �����		
				fraim_out(fraim, 0);  
GPIOC->ODR = 0b00000000;//������� �����		
//GPIOD->ODR &= ~(1<<6);
										//delay (1500);
                   // GPIOD->ODR |= (1<<6);
				//GPIOC->ODR &= ~0xF8;//������� �����	
			/*	GPIOC->ODR |= (1<<7) | (1<<6) | (1<<5) | (1<<4) | (1<<3);
				GPIOD->ODR |= (1<<6);
				delay (15000);
        GPIOC->ODR &= ~((1<<7) | (1<<6) | (1<<5) | (1<<4) | (1<<3));
				GPIOD->ODR &= ~(1<<6);
				delay (15000);*/
				
				
				
				
	}
}