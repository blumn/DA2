#include <avr/io.h>					//Header file for AVR device specific I/O Definition

#define F_CPU  8000000 // Clock Speed as 16MHz

#include <util/delay.h>                //Header file for incorporating delay routines.
#include <avr/interrupt.h>


void init_port()
{
	DDRC |= 0x23; // SET PORTC.0 PORTC.5 as output
	DDRD &= ~(0x10); // SET PORTD.4 (PIN TO) as input
	DDRB = 0xff; // SET PORTB as output
}

void init_counter0()
{
	OCR0A = 0x04; // for Intput capture value at 5th pulse
	OCR0B = 0x09; // for Intput capture value at 10th pusle

	TIFR0 |= (1<<OCF0A)|(1<<OCF0B); // clear the capture flag
	
    TCCR0B |= 0x07; // set clock as external
}


int main(void)
{
	init_port();
	init_counter0();
    while(1)
    {
		_delay_ms(250);
		PORTC &= ~(0x01);
		_delay_ms(250);
		PORTC |= 0x01;
						
	    if ((TIFR0&(1<<OCF0A))== (1<<OCF0A))
		{
			PORTC^=(1<<PC1);
			OCR0A+= 0x05;
			TIFR0 |= (1<<OCF0A);	
		}
		
		if ((TIFR0&(1<<OCF0B))== (1<<OCF0B))
		{
			PORTC^=(1<<PC5);
			PORTC^=(1<<PC1);
			OCR0B+= 0x0A;
			TIFR0 |= (1<<OCF0B);
		}
	}
		
 }