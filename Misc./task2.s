.text
.global _start
.extern _incArr

_start:
	movia r8, 0x10000020 /* HEX3_HEX0 */
	
	movia sp, 0x007FFFFC
	movia r2, ARR
	subi sp,sp,4
	stw r2,0(sp)
	
	call _incArr
	
	ldw r2,0(sp)
	addi sp,sp,4
	addi r3,r3,7
LOOP:
	ldb r4,0(r2)
	add r5,r5,r4
	addi r2,r2,1
	subi r3,r3,1
	bne r3,r0,LOOP
	
	movia r6,NUMS
	addi r3,r0,0
	addi r7,r7,63
	stbio r7,0(r8)
	stbio r7,1(r8)
	stbio r7,2(r8)
	stbio r7,3(r8)
THOUSANDS:
	addi r2,r0,1000
	blt r5,r2,HUNDREDS
	sub r5,r5,r2
	addi r3,r3,1
	bge r5,r2,THOUSANDS
	addi r8,r8,3
	br DISPLAY
HUNDREDS:
	addi r2,r0,100
	blt r5,r2,TENS
	sub r5,r5,r2
	addi r3,r3,1
	bge r5,r2,HUNDREDS
	addi r8,r8,2
	br DISPLAY
TENS:
	addi r2,r0,10
	blt r5,r2,ONES
	sub r5,r5,r2
	addi r3,r3,1
	bge r5,r2,TENS
	addi r8,r8,1
	br DISPLAY
ONES:
	addi r2,r0,1
	blt r5,r2,DISPLAY
	sub r5,r5,r2
	addi r3,r3,1
	bge r5,r2,ONES
	br DISPLAY
	
DISPLAY:
	add r6,r6,r3
	ldb r7,0(r6)
	sub r6,r6,r3
	addi r3,r0,0
	stbio r7,0(r8)
	movia r8, 0x10000020
	beq r5,r0,END
	br THOUSANDS
	
END: br END

.data
ARR:
	.byte 2,3,4,5,6,7,8
NUMS:
	.byte 63,6,91,79,102,109,125,7,127,103
	
.end
