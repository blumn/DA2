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
	in r24,0x7
	ori r24,lo8(35)
	out 0x7,r24
	cbi 0xa,4
	ldi r24,lo8(-1)
	out 0x4,r24
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
	out 0x27,r24
	ldi r24,lo8(9)
	out 0x28,r24
	in r24,0x15
	ori r24,lo8(6)
	out 0x15,r24
	ldi r30,lo8(110)
	ldi r31,0
	ld r24,Z
	ori r24,lo8(6)
	st Z,r24
	in r24,0x25
	ori r24,lo8(7)
	out 0x25,r24
	ret
	.size	init_counter0, .-init_counter0
.global	__vector_14
	.type	__vector_14, @function
__vector_14:/* COMPA_Vector*/
	push r1
	push r0
	in r0,__SREG__
	push r0
	clr __zero_reg__
	push r24
	push r25
/* prologue: Signal */
/* frame size = 0 */
/* stack size = 5 */
.L__stack_usage = 5
	in r25,0x8
	ldi r24,lo8(2)
	eor r24,r25
	out 0x8,r24
	in r24,0x27
	subi r24,lo8(-(5))
	out 0x27,r24
/* epilogue start */
	pop r25
	pop r24
	pop r0
	out __SREG__,r0
	pop r0
	pop r1
	reti
	.size	__vector_14, .-__vector_14
.global	__vector_15
	.type	__vector_15, @function
__vector_15:  /* COMPB_Vector*/
	push r1
	push r0
	in r0,__SREG__
	push r0
	clr __zero_reg__
	push r24
	push r25
/* prologue: Signal */
/* frame size = 0 */
/* stack size = 5 */
.L__stack_usage = 5
	in r25,0x8
	ldi r24,lo8(32)
	eor r24,r25    /*xor operation is used to toggle*/
	out 0x8,r24
	in r25,0x8
	ldi r24,lo8(2)
	eor r24,r25
	out 0x8,r24
	in r24,0x28
	subi r24,lo8(-(10))
	out 0x28,r24
/* epilogue start */
	pop r25
	pop r24
	pop r0
	out __SREG__,r0
	pop r0
	pop r1
	reti
	.size	__vector_15, .-__vector_15
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
/* #APP */
 ;  48 "timer.c" 1
	sei
 ;  0 "" 2
/* #NOAPP */
.L6:
	ldi r18,lo8(399999)
	ldi r24,hi8(399999)
	ldi r25,hlo8(399999)
	1: subi r18,1
	sbci r24,0
	sbci r25,0
	brne 1b
	rjmp .
	nop
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
	sbi 0x8,0
	in r24,0x26
	out 0x5,r24
	rjmp .L6
	.size	main, .-main
	.ident	"GCC: (GNU) 4.9.1"
