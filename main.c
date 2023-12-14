/* MAIN.C file
 * ���� �������� 03.07.2023
 �����: ������
 ��������� ������� ������ �� ������ STM8S003F3P6
 * Copyright (c) 2002-2005 STMicroelectronics
 */
#include "stm8s.h"
//#include "stm8_interrupt_vector.h"
//==========================================================
unsigned int next;//��� ������� ������� ������
unsigned int next2;
//unsigned char *address_1 = (unsigned char*)0x4000;// = 0x4000; ����������� ����� � ��� (EEPROM) ���������� address
unsigned char alar;
int eff111[36];
int buf[36];
int iii = 0;
int ii = 0;
int y = 0;
int l = 10;
int i = 0;	
int fraim;
int x;
int xx = 0;
int xxx = 0;
unsigned char sec;
unsigned char min;
unsigned char hour;
unsigned char SB1;//���������� ����� ������� ������ SB1
unsigned char swres = 0;//���������� ���������� ������� ������ SB1
unsigned int ip;
unsigned int speed = 450;//���������� ��� �������� �������� �������� ������ 450
unsigned int butcount = 0;//���������� ��� ������� ���������� ��������
#define dev_addrw 0b11010000 //������ 
#define dev_addrr 0b11010001 //������
//=========================��������=========================
 void delay(int n)
 {
         while(n > 10) n--;
 }
 //========================��������� ����������=============
@far @interrupt void EXTI3_IRQHandler(void) 
{
	butcount = 0;
	if (swres == 0) SB1 ++;
	if (SB1 >= 5) SB1 = 0;
	while (!((GPIOD->IDR & (1 << 1)))){//������� ������ SB2 ��������� ��������
	if (butcount < 10000){
			butcount ++;
					}
		else {
			swres = 1;
	switch (SB1){
				case 0:
		speed = 450;
		break;
				case 1:
		speed = 350;
		break;
				case 2:
		speed = 250;
		break;
				case 3:
		speed = 150;
		break;
				case 4:
		speed = 50;
		break;
	}
}
}
return;
}
//============������������� ���������� DC1307===============
void DS1307init (void){//
					I2C->CR1 |= (1<<0);//�������� I2C
					//if (alar == 0){
					I2C->CR2 |= (1<<0);//�������� ������� �����
					xxx = I2C->SR1;//������� ���� ADDR ������� �������� SR3
					//while(I2C->SR1 & (1 << 0) != 1){}//��� ��������� ���������� ���� 1
					delay (500);//delay (250);
					I2C->DR = dev_addrw;//����� ������� ���������� - ������
					while(I2C->SR1 & (1 << 1) == 1){}//��� ����� �������� ����� 1
					while(I2C->CR2 & (1 << 2) == 1){}//�������� ACK 1
					delay (500);//delay (200);
					xxx = I2C->SR1;//������� ���� ADDR ������� �������� SR3
					xxx = I2C->SR3;//������� ���� ADDR ������� �������� SR3
					while((I2C->SR1 & (1 << 2)) && (I2C->SR1 & (1 << 7)) == 1){}//
          xxx = I2C->SR3;//������� ���� ADDR ������� �������� SR3
					I2C->DR = 0b00000000;//����� �������� ������
					delay (350);//delay (450);
          I2C->DR &= ~(1 << 7);//�������� ������
					while(I2C->SR1 & (1 << 7) == 1){}//��� ������������ �������� �����
					I2C->CR2 |= (1<<1);//�������� ������� ����
					alar = 1;
					//*address_1 = alar;
//}
					
					delay (5000);//delay (250);
					I2C->CR2 |= (1<<0);//�������� ������� �����
					xxx = I2C->SR1;//������� ���� ADDR ������� �������� SR3
					while(I2C->SR1 & (1 << 0) != 1){}//��� ��������� ���������� ���� 1
					delay (500);//delay (50);
					I2C->DR = dev_addrw;//����� ������� ���������� - ������
					while(I2C->SR1 & (1 << 1) == 1){}//��� ����� �������� ����� 1
					while(I2C->CR2 & (1 << 2) == 1){}//�������� ACK 1
					delay (500);//delay (100);
					xxx = I2C->SR1;//������� ���� ADDR ������� �������� SR3
					xxx = I2C->SR3;//������� ���� ADDR ������� �������� SR3
					while((I2C->SR1 & (1 << 2)) && (I2C->SR1 & (1 << 7)) == 1){}//
          xxx = I2C->SR3;//������� ���� ADDR ������� �������� SR3
					I2C->DR = 0b00000111;//����� �������� clock out  0b00000111
					delay (600);//delay (250);
          I2C->DR = 0b00010000;//�������� ������0b00010000 �������� ����������
					while(I2C->SR1 & (1 << 7) == 1){}//��� ������������ �������� �����
					I2C->CR2 |= (1<<1);//�������� ������� ����		
					
					return;
}
//========================������ �����====================
int DS07read (void){//������ ������
					delay (5000);//delay (250);
					//I2C->CR1 |= (1<<0);//�������� I2C
					I2C->CR2 |= (1<<0);//�������� ������� �����
					xxx = I2C->SR1;//������� ���� ADDR ������� �������� SR3
					while(I2C->SR1 & (1 << 0) != 1){}//��� ��������� ���������� ���� 1
					delay (500);//delay (50);
					I2C->DR = dev_addrw;//����� ������� ���������� - 
					while(I2C->SR1 & (1 << 1) == 1){}//��� ����� �������� ����� 1
					while(I2C->CR2 & (1 << 2) == 1){}//�������� ACK 1
					delay (500);//delay (100);
					xxx = I2C->SR1;//������� ���� ADDR ������� �������� SR3
					xxx = I2C->SR3;//������� ���� ADDR ������� �������� SR3
					while((I2C->SR1 & (1 << 2)) && (I2C->SR1 & (1 << 7)) == 1){}//
          xxx = I2C->SR3;//������� ���� ADDR ������� �������� SR3
					I2C->DR = 0b00000001;//����� �������� �����
					delay (600);//delay (250);
          //I2C->DR &= ~(1 << 7);//�������� ������
					while(I2C->SR1 & (1 << 7) == 1){}//��� ������������ �������� �����
					I2C->CR2 |= (1<<1);//�������� ������� ����
					/*
					delay (200);//delay (100);
					xxx = I2C->SR1;//������� ���� ADDR ������� �������� SR3
					xxx = I2C->SR3;//������� ���� ADDR ������� �������� SR3
					I2C->CR2 |= (1<<1);//�������� ������� ����
					*/
					
					I2C->CR2 |= (1<<0);//�������� ������� �����
					xxx = I2C->SR1;//������� ���� ADDR ������� �������� SR3
					while(I2C->SR1 & (1 << 0) != 1){}//��� ��������� ���������� ���� 1
					delay (500);//delay (50);
					I2C->DR = dev_addrr;//����� ������� ����������
					while(I2C->SR1 & (1 << 1) == 1){}//��� ����� �������� ����� 1
					while(I2C->CR2 & (1 << 2) == 1){}//�������� ACK 1
					delay (500);//delay (100);
					xxx = I2C->SR1;//������� ���� ADDR ������� �������� SR3
					xxx = I2C->SR3;//������� ���� ADDR ������� �������� SR3
					delay (600);//delay (100);
					//xxx = I2C->DR;
					next = I2C->DR;
					//while(I2C->SR1 & (1 << 7) == 1){}//��� ������������ �������� �����
					I2C->CR2 |= (1<<1);//�������� ������� ����
					//xxx = xxx & 0b11110000;
					next = next & 0b11110000;
return;
}
//==========================================================
	void raand(unsigned int jk)
		 {
			 //next = GPIOD->ODR
		 unsigned char i2;
			int xy;
			//next++;
			//next = 5;
			//jk++;
		 if (jk > 20) next = 2;
		 for (i2 = 0; i2 < 36; i2++){
		 jk = jk * 1103515;//1103515245
		   next2 = (jk / 655) * 276;// next2 = (next / 65536) * 2768
		   xy = next2 % (327 - 8 + 1) + 8;//x = next2 % (32767 - 8 + 1) + 8
		   if (xy > 327) xy = xy - 327;//if (x > 32767) x = x - 32767;
		 eff111[i2] = xy;//0
		 }
	}
 //=====================
 void clear_matrix(void)
 {
 	 unsigned char i;
 	 for (i = 0;i < 49; i++){
 		 eff111[i] = 0;
 	 }
 }
//==========================����� ������====================
	void fraim_out (int o, int e){
			if (iii > 48) {//���������� �������
		//DS07read();
	 			raand(DS07read());
	 			iii = 0;
				fraim = 1;
	 		}

	 	 			//if (o == 0){
						iii++;
						buf[35] = eff111[0];//������� 1� ������� � �����
						for ( ii = 0; ii < 35; ii++){
						eff111[ii] = eff111[ii + 1];//�������� ������� �� ���� ������� �����
						}
						eff111[35] = buf[35];//�������� ���������� ������ (������ �������) � ����� �������
					//}
					/*if (o == 1){
						iii++;
						buf[28] = numbers[0];//������� 1� ������� � �����
						for ( ii = 0; ii < 28; ii++){
						numbers[ii] = numbers[ii + 1];//�������� ������� �� ���� ������� �����
						}
						numbers[28] = buf[28];
				    if (iii == 14) fraim = 0;						
					}*/

	for ( ip = 0; ip < speed; ++ip){//400  speed
					//if (o == 0){
						GPIOC->ODR = eff111[l];//	
					//}
					//else{
					//	GPIOC->ODR = numbers[l];	
					//}
					/*GPIOA->ODR &= ~(1<<3);
					delay (1000);//�������� ���� ������
					GPIOA->ODR |= (1<<3);
				*/
					GPIOD->ODR &= ~(1<<6);
					delay (1000);//�������� ���� ������1000
					GPIOD->ODR |= (1<<6);
					
					GPIOC->ODR &= ~((1<<7) | (1<<6) | (1<<5) | (1<<4) | (1<<3));//������� ����� ++
					l--;
	 	 			y++;
	 	 			if (y == 8){
	 	 				y = 0;
	 	 				l = 8;
						/*
						GPIOD->ODR |= (1<<6);//������������ ������� CLOCK ��8
						delay (20);
						GPIOD->ODR &= ~(1<<6);//������������ ������� CLOCK ��8
						*/
						GPIOA->ODR |= (1<<3);//������������ ������� CLOCK ��8
						delay (20);
						GPIOA->ODR &= ~(1<<3);//������������ ������� CLOCK ��8
	 	 			}
	}
	}
//==========================================================
int main(void)
{
//ODR ������� �������� ������
//IDR ������� ������� ������
//DDR ������� ����������� ������
//0: Input mode
//1: Output mode
//��������� ������
//while ((GPIOD->IDR & (1 << 5)))�������� ����� - ���� 1, �� ��������
//while (!((GPIOD->IDR & (1 << 5))))�������� ����� - ���� 0, �� ��������
  CLK->ECKR |= (1<<0);//��������� HSE ����������
	CLK->SWCR |= (1<<1);//��������� ����������� �������� ������������
while(CLK->ECKR & (1<<1) == 1){}//���� ���������� ��������� ������������
	CLK->CKDIVR = 0b00011000;//�������� ������� ����������� ���������� = 0; �������� ������� ��� -2  11000
  CLK->SWR = 0b10110100;//HSE �������� �������� �������������
while (CLK->SWCR & (1<<1) == 1){}// ���� ���������� ������������
	CLK->PCKENR1 = 0b00000001;//�������� ������������ I2C
	
	
	GPIOA->DDR |= (1<<3);// | (1<<2) | (1<<1);// | (1<<5) | (1<<4) | (1<<3);//�����
	GPIOA->CR1 |= (1<<3);// | (1<<2) | (1<<1);// | (1<<5) | (1<<4) | (1<<3);//����� ���� Push-pull
	GPIOA->CR2 |= (1<<3);// | (1<<2) | (1<<1);// | (1<<5) | (1<<4) | (1<<3);//�������� ������������ - �� 10 ���.
	
	GPIOD->DDR &= ~((1<<5) | (1<<3) | (1<<2) | (1<<1));//���� | (1<<4)
	GPIOD->CR1 |= (1<<3) | (1<<2) | (1<<1);//���� � ������������� ����������
	GPIOD->CR2 |= (1<<3) | (1<<2) | (1<<1);//���������� ��������
	GPIOD->DDR |= (1<<6) | (1<<4);//�����
  GPIOD->CR1 |= (1<<6) | (1<<4);//
	GPIOD->CR2 |= (1<<6) | (1<<4);//
	
	GPIOC->DDR |= (1<<7) | (1<<6) | (1<<5) | (1<<4) | (1<<3);//�����
	GPIOC->CR1 |= (1<<7) | (1<<6) | (1<<5) | (1<<4) | (1<<3);//����� ���� Push-pull 
	GPIOC->CR2 |= (1<<7) | (1<<6) | (1<<5) | (1<<4) | (1<<3);//�������� ������������ - �� 10 ���.
	
	GPIOB->ODR |= (1<<5) | (1<<4);//������������� 1
	GPIOB->DDR |= (1<<5) | (1<<4);//�����
	GPIOB->CR1 &= ~((1<<5) | (1<<4));//����� ���� Open Drain
	GPIOB->CR2 &= ~((1<<5) | (1<<4));//�������� ������������ - �� 10 ���.
	//===================��������� I2C========================
		I2C->CR1 &= ~(1<<0);//��������� I2C ����� ����������
		I2C->FREQR = 8;//������� ��������� 8���
		I2C->CCRL = 80;//100kHz
		I2C->CCRH = 0;
		//I2C->CCRH |= (1<<3) | (1<<2) | (1<<0);//13
		//I2C->CCRH |= (1<<3) | (1<<2);//12
		//I2C->CCRH |= (1<<3) | (1<<1);//10
		//I2C->CCRH |= (1<<2) | (1<<1);//6
		//I2C->CCRH |= (1<<1) | (1<<0);//3
		//I2C->CCRH |= (1<<3) | (1<<2) | (1<<1) | (1<<0);//15
		I2C->TRISER = 9;//rise time 1000ns
		//I2C->OARL = 0xA0;              // own address A0;
		//I2C->OARH |= 0x40;
		I2C->ITR = 0;                  // enable error interrupts
		I2C->CR2 |= 0x04;              // ACK=1, Ack enable
		I2C->CR1 |= 0x01;              // PE=1
		
	//========================================================
	/*GPIOD->ODR |= (1<<6);
	delay (20);
	GPIOD->ODR &= ~(1<<6);
	*/
	GPIOA->ODR |= (1<<3);
	delay (20);
	GPIOA->ODR &= ~(1<<3);
	
	delay (5000);
    DS1307init();
	delay (5000);	
		//DS07read();
			delay (50000);
		raand(DS07read());


ITC->ISPR2 &= ~((1<<5) | (1<<4));//+
ITC->ISPR2 |= (1<<5) | (1<<4);//+




EXTI->CR1 = 0b10000000;//���������� �� ������� ������
//ITC->ISPR2 &= ~((1<<5) | (1<<4));//+

rim();
//enableInterrupts();


	while (1){
		unsigned char iu;


		fraim_out(fraim, 0);

swres = 0;//���������� ������������ ��������


				/*
				�������
		I2C->CR1 &= ~(1<<0);//��������� I2C ����� ����������
		I2C->FREQR = 8;//������� ��������� 8���
		I2C->CCRL = 40;//100kHz
		I2C->CCRH = 0;//
		I2C->TRISER = 9;//rise time 1000ns
		I2C->OARL = 0xA0;              // own address A0;
		I2C->OARH |= 0x40;
		I2C->ITR = 1;                  // enable error interrupts
		I2C->CR2 |= 0x04;              // ACK=1, Ack enable
		I2C->CR1 |= 0x01;              // PE=1
				*/
						}
}




