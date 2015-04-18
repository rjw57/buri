; OS vector table
;
; Jump table stored in RAM used to vector OS calls such as get/put character.
; This jump table is initialised by init_osvecs.

.export init_osvecs
.export putc, getc

.import srl_putc, srl_getc, syscall

	.rodata
init_vec_table_start:
	.word	srl_putc
	.word	srl_getc
	.word	syscall
init_vec_table_end:
init_vec_table_len = (init_vec_table_end - init_vec_table_start) / 2

	.segment "OSVECTORS"
os_vectors:
v_putc:		.res 2
v_getc:		.res 2
v_osbyte:	.res 2

	.code
putc:	jmp (v_putc)
getc:	jmp (v_getc)

.proc init_osvecs
	pha
	phy

	ldy #0
@loop:
	lda init_vec_table_start, Y
	sta os_vectors, Y
	iny
	lda init_vec_table_start, Y
	sta os_vectors, Y
	iny

	cpy #2*init_vec_table_len
	bne @loop

	ply
	pla
	rts
.endproc
