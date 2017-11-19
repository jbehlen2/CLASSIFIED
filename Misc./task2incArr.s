.text
.global _incArr
.extern _increment

_incArr:
	subi sp,sp,16
	stw ra,12(sp)
	stw r2,8(sp)
	stw r3,4(sp)
	stw r4,0(sp)
	ldw r2,16(sp)
	addi r3,r3,7
	
LOOP2:
	subi sp,sp,4
	ldb r4,0(r2)
	stw r4,0(sp)
	
	call _increment
	
	ldw r4,0(sp)
	stb r4,0(r2)
	addi r2,r2,1
	subi r3,r3,1
	addi sp,sp,4
	bne r3,r0,LOOP2
	
	ldw r4,0(sp)
	ldw r3,4(sp)
	ldw r2,8(sp)
	ldw ra,12(sp)
	addi sp,sp,16
ret
