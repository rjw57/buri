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
	jsr	scrn_putc
	lda	#' '
	jsr	scrn_putc

@loop:
	; Simple echo loop
	jsr	srl_getc		; A = next character
	sta	tmp1			; copy to temporary

	lda	#ASCII_BS
	cmp	tmp1			; compare to back space
	bne	@not_bs			; if not equal, continue
@is_bs:
	ldx	line_len		; look at input buffer length
	beq	@loop			; ignore backspace if already zero

	dex				; decrement line length
	stx	line_len		; record new length

	lda	tmp1
	jsr	scrn_putc		; echo character to console
	jmp	@loop			; wait for next character
@not_bs:

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

	jsr	scrn_putc		; echo character to console
	jmp	@loop			; wait for next character
@parse_line:
	lda	#ASCII_CR
	jsr	scrn_putc
	lda	#ASCII_NL
	jsr	scrn_putc		; advance to next line

	lda	line_len		; load line length
	beq	@parse_end		; do nothing more if zero

@print_cmd_test:
	lda	#'p'			; 'p' - print memory location
	cmp	line_buffer		; look at first character
	bne	@parse_no_command
@print_cmd_impl:
	;; TODO: implement
	jmp	@parse_ok

	;; TODO: more commands

@parse_no_command:
	WriteLnString str_nsc
	jmp	@parse_end
@parse_ok:
	WriteLnString str_ok
@parse_end:
	lda	#0
	sta	line_len		; reset line length
@prompt_next:
	jmp	@prompt

@spin:	jmp @spin
.endproc
