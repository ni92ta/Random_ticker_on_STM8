//=======================�������� I2C================
	//I2C->CR1;//������� ���������� 1
	//0b00000000
	//  |||||||+--PE:Peripheral enable? ��������� ��������� (0-��������� ���������; 1-��������� ��������
	//  ||+++++---Reserved
	//  |+--------ENGC: General call enable. ��������� ������ ������ (0-����� ����� ��������, 1-�������)
	//  +---------NOSTRETCH: Clock stretching disable (Slave mode).���������� �������� ����� (0-�������� ��������, 0-��������
	//I2C->CR2;//������� ���������� 2
	//0b00000000
	//  |||||||+--START: Start generation. ������ ��������� (0-��������� ���������,1-��������� ������)
	//  ||||||+---STOP: Stop generation. ���������� ��������� (0-��������� ��� ���������, 1-���������� ��������� ����� �������� �����)
	//  |||||+----ACK: Acknowledge enable. ������������� ��������� (0-������������� �� ����������,1-������������� ������������ ����� �������� �����)
	//  ||||+-----POS: Acknowledge position. ������������� ������� (��� ����� ������)(0-ASK ��� �������� �����, 1-��� ASK ��� ���������� ����� (��� ������������ ����� ������_
	//  |+++------Reserved
	//  +---------SWRST: Software reset.����������� ����� (0-����� ��������,1-� ��������� ������)
	//I2C->FREQR;//������� �������
	//0b00000000
	//  |+++++++--FREQ[5:0] Peripheral clock frequency. (000000-�� �����������,000001-1���,000010-2���
	//  +---------Reserved
	//I2C->OARL;//����������� �������� ������� LSB
	//0b00000000
	//  |||||||+--ADD[0] Interface address. ����� ����������
	//  +++++++---ADD[7:1] Interface address. ����� ���������� 10-������ �����:��� 0 ������
	//I2C->OARH;//����������� �������� ������� MSB
	//0b00000000
	//  |||||||+--Reserved
	//  |||||++---ADD[9:8] Interface address.����� ����������.10-������ �����:���� 9:8
	//  ||+++-----Reserved
	//  |+--------ADDCONF Address mode configuration.������������ ������ ������. ���������� ��� � 1 ����������. ������ ������ ���� 1
	//  +---------ADDMODE Addressing mode (Slave mode).����� ���������(�������) (0-7-������ ����� �������, 1-10-������ ����� �������)
	//I2C->DR;//������� ������
	//I2C->SR1;//������� ��������� 1
	//0b00000000
	//  |||||||+--SB: Start bit (Master mode)
	//  ||||||+---
	//  |||||+----
	//  ||||+-----
	//  |||+------
	//  ||+-------
	//  |+--------
	//  +---------