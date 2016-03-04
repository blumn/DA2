__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
.global	init_port
	.type	init_port, @function
init_port:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	in r24,0x7       /* SET PORTC.0 PORTC.5 as output*/
	ori r24,lo8(35)
	out 0x7,r24     /*SET PORTD.4 (PIN TO) as input*/
	cbi 0xa,4
	ldi r24,lo8(-1)
	out 0x4,r24    /*SET PORTB as output*/
	ret
	.size	init_port, .-init_port
.global	init_counter0
	.type	init_counter0, @function
init_counter0:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r24,lo8(4)
	out 0x27,r24   /*for Intput capture value at 5th pulse*/
	ldi r24,lo8(9)
	out 0x28,r24   /*for Intput capture value at 10th pusle*/ 
	in r24,0x15
	ori r24,lo8(6)
	out 0x15,r24  /*clear the capture flag*/
	in r24,0x25
	ori r24,lo8(7)
	out 0x25,r24 /*set clock as external*/
	ret
	.size	init_counter0, .-init_counter0
	.section	.text.startup,"ax",@progbits
.global	main
	.type	main, @function
main:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	call init_port
	call init_counter0
	ldi r25,lo8(2)
	ldi r18,lo8(32)
.L5:
/* start of while(1)*/
	ldi r19,lo8(399999)
	ldi r20,hi8(399999)
	ldi r24,hlo8(399999)
	1: subi r19,1
	sbci r20,0
	sbci r24,0
	brne 1b
	rjmp .
	nop
	cbi 0x8,0
	ldi r19,lo8(399999)
	ldi r20,hi8(399999)
	ldi r24,hlo8(399999)
	1: subi r19,1
	sbci r20,0
	sbci r24,0
	brne 1b
	rjmp .
	nop
	sbi 0x8,0
/* cheacking capture flags*/	
	sbis 0x15,1
	rjmp .L4
	in r24,0x8
	eor r24,r25
	out 0x8,r24
	in r24,0x27
	subi r24,lo8(-(5))
	out 0x27,r24
	sbi 0x15,1
.L4:
	sbis 0x15,2
	rjmp .L5
	in r24,0x8
	eor r24,r18
	out 0x8,r24
	in r24,0x8
	eor r24,r25
	out 0x8,r24
	in r24,0x28
	subi r24,lo8(-(10))
	out 0x28,r24
	sbi 0x15,2
	rjmp .L5
	.size	main, .-main
	.ident	"GCC: (GNU) 4.9.1"
