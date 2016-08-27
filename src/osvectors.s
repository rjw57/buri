; OS vector table
;
; OS "syscalls" are via the BRK instruction which is followed by a signature.
; This signature determines which OS syscall will be invoked. This file contains
; the jump table and handler rouine to dispatch a syscall to the correct OS
; routine.
;
.include "globals.inc"

.import srl_putc, srl_getc, syscall
.export putc, getc

putc = srl_putc
getc = srl_getc

; NOP syscall
.proc nop
	rts
.endproc

; OS jump table
.rodata
init_vec_table_start:
	.word	nop		; $00 - NOP
	.word	putc		; $01 - put character to output
	.word	getc		; $02 - get character from input
	.word	havec		; $03 - test if character available
init_vec_table_end:
init_vec_table_len = (init_vec_table_end - init_vec_table_start) / 2

.code

.global haveinput
.proc havec
	jsr	haveinput
	bcs	@input
	lda	#$00
	rts
@input:
	lda	#$FF
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

