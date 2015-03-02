.include "ascii.inc"
.include "macros.inc"
.include "strings.inc"

.importzp ptr1, ptr2, ptr3, tmp1, tmp2
.importzp arg1
.import line_buffer
.import parsehex16
.import puthex
.import bad_arg_err_

.import putln, haveinput, getc, putc

NAK_TIMEOUT = $84			; number of initial NAKs before timeout

; record command in command table
registercmd "xrecv", xrecv

; xrecv <addr>
;
; Receieves a file over XMODEM writing it to <addr>. See the XMODEM.TXT file
; for details on the protocol.
;
; [1] What with buffering being what it is and human delays in selecting the
; file at the sending size, we may have sent several NAKs which are "in flight"
; (i.e. buffered up) just before the sender actually starts sending. In this
; case the sender sees a flurry of NAKs at the beginning and tries to
; repeatedly re-send the firt packet. We are tolerant of this by hacking a
; special case whereby sending the first packet again resets the transer. This
; is ugly but means we can be a little looser in the timing of our initial
; NAKs.
;
; on entry:
; 	arg{1,2,3} - offsets into line_buffer of arguments 1, 2 and 3
;
; during receive:
; 	ptr2 - start address to write to
; 	ptr3 - current address to write to
; 	tmp1 - running checksum
; 	tmp2 - expected packet number
.proc xrecv
	pha
	save_xy
	save_word ptr1
	save_word ptr2
	save_word ptr3
	save_byte tmp1
	save_byte tmp2

	ldw ptr1, line_buffer		; *ptr1 = first argument
	lda arg1
	add_word ptr1

	ldx #1				; record this is arg1 in X
	jsr parsehex16			; parse ptr1 -> ptr2
	bcc args_parsed
	jsr bad_arg_err_
	jmp exit

args_parsed:
	; Show prompt
	ldw ptr1, prompt_str
	jsr putln

	; Perform an initial wait
	jsr waitinput_

	; Phase 1 - send NAK until we have some response

	ldx #0				; X = number of NAKs sent
nak_loop:
	lda #ASCII_NAK			; output NAK
	jsr putc

	jsr waitinput_			; wait for response
	bcs haveinitialpacket

	inx				; no response, increment NAK count
	cpx #NAK_TIMEOUT		; compare count to maximum
	bne nak_loop			; ok, send again
timedout:
	ldw ptr1, timeout_str		; timed out, report error and exit
	jsr putln
	bra abort

	; Phase 2 - start reading packets
haveinitialpacket:
	lda #1
	sta tmp2			; initial packet number
	copy_word ptr3, ptr2		; ptr3 <- ptr2

recvpacket:
	jsr getc			; should be SOH or EOT
	cmp #ASCII_EOT
	beq got_eot
	
	cmp #ASCII_SOH			; if it's not EOT, should be SOH
	bne abort

	jsr getc			; packet number
	cmp tmp2			; should be tmp2
	beq packt_num_ok

	cmp #1				; packet 1? (See note [1])
	bne abort			; nope, something else
	sta tmp2			; yes, reset transfer to initial packet
	copy_word ptr3, ptr2		; ptr3 <- ptr2
	
packt_num_ok:
	jsr getc			; 1s compliment of number (ignored)

	stz tmp1			; reset checksum
	ldy #0				; read 128 bytes
@loop:
	jsr getc
	sta (ptr3), Y
	add tmp1			; update checksum
	sta tmp1
	iny
	cpy #128
	bne @loop

	jsr getc			; read checksum
	cmp tmp1			; matches?
	beq chksum_ok			; yup

	lda #ASCII_NAK			; nope, NAK and listen again
	jsr putc
	bra recvpacket

chksum_ok:
	inc tmp2			; increment expected packet
	lda #128
	add_word ptr3			; increment ptr3 by 128 bytes

	lda #ASCII_ACK			; acknowledge
	jsr putc

	bra recvpacket			; wait for next packet

abort:	; Abort transfer by sending several CAN bytes and exiting
	ldx #10
	lda #ASCII_CAN
@loop:
	jsr putc
	dex
	cpx #0
	bne @loop
	ldw ptr1, err_str		; write error message
	jsr putln
	bra exit

got_eot:
	; Called if we've got an EOT. May be end of stream
	lda #ASCII_NAK			; send NAK
	jsr putc

	; HACK: for the moment comment this out since XMODEM implementations
	; seem to differ about what happens here
	jsr getc			; should be another EOT
;	cmp #ASCII_EOT
;	bne abort
	lda #ASCII_ACK			; send ACK
	jsr putc
	lda ptr3+1			; write <n written> OK
	jsr puthex
	lda ptr3
	jsr puthex
	lda #' '
	jsr putc
	ldw ptr1, ok_str
	jsr putln

exit:
	restore_byte tmp2
	restore_byte tmp1
	restore_word ptr3
	restore_word ptr2
	restore_word ptr1
	restore_xy
	pla
	rts
.endproc

; INTERNAL proc. Wait for input to be available. Set carry flag if input present.
.proc waitinput_
	pha
	save_xy

	ldy #0
yloop:
	ldx #0
xloop:
	jsr haveinput			; do we have any input?
	bcs exit			; yes!

	inx				; loop X
	cpx #0
	bne xloop

	iny				; loop Y
	cpy #0
	bne yloop

	clc				; timed out
exit:
	restore_xy
	pla
	rts
.endproc

.segment "RODATA"
prompt_str:
	cstring "Receiving via XMODEM..."
timeout_str:
	cstring "Timed out"
