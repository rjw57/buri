;
; Read, Eval, Print Loop (REPL)
;
.include "globals.inc"
.include "io.inc"

.segment "RODATA"
str_ok:		PString "OK"
str_nsc:	PString "No such command"

.segment "CODE"

.global repl
.proc repl
@prompt:
	; Print prompt
	lda	#'*'
	jsr	srl_putc
	lda	#' '
	jsr	srl_putc

@loop:
	; Simple echo loop
	jsr	srl_getc		; A = next character
	sta	tmp1			; copy to temporary

	lda	#ASCII_CR
	cmp	tmp1			; compare to carriage return
	beq	@parse_line		; if equal, try to parse input buffer

	lda	#MAX_LINE		; maximum line length
	cmp	line_len		; current length of line
	beq	@loop			; overflow, drop input until CR

	lda	tmp1
	ldx	line_len
	sta	line_buffer, X		; store character in line buffer
	inx				; increment length
	stx	line_len		; record new length

	jsr	srl_putc		; echo character to console

	jmp	@loop			; wait for next character
@parse_line:
	lda	#ASCII_CR
	jsr	srl_putc
	lda	#ASCII_NL
	jsr	srl_putc		; advance to next line

	lda	line_len		; load line length
	beq	@parse_end		; do nothing more if zero

	;; TODO: more processing
@parse_no_command:
	WriteLnString str_nsc
@parse_end:
	lda	#0
	sta	line_len		; reset line length
@prompt_next:
	jmp	@prompt

@spin:	jmp @spin
.endproc
