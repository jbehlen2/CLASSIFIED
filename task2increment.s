.text
.global _increment

_increment:
	subi sp,sp,20
	stw ra,16(sp)
	stw r2,12(sp)
	stw r3,8(sp)
	stw r4,4(sp)
	stw r5,0(sp)
	
	movia r10, 0x10000040 /* SWITCH */
	movia r11, 0x10000000 /* RLED */
	movia r12, 0x10000050 /* BUTTON */
	ldw r2,20(sp)
	addi r4,r4,10000
	
NO_BUTTON:
	ldw r5,0(r12)
	bne r5,r0,BUTTON
	br NO_BUTTON

BUTTON:
	ldwio r3,0(r10)
	stwio r3,0(r11)
	ldw r5,0(r12)
	bne r5,r0,BUTTON
	
WAIT:
	subi r4,r4,1
	bne r4,r0,WAIT
	
	add r2,r2,r3
	stw r2,20(sp)
	
	stw r5,0(sp)
	ldw r4,4(sp)
	ldw r3,8(sp)
	ldw r2,12(sp)
	ldw ra,16(sp)
	addi sp,sp,20
ret