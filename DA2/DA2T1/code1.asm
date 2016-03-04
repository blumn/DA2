__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
.global	init_port
	.type	init_port, @function
/* initialisation of ports */	
init_port:  
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	in r24,0x7         /*SET PORTC.0 PORTC.5 as output*/
	ori r24,lo8(35)
	out 0x7,r24       /* SET PORTD.4 (PIN TO) as input*/
	cbi 0xa,4
	ldi r24,lo8(-1)
	out 0x4,r24      /*SET PORTB as output*/
	ret
	.size	init_port, .-init_port
	.section	.text.startup,"ax",@progbits
.global	main
	.type	main, @function
main:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	call init_port
.L3:
/* start of a continuos loop while(1)*/
/* delay 250 ms*/
	ldi r18,lo8(399999)
	ldi r24,hi8(399999)
	ldi r25,hlo8(399999)
	1: subi r18,1	
	sbci r24,0
	sbci r25,0
	brne 1b
	rjmp .
	nop
/* send low */	
	cbi 0x8,0
	ldi r18,lo8(399999)
	ldi r24,hi8(399999)
	ldi r25,hlo8(399999)
	1: subi r18,1
	sbci r24,0
	sbci r25,0
	brne 1b
	rjmp .
	nop
/* send high */	
	sbi 0x8,0
	rjmp .L3
	.size	main, .-main
	.ident	"GCC: (GNU) 4.9.1"
