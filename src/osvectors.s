; OS vector table
;
; Jump table stored in ROM used to vector OS calls such as get/put character.
.include "globals.inc"

.import srl_putc, srl_getc, syscall
.export putc, getc

putc = srl_putc
getc = srl_getc

; OS jump table
.rodata
init_vec_table_start:
	.word	nop
	.word	putc
	.word	getc
init_vec_table_end:
init_vec_table_len = (init_vec_table_end - init_vec_table_start) / 2

.code

; NOP syscall
.proc nop
	rts
.endproc

; Handle a BRK call. On entry, brk_signature is set to index of OS routine.
; A contains a parameter. On exit, A contains the return value. This call is
; free to corrupt X and Y.
.global handle_brk
.proc handle_brk
	pha			; Save A
	lda brk_signature	; A = brk_signature
	asl			; A <<= 1 (i.e. doubled)
	tax			; X = A
	pla			; Restore A

	jmp (init_vec_table_start, X) ; Jump
.endproc

