;
; I/O routines
;
.include "globals.inc"
.include "io.inc"

;;
;; Character I/O.
;;

;; Wait for the Tx data register to be empty. Corrupts A.
.macro WaitTxFree
	lda	#ACIA_ST_TRDE		; TRDE mask
@wait_tx_free:
	bit	acia1_status_cache	; look at TRDE bit
	beq	@wait_tx_free		; loop while clear
.endmacro

; Output single character
; Entry:
;	A - byte to output
; Exit:
;	A, X - not preserved
;	Y - preserved
.global srl_putc
.proc srl_putc
	tax				; save A in X
	WaitTxFree			; wait for transmit data register to be empty
	stx	ACIA1_DATA		; write to tx data reg
	rts				; return
.endproc

; Output characters from a buffer.
; Entry:
;	A - number of bytes to write
;	ptr1 - pointer to buffer
; Exit:
;	A, X, Y - not preserved
.global srl_puts
.proc srl_puts
	tax				; save A into X
	beq	@exit			; shortcut if A == 0

	; Write output characters decrementing X until X == 0
	lda	#$00
	tay
@write_loop:
	WaitTxFree			; wait for transmit data register to be empty
	lda	(ptr1), Y		; load output byte
	sta	ACIA1_DATA		; write to tx data reg

	; Loop
	iny
	dex
	bne	@write_loop

@exit:
	rts
.endproc

