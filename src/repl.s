;
; Read, Eval, Print Loop (REPL)
;
.include "io.inc"

.global repl
.proc repl
	; Print prompt
	lda	#'*'
	jsr	srl_putc
	lda	#' '
	jsr	srl_putc

@spin:	jmp @spin
.endproc
