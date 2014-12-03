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
	lda	#ACIA_ST_TDRE		; TDRE mask
@wait_tx_free:
	bit	acia1_status_cache	; look at TDRE bit
	beq	@wait_tx_free		; loop while clear
.endmacro

; Reset serial device.
; Exit:
;	A, X, Y - not preserved
.proc srl_reset
	;; Perform a software reset on ACIA1
	sta	ACIA1_STATUS

	;; Setup ACIA1 baudrate, parity, etc.
	lda	#%00011111		; 8 bits, 1 stop bit, 19200 baud
	sta	ACIA1_CTRL		; write control reg
	lda	#%00000101		; no parity, tx IRQ, IRQ enabled
	sta	ACIA1_CMD		; write command reg
	lda	ACIA1_DATA		; empty read register

	;; Cache ACIA1 status register
	lda	ACIA1_STATUS		; load status reg
	sta	acia1_status_cache	; store to cache
@exit:
	rts
.endproc

; Output single character
; Entry:
;	A - byte to output
; Exit:
;	A, X - not preserved
;	Y - preserved
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

