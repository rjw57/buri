;
; I/O routines
;
.include "globals.inc"
.include "io.inc"
.include "hardware.inc"

;;
;; Character I/O.
;;

;; Wait for the Tx data register to be empty. Corrupts A.
.macro WaitTxFree
	lda	#ACIA_ST_TDRE		; TDRE mask
@wait_tx_free:
	bit	ACIA1_STATUS		; look at TDRE bit
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
@exit:
	rts
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

; Get next character into A. Blocks until character arrives.
.proc srl_getc
@wait_loop:
	lda	srl_buf_len		; get input buffer length
	beq	@wait_loop		; if empty, loop

	ldx	srl_buf_start		; head of ring-buffer
	ldy	srl_buffer, X		; load next character
	
	inx				; advance ring buffer pointer
	stx	srl_buf_start		; write back
	lda	#SRL_BUF_MASK
	and	srl_buf_start		; handle wrapping
	sta	srl_buf_start		; write back wrapped value

	ldx	srl_buf_len		; load buffer length
	dex				; decrement
	stx	srl_buf_len		; write back

	tya				; copy next character to A

	rts
.endproc

; Clear screen memory. On entry, A is value to fill memory with. On exit cursor
; position is reset to 0,0.
.proc scrn_clear
	; Push A onto stack
	pha

	; Load address of screen start into ZP ptr{1,2}
	lda	#<SCREEN_START
	sta	ptr1
	lda	#>SCREEN_START
	sta	ptr1+1

	; A stores value to be written. X counts down the number of pages left to write.
	pla
	ldx	#SCREEN_N_PGS

@pg_loop:
	; Clear one page starting at ptr1. Y ranges from 0x00 to 0xFF.
	; A is unchanged
	ldy	#$00
@loop:
	sta	(ptr1), Y
	iny
	bne	@loop

	inc	ptr1+1			; increment MSB of screen address
	dex				; decrement page counter
	bne	@pg_loop		; loop if work left to be done

	; Reset cursor position
	lda	#$00
	sta	tx
	sta	ty
	lda	#<SCREEN_START
	sta	taddr
	lda	#>SCREEN_START
	sta	taddr+1

	rts				; return to caller
.endproc

; Put a character to the screen. On entry, A is the character to put. Will
; advance text cursor to next position.
;
; TODO: vertical scrolling
.proc scrn_putc
	ldx	#ASCII_NL		; is this a newline?
	stx	tmp1
	cmp	tmp1
	beq	@linefeed		; yes, perform a line feed

	ldx	#ASCII_CR		; is this a carriage return?
	stx	tmp1
	cmp	tmp1
	beq	@carriage_return	; yes, perform a carriage return

	; if we get here, A is some other character

	ldy	tx			; write A at taddr + cx
	sta	(taddr), y
	inc	tx			; advance cursor position

	lda	#SCREEN_COLS		; compare tx to SCREEN_COLS
	cmp	tx
	bne	@exit			; if not equal, our job is done
	
@linefeed:
	; increment ty to move down
	inc	ty

	; add SCREEN_COLS to taddr
	clc
	lda	#SCREEN_COLS
	adc	taddr
	sta	taddr

	; check carry flag to see if we need to increment taddr+1
	bcc	@exit
	inc	taddr+1

@carriage_return:
	lda	#$00			; reset tx to zero
	sta	tx

@exit:
	rts
.endproc

; Output characters from a buffer.
; Entry:
;	A - number of bytes to write
;	ptr1 - pointer to buffer
; Exit:
;	A, X, Y - not preserved
.proc scrn_puts
	tax				; save A into X
	beq	@exit			; shortcut if A == 0

	; Write output characters decrementing X until X == 0
	lda	#$00
	tay
@write_loop:
	; preserve X and Y before jumping to scrn_putc
	txa
	pha
	tya
	pha

	lda	(ptr1), Y		; load output byte
	jsr	scrn_putc		; output character

	; restore X and Y
	pla
	tay
	pla
	tax

	; Loop
	iny
	dex
	bne	@write_loop

@exit:
	rts				; return to caller
.endproc
