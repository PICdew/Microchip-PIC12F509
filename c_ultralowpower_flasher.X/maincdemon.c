#include <xc.h>
#define _XTAL_FREQ 4000000

// CONFIG
#pragma config OSC = IntRC      // Oscillator Selection bits (internal RC oscillator)
#pragma config WDT = OFF        // Watchdog Timer Enable bit (WDT disabled)
#pragma config CP = OFF         // Code Protection bit (Code protection off)
#pragma config MCLRE = OFF      // GP3/MCLR Pin Function Select bit (GP3/MCLR pin function is digital input, MCLR internally tied to VDD)

void main(void) {
    TRISGPIO = 0xFE;
    while(1){
        GPIObits.GP0 = 0;
        retardon2();
        GPIObits.GP0 = 1;
        retardon();
    }
}

retardon(){
    for(int i=0;i<200;i++){
        for(int j=0;j<20;j++){
            asm("nop"); 
        }
    }
}

retardon2(){
    for(int k=0;k<200;k++){
        for(int l=0;l<30;l++){
            for(int m=0;m<10;m++){
                asm("nop");
            }
        }
    }
}