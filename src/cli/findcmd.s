.include "macros.inc"

.export findcmd

.importzp ptr1, ptr2, ptr3, cmdname
.import line_buffer
.import streq
.import __CMDTBL_LOAD__, __CMDTBL_SIZE__

.import putln, puts, putc

; findcmd - search for command by name in command table
;
; on entry:
; 	cmdname - pointer to C-style sring with command name
;
; on exit:
; 	A - 0 if command not found, non-zero otherwise
; 	ptr1 - pointer to command entry point if found, corrupted othewise
.proc findcmd
	phx				; save state
	phy
	ldx ptr2
	phx
	ldx ptr2+1
	phx
	ldx ptr3
	phx
	ldx ptr3+1
	phx

	ldw ptr2, line_buffer		; ptr2 = start of command name
	lda cmdname
	add_word ptr2

	ldw ptr3, __CMDTBL_LOAD__	; ptr3 = start of command table
@search_loop:
	ldax_abs __CMDTBL_LOAD__ + __CMDTBL_SIZE__
	cmp ptr3			; low byte ptr3 == low byte end of table?
	bne @test_entry			; no, need not test high byte
	cpx ptr3+1			; high byte ptr3 == high byte end of table?
	beq @failed			; yes, not found command, fail

@test_entry:
	copy_word ptr1, ptr3		; *ptr1 <- *ptr3

	lda #3				; increment ptr1 to start of name
	add_word ptr1

	jsr streq			; string @ ptr1 == string @ ptr2?
	cmp #0
	beq @no_match			; no, loop
	
	; We have a match!

	ldy #1
	lda (ptr3), Y			; copy low byte of entry poiny
	sta ptr1
	iny
	lda (ptr3), Y			; copy high byte of entry poiny
	sta ptr1+1

	lda #1				; exit with success
	bra @exit

@no_match:
	lda (ptr3)			; load length of entry from ptr3
	add_word ptr3			; add length to ptr3
	bra @search_loop
@failed:
	lda #0
@exit:
	plx
	stx ptr3+1
	plx
	stx ptr3
	plx
	stx ptr2+1
	plx
	stx ptr2
	ply
	plx				; restore state
	rts
.endproc
