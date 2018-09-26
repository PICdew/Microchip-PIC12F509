    ;A very low power LED flasher using PIC12F509 microcontroller
    ;Author: Kalun Lau
    ;Changelog:
    ;23-09-2018: Initial brainstorm, reading and trying to figure out how
    ;		 to program the device, using Proteus to simulate. First
    ;		 attempt on MPASM showed many errors due to different syntax
    ;		 between PIC18 and PIC12 baseline microcontrollers. Tried to
    ;		 do a delay routine using nested repetitive loops but failed.
    ;25-09-2018: Learned that there are dedicated instructions to set TRIS
    ;		 register(tris) and OPTION register (option) on baseline micros
    ;		 Timer0 module doesn't have overflow flag! Learned that WDT
    ;		 wakes up the micro and it has an period time of 18ms between
    ;		 overflows, WDT can be used with prescaler (from Timer0) in
    ;		 order to extend the period, up to 2.3 seconds on PSC 1:128.
    ;		 Made some modifications on the code in order to use the WDT
    ;		 as the delay function of the LED flasher and putting the
    ;		 micro on SLEEP in between. This reduces the power consumption
    ;		 down to 350nA @ 5V while on sleep periods.
    
    list p=12f509
    #include <p12f509.inc>

    __CONFIG _OSC_IntRC & _WDT_ON & _CP_OFF & _MCLRE_OFF
 
    org 0x0000
    goto configuracion
    
configuracion:
    movlw 0xFE
    tris 6		;Puerto GPIO.0 como salida (conectado al LED)
    
inicio:
    btfss GPIO, 0
    goto encendido
    bcf GPIO, 0
    movlw 0xFF
    option		;Prescaler para WDT (PSA=1) y valor 1:128, 2.3s periodo
    sleep
encendido:
    bsf GPIO, 0
    movlw 0xFA
    option		;Prescaler para WDT (PSA=1) y valor 1:4, 72ms periodo
    sleep

    end