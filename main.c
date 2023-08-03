/* MAIN.C file
 * ���� �������� 03.07.2023
 �����: ������
 ��������� ������� ������ �� ������ STM8S003F3P6
 * Copyright (c) 2002-2005 STMicroelectronics
 */
#include "stm8s.h"

unsigned int next = 2;
unsigned int next2;
int eff111[36];
/*unsigned char numbers[29] = {
			 //0x0,0x70,0x88,0x70,0x0,//0
			 //0x0,0x88,0xF8,0x8,0x0,//1
			 //0x0,0x98,0xA8,0xC8,0x0,//2
			 //0x0,0xA8,0xA8,0x70,0x0,//3
			 0x0,0xE0,0x20,0xF8,//4
			 0x0,0xE8,0xA8,0xB8,//5
			 0x0,0x78,0xA8,0xB8,//6
			 0x0,0x80,0x80,0xF8,//7
			 0x0,0xF8,0xA8,0xF8,//8
			 0x0,0xE8,0xA8,0xF8,//9
			 0x0,0xC0,0xD8,0x18//:
	 };*/
int buf[36];
//int buf[29];
int iii = 0;
int ii = 0;
int y = 0;
int l = 10;
int i = 0;	
int fraim;
int x;
int xx = 0;
int xxx = 0;
unsigned int ip;
#define dev_addrw 0b11010000 //������ 
#define dev_addrr 0b11010001 //������ 
//=========================��������================================
 void delay(int n)
 {
         while(n > 10) n--;
 }
 //====================================================================
/* void I2C_WriteRegister(u8 u8_regAddr, u8 u8_NumByteToWrite, u8 *u8_DataBuffer)
{
  while((I2C->SR3 & 2) && tout())       									// Wait while the bus is busy
  {
    I2C->CR2 |= 2;                        								// STOP=1, generate stop
    while((I2C->CR2 & 2) && tout());      								// wait until stop is performed
  }
  
  I2C->CR2 |= 1;                        									// START=1, generate start
  while(((I2C->SR1 & 1)==0) && tout()); 									// Wait for start bit detection (SB)
  dead_time();                          									// SB clearing sequence
  if(tout())
  {
    #ifdef TEN_BITS_ADDRESS															  // TEN_BIT_ADDRESS decalred in I2c_master_poll.h
      I2C->DR = (u8)(((SLAVE_ADDRESS >> 7) & 6) | 0xF0);  // Send header of 10-bit device address (R/W = 0)
      while(!(I2C->SR1 & 8) &&  tout());    							// Wait for header ack (ADD10)
      if(tout())
      {
        I2C->DR = (u8)(SLAVE_ADDRESS);        						// Send lower 8-bit device address & Write 
      }
    #else
      I2C->DR = (u8)(SLAVE_ADDRESS << 1);   							// Send 7-bit device address & Write (R/W = 0)
    #endif
  }
  while(!(I2C->SR1 & 2) && tout());     									// Wait for address ack (ADDR)
  dead_time();                          									// ADDR clearing sequence
  I2C->SR3;
  while(!(I2C->SR1 & 0x80) && tout());  									// Wait for TxE
  if(tout())
  {
    I2C->DR = u8_regAddr;                 								// send Offset command
  }
  if(u8_NumByteToWrite)
  {
    while(u8_NumByteToWrite--)          									
    {																											// write data loop start
      while(!(I2C->SR1 & 0x80) && tout());  								// test EV8 - wait for TxE
      I2C->DR = *u8_DataBuffer++;           								// send next data byte
    }																											// write data loop end
  }
  while(((I2C->SR1 & 0x84) != 0x84) && tout()); 					// Wait for TxE & BTF
  dead_time();                          									// clearing sequence
  
  I2C->CR2 |= 2;                        									// generate stop here (STOP=1)
  while((I2C->CR2 & 2) && tout());      									// wait until stop is performed  
}*/
//============������������� ���������� DC1307===============
void DS1307init (void){//������������� ����������

//  while((I2C->SR3 & 2) && 1)       									// Wait while the bus is busy
 // {
  //  I2C->CR2 |= 2;                        								// STOP=1, generate stop
  //  while((I2C->CR2 & 2) 1);      								// wait until stop is performed
 // }




					I2C->CR1 |= (1<<0);//�������� I2C
					I2C->CR2 |= (1<<0);//�������� ������� �����
					xxx = I2C->SR1;//������� ���� ADDR ������� �������� SR3
					//while(I2C->SR1 & (1 << 0) != 1){}//��� ��������� ���������� ���� 1
					delay (18);//delay (50);
					I2C->DR = dev_addrw;//����� ������� ���������� - ������
					while(I2C->SR1 & (1 << 1) == 1){}//��� ����� �������� ����� 1
					while(I2C->CR2 & (1 << 2) == 1){}//�������� ACK 1
					delay (100);//delay (100);
					xxx = I2C->SR1;//������� ���� ADDR ������� �������� SR3
					xxx = I2C->SR3;//������� ���� ADDR ������� �������� SR3
					while((I2C->SR1 & (1 << 2)) && (I2C->SR1 & (1 << 7)) == 1){}//
          xxx = I2C->SR3;//������� ���� ADDR ������� �������� SR3
					I2C->DR = 0b00000000;//����� �������� clock out  0b00000111
					delay (105);//delay (250);
          I2C->DR = 0b00000000;//�������� ������0b00010000
					while(I2C->SR1 & (1 << 7) == 1){}//��� ������������ �������� �����
					I2C->CR2 |= (1<<1);//�������� ������� ����
					
					
					
					delay (5000);//delay (250);
					I2C->CR2 |= (1<<0);//�������� ������� �����
					xxx = I2C->SR1;//������� ���� ADDR ������� �������� SR3
					//while(I2C->SR1 & (1 << 0) != 1){}//��� ��������� ���������� ���� 1
					delay (18);//delay (50);
					I2C->DR = dev_addrw;//����� ������� ���������� - ������
					while(I2C->SR1 & (1 << 1) == 1){}//��� ����� �������� ����� 1
					while(I2C->CR2 & (1 << 2) == 1){}//�������� ACK 1
					delay (100);//delay (100);
					xxx = I2C->SR1;//������� ���� ADDR ������� �������� SR3
					xxx = I2C->SR3;//������� ���� ADDR ������� �������� SR3
					while((I2C->SR1 & (1 << 2)) && (I2C->SR1 & (1 << 7)) == 1){}//
          xxx = I2C->SR3;//������� ���� ADDR ������� �������� SR3
					I2C->DR = 0b00000111;//����� �������� clock out  0b00000111
					delay (205);//delay (250);
          I2C->DR = 0b00010000;//�������� ������0b00010000
					while(I2C->SR1 & (1 << 7) == 1){}//��� ������������ �������� �����
					I2C->CR2 |= (1<<1);//�������� ������� ����		
					
					
					return;
					
					
	/*				
//while (I2C->SR3 & (1 << 1) !=1){}//��� ������������ ���� I2C � 0
					delay (500);//
I2C->CR2 |= (1<<0);//�������� ������� �����
					delay (500);//
while(I2C->SR1 & (1 << 0) == 1){}//��� ��������� ���������� ���� 1

					delay (500);//
I2C->DR = dev_addrw;//����� ������� ���������� - ������
					delay (500);//
while(I2C->SR1 & (1 << 1) == 1){}//��� ����� �������� ����� 1

I2C->SR3;//������� ���� ADDR ������� �������� SR3
while(I2C->SR1 & (1 << 7) == 1){}//��� ������������ �������� ������	
I2C->DR = 0b00000111;//����� �������� clock out
I2C->DR = 0b00010000;//�������� ������
while (!((I2C->SR1 & (1 << 7) && I2C->SR1 & (1 << 2)))){}//����� ������, ����� DR ����������� � ������ ������ � ��������� �������
I2C->CR2 |= (1<<1);//�������� ������� ����
*/


		/*delay_ms(2);
    i2c_start ();//�������� ������� �����
    I2C_SendByte (dev_addrw);//����� ������� ���������� - ������
    I2C_SendByte (0b00000000);//����� �������� ������ (0b00000010)
    I2C_SendByte (0b00000000);//��������� ������ 55  01010101
    i2c_stop ();
    
		i2c_start ();//�������� ������� �����
    I2C_SendByte (dev_addrw);//����� ������� ���������� - ������ 
    I2C_SendByte (0b00000111);//����� �������� clock out
    I2C_SendByte (0b00010000);//��������� �������� ������� 1Hz
    i2c_stop ();*/	
}
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
										int ipp;
	 	 			if (1) {
	 iii++;
	 	 			buf[35] = eff111[0];//������� 1� ������� � �����
					//buf[28] = numbers[0];//������� 1� ������� � �����

	 	 			for ( ii = 0; ii < 35; ii++)
					//for ( ii = 0; ii < 28; ii++)
	 	 				{
	 	 				eff111[ii] = eff111[ii + 1];//�������� ������� �� ���� ������� �����
						//numbers[ii] = numbers[ii + 1];//�������� ������� �� ���� ������� �����
	 	 				 }
	 	 			eff111[35] = buf[35];//�������� ���������� ������ (������ �������) � ����� �������
					//numbers[28] = buf[28];
	 	 		
}
for ( ip = 0; ip < 400; ++ip) 
				{
          GPIOC->ODR = eff111[l];//
					//GPIOC->ODR = numbers[l];
					GPIOD->ODR &= ~(1<<6);
					delay (500);//
					GPIOD->ODR |= (1<<6);
					GPIOC->ODR &= ~((1<<7) | (1<<6) | (1<<5) | (1<<4) | (1<<3));//������� ����� ++
					l--;
	 	 			y++;
	 	 			if (y == 8) {
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
	
	GPIOD->DDR &= ~((1<<5) | (1<<4) | (1<<3) | (1<<2) | (1<<1));//����
	GPIOD->CR1 |= (1<<5) | (1<<4) | (1<<3) | (1<<2) | (1<<1);//���� � ������������� ����������
	GPIOD->CR2 |= (1<<5) | (1<<4) | (1<<3) | (1<<2) | (1<<1);//�������� ������������ - �� 10 ���.
	GPIOD->DDR |= (1<<6);//�����
  GPIOD->CR1 |= (1<<6);//
	GPIOD->CR2 |= (1<<6);//
	
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
		I2C->CCRH =0;
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
	raand();
	GPIOA->ODR |= (1<<3);
	delay (20);
	GPIOA->ODR &= ~(1<<3);
	delay (5000);
    DS1307init();
	while (1){
		unsigned char iu;
	if (iii > 36) {
	 			raand();
	 			iii = 0;
	 		}
			
			
		while (!((GPIOD->IDR & (1 << 5)))){
		//	DS1307init();
			
		} //��� 0 �����
		
		
		//while ((GPIOD->IDR & (1 << 5))){} //��� 1 �����
		fraim_out(fraim, 0);
		//	DS1307init();
			//fraim_out(fraim, 0);



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



