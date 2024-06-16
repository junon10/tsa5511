#line 1 "D:/Docs/Develop/Projetos/My_GitHub/junon10/tsa5511/PLL_TSA_MikroC.c"
#line 1 "c:/users/public/documents/mikroelektronika/mikroc pro for pic/include/built_in.h"
#line 25 "D:/Docs/Develop/Projetos/My_GitHub/junon10/tsa5511/PLL_TSA_MikroC.c"
sbit Soft_I2C_Scl at RA2_bit;
sbit Soft_I2C_Sda at RA3_bit;
sbit Soft_I2C_Scl_Direction at TRISA2_bit;
sbit Soft_I2C_Sda_Direction at TRISA3_bit;

unsigned long Frequency, Factor_N_Divider;
unsigned int N_Divider;
unsigned short Keys;

void main(){

 Factor_N_Divider = 0;
 Frequency = 0;
 N_Divider = 0;
 Keys = 0;

 PORTA = 0;
 PORTB = 0;
 TRISA = 0xFF;
 TRISB = 0xFF;

  TRISA.B1  = 0;

 OPTION_REG.B7 = 0;
 CMCON = 0x07;

 Soft_I2C_Init();

 Factor_N_Divider = (( 3200000  / 512) * 8) / 100;
 Keys =~ PORTB;
 Frequency =  1080  - Keys;
 Frequency *= 1000;
 N_Divider = Frequency / Factor_N_Divider;

 Soft_I2C_Start();
 Soft_I2C_Write(0xC2);
 Soft_I2C_Write( ((char *)&N_Divider)[1] );
 Soft_I2C_Write( ((char *)&N_Divider)[0] );


 Soft_I2C_Write(0b11001110);

 Soft_I2C_Write(0xFF);
 Soft_I2C_Stop();

 delay_ms(2000);
  PORTA.B1  = 1;

 Soft_I2C_Start();
 Soft_I2C_Write(0xC2);
 Soft_I2C_Write( ((char *)&N_Divider)[1] );
 Soft_I2C_Write( ((char *)&N_Divider)[0] );


 Soft_I2C_Write(0b10001110);

 Soft_I2C_Write(0xFF);
 Soft_I2C_Stop();
}
