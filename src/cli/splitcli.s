.include "macros.inc"

.export splitcli

.importzp cmdname
.importzp arg1
.importzp arg2
.importzp arg3
.import line_buffer

; INTERNAL proc. Advances X until *(line_buffer+X) is '\0' or *not* ' '. If
; condition is already met, immediately exit.
;
; on entry:
; 	X - index into line_buffer
;
; on exit:
; 	X - new index into line_buffer
; 	A - character at line_buffer+X
.proc nexttok
@loop:
	lda line_buffer, X	; get next char
	beq @exit		; == 0, exit
	cmp #' '		; != ' ', exit
	bne @exit
	inx			; increment X and loop
	bra @loop
@exit:
	rts			; return
.endproc

; INTERNAL proc. Advances X until *(line_buffer+X) is '\0' or ' '. If condition
; is already met, immediately exit.
;
; on entry:
; 	X - index into line_buffer
;
; on exit:
; 	A - character at line_buffer+X
; 	X - new index into line_buffer
.proc nextspace
@loop:
	lda line_buffer, X	; get next char
	beq @exit		; == 0, exit
	cmp #' '		; == ' ', exit
	beq @exit
	inx			; increment X and loop
	bra @loop
@exit:
	rts			; return
.endproc

; INTERNAL proc. Stores the offset of the next non-empty token to Y, advances X
; to just after the token (or to the end of the input), writes a NUL and, if
; we're not yet at the end of the input, advances X beyond the NUL byte.
;
; on entry:
; 	X - index into line_buffer
;
; on exit:
; 	A - character at line_buffer+X, is '\0' if we've at the end of input
; 	X - new index into line_buffer
; 	Y - index of start of token
.proc findnext
	txa			; X = Y
	tay

	jsr nexttok		; find first token
	cmp #0			; is end of line?
	beq @exit		; yup, skip to next
	txa			; store offset in Y
	tay
	jsr nextspace		; find end
	cmp #0			; is end of line?
	beq @exit		; yup, skip to next
	stz line_buffer, X	; no, replace with '\0'
	inx			; next char
	lda line_buffer, X	; update A
@exit:
	rts
.endproc

; Splits line_buffer at spaces recording the offsets of the tokens in
; arg{1,2,3}. The buffer is modified replacing any spaces with NUL bytes
; line_buffer+arg{1,2,3} become C-style strings for the first
; three tokens.
;
.proc splitcli
	push_axy		; save state

	ldx #0

	jsr findnext		; find command
	sty cmdname
	jsr findnext		; find arg 1
	sty arg1
	jsr findnext		; find arg 2
	sty arg2
	jsr findnext		; find arg 3
	sty arg3

	pop_axy			; restore state and return
	rts
.endproc
