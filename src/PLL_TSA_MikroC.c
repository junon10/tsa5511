#include "built_in.h"

//==============================================================================
// Project: TSA5511/12 Dip Switch PLL 
// Compiler: MikroC Pro for pic version 7.6.0 (demo)
// Microcontroller: PIC16F628A
// Author: Junon M
//==============================================================================

//==============================================================================
// Reference Xtal TSA5511/12
//==============================================================================
#define  Crystal 3200000  //4000000Hz  (Better with 3,2MHz 3200000)
//==============================================================================

//==============================================================================
// Dip Switch Factor
//==============================================================================
#define  Factor   1080 // 82,5MHz a 108MHz  Pira.cz App
//==============================================================================

#define LOCK_LED_PIN  PORTA.B1
#define LOCK_LED_DIR  TRISA.B1

sbit Soft_I2C_Scl           at RA2_bit;
sbit Soft_I2C_Sda           at RA3_bit;
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

  LOCK_LED_DIR = 0;

  OPTION_REG.B7 = 0;
  CMCON = 0x07;

  Soft_I2C_Init();

  Factor_N_Divider = ((Crystal / 512) * 8) / 100;
  Keys =~ PORTB;
  Frequency = Factor - Keys;
  Frequency *= 1000;
  N_Divider = Frequency / Factor_N_Divider;

  Soft_I2C_Start();
  Soft_I2C_Write(0xC2);
  Soft_I2C_Write(Hi(N_Divider));
  Soft_I2C_Write(Lo(N_Divider));
  
  // Fase Detector Current = 220uA (quick tune)
  Soft_I2C_Write(0b11001110); // 220ua
  
  Soft_I2C_Write(0xFF); // Enabled All TSA5511/12 GPIOs
  Soft_I2C_Stop();

  delay_ms(2000); // time to tune in
  LOCK_LED_PIN = 1;

  Soft_I2C_Start();
  Soft_I2C_Write(0xC2);
  Soft_I2C_Write(Hi(N_Divider));
  Soft_I2C_Write(Lo(N_Divider));
  
  // Fase Detector Current = 50uA (slow tune)
  Soft_I2C_Write(0b10001110); // 50ua
  
  Soft_I2C_Write(0xFF); // Enabled All TSA5511/12 GPIOs
  Soft_I2C_Stop();
}