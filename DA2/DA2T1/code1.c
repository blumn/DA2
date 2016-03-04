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


int main(void)
{
	init_port();

    while(1)
    {
		_delay_ms(250);
		PORTC &= ~(0x01);
		_delay_ms(250);
		PORTC |= 0x01;
	}
		
 }