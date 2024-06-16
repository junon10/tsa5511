
_main:

;PLL_TSA_MikroC.c,34 :: 		void main(){
;PLL_TSA_MikroC.c,36 :: 		Factor_N_Divider = 0;
	CLRF       _Factor_N_Divider+0
	CLRF       _Factor_N_Divider+1
	CLRF       _Factor_N_Divider+2
	CLRF       _Factor_N_Divider+3
;PLL_TSA_MikroC.c,37 :: 		Frequency = 0;
	CLRF       _Frequency+0
	CLRF       _Frequency+1
	CLRF       _Frequency+2
	CLRF       _Frequency+3
;PLL_TSA_MikroC.c,38 :: 		N_Divider = 0;
	CLRF       _N_Divider+0
	CLRF       _N_Divider+1
;PLL_TSA_MikroC.c,39 :: 		Keys = 0;
	CLRF       _Keys+0
;PLL_TSA_MikroC.c,41 :: 		PORTA = 0;
	CLRF       PORTA+0
;PLL_TSA_MikroC.c,42 :: 		PORTB = 0;
	CLRF       PORTB+0
;PLL_TSA_MikroC.c,43 :: 		TRISA = 0xFF;
	MOVLW      255
	MOVWF      TRISA+0
;PLL_TSA_MikroC.c,44 :: 		TRISB = 0xFF;
	MOVLW      255
	MOVWF      TRISB+0
;PLL_TSA_MikroC.c,46 :: 		LOCK_LED_DIR = 0;
	BCF        TRISA+0, 1
;PLL_TSA_MikroC.c,48 :: 		OPTION_REG.B7 = 0;
	BCF        OPTION_REG+0, 7
;PLL_TSA_MikroC.c,49 :: 		CMCON = 0x07;
	MOVLW      7
	MOVWF      CMCON+0
;PLL_TSA_MikroC.c,51 :: 		Soft_I2C_Init();
	CALL       _Soft_I2C_Init+0
;PLL_TSA_MikroC.c,53 :: 		Factor_N_Divider = ((Crystal / 512) * 8) / 100;
	MOVLW      244
	MOVWF      _Factor_N_Divider+0
	MOVLW      1
	MOVWF      _Factor_N_Divider+1
	MOVLW      0
	MOVWF      _Factor_N_Divider+2
	MOVLW      0
	MOVWF      _Factor_N_Divider+3
;PLL_TSA_MikroC.c,54 :: 		Keys =~ PORTB;
	COMF       PORTB+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      _Keys+0
;PLL_TSA_MikroC.c,55 :: 		Frequency = Factor - Keys;
	MOVF       R0+0, 0
	SUBLW      56
	MOVWF      _Frequency+0
	MOVLW      0
	BTFSS      STATUS+0, 0
	ADDLW      1
	SUBLW      4
	MOVWF      _Frequency+1
	MOVLW      0
	BTFSC      _Frequency+1, 7
	MOVLW      255
	MOVWF      _Frequency+2
	MOVWF      _Frequency+3
;PLL_TSA_MikroC.c,56 :: 		Frequency *= 1000;
	MOVF       _Frequency+0, 0
	MOVWF      R0+0
	MOVF       _Frequency+1, 0
	MOVWF      R0+1
	MOVF       _Frequency+2, 0
	MOVWF      R0+2
	MOVF       _Frequency+3, 0
	MOVWF      R0+3
	MOVLW      232
	MOVWF      R4+0
	MOVLW      3
	MOVWF      R4+1
	CLRF       R4+2
	CLRF       R4+3
	CALL       _Mul_32x32_U+0
	MOVF       R0+0, 0
	MOVWF      _Frequency+0
	MOVF       R0+1, 0
	MOVWF      _Frequency+1
	MOVF       R0+2, 0
	MOVWF      _Frequency+2
	MOVF       R0+3, 0
	MOVWF      _Frequency+3
;PLL_TSA_MikroC.c,57 :: 		N_Divider = Frequency / Factor_N_Divider;
	MOVLW      244
	MOVWF      R4+0
	MOVLW      1
	MOVWF      R4+1
	MOVLW      0
	MOVWF      R4+2
	MOVLW      0
	MOVWF      R4+3
	CALL       _Div_32x32_U+0
	MOVF       R0+0, 0
	MOVWF      _N_Divider+0
	MOVF       R0+1, 0
	MOVWF      _N_Divider+1
;PLL_TSA_MikroC.c,59 :: 		Soft_I2C_Start();
	CALL       _Soft_I2C_Start+0
;PLL_TSA_MikroC.c,60 :: 		Soft_I2C_Write(0xC2);
	MOVLW      194
	MOVWF      FARG_Soft_I2C_Write_data_+0
	CALL       _Soft_I2C_Write+0
;PLL_TSA_MikroC.c,61 :: 		Soft_I2C_Write(Hi(N_Divider));
	MOVF       _N_Divider+1, 0
	MOVWF      FARG_Soft_I2C_Write_data_+0
	CALL       _Soft_I2C_Write+0
;PLL_TSA_MikroC.c,62 :: 		Soft_I2C_Write(Lo(N_Divider));
	MOVF       _N_Divider+0, 0
	MOVWF      FARG_Soft_I2C_Write_data_+0
	CALL       _Soft_I2C_Write+0
;PLL_TSA_MikroC.c,65 :: 		Soft_I2C_Write(0b11001110); // 220ua
	MOVLW      206
	MOVWF      FARG_Soft_I2C_Write_data_+0
	CALL       _Soft_I2C_Write+0
;PLL_TSA_MikroC.c,67 :: 		Soft_I2C_Write(0xFF); // Enabled All TSA5511/12 GPIOs
	MOVLW      255
	MOVWF      FARG_Soft_I2C_Write_data_+0
	CALL       _Soft_I2C_Write+0
;PLL_TSA_MikroC.c,68 :: 		Soft_I2C_Stop();
	CALL       _Soft_I2C_Stop+0
;PLL_TSA_MikroC.c,70 :: 		delay_ms(2000); // time to tune in
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_main0:
	DECFSZ     R13+0, 1
	GOTO       L_main0
	DECFSZ     R12+0, 1
	GOTO       L_main0
	DECFSZ     R11+0, 1
	GOTO       L_main0
	NOP
	NOP
;PLL_TSA_MikroC.c,71 :: 		LOCK_LED_PIN = 1;
	BSF        PORTA+0, 1
;PLL_TSA_MikroC.c,73 :: 		Soft_I2C_Start();
	CALL       _Soft_I2C_Start+0
;PLL_TSA_MikroC.c,74 :: 		Soft_I2C_Write(0xC2);
	MOVLW      194
	MOVWF      FARG_Soft_I2C_Write_data_+0
	CALL       _Soft_I2C_Write+0
;PLL_TSA_MikroC.c,75 :: 		Soft_I2C_Write(Hi(N_Divider));
	MOVF       _N_Divider+1, 0
	MOVWF      FARG_Soft_I2C_Write_data_+0
	CALL       _Soft_I2C_Write+0
;PLL_TSA_MikroC.c,76 :: 		Soft_I2C_Write(Lo(N_Divider));
	MOVF       _N_Divider+0, 0
	MOVWF      FARG_Soft_I2C_Write_data_+0
	CALL       _Soft_I2C_Write+0
;PLL_TSA_MikroC.c,79 :: 		Soft_I2C_Write(0b10001110); // 50ua
	MOVLW      142
	MOVWF      FARG_Soft_I2C_Write_data_+0
	CALL       _Soft_I2C_Write+0
;PLL_TSA_MikroC.c,81 :: 		Soft_I2C_Write(0xFF); // Enabled All TSA5511/12 GPIOs
	MOVLW      255
	MOVWF      FARG_Soft_I2C_Write_data_+0
	CALL       _Soft_I2C_Write+0
;PLL_TSA_MikroC.c,82 :: 		Soft_I2C_Stop();
	CALL       _Soft_I2C_Stop+0
;PLL_TSA_MikroC.c,83 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
