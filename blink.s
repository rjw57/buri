; BLINKING LED DEMO

; The VIA is exposed as 16 memory-mapped registers. Buri has 8 16-byte IO
; regions from __IO_START__. The VIA is exposed in the 7th page.
.import __IO_START__
VIA1 = __IO_START__ + 6*16
VIA1_ORB 	= VIA1+0		; port B output register
VIA1_DDRB 	= VIA1+2		; port B direction register

; Program entry routine
;
; The STARTUP segment is the very first segment in the object. It is the
; location jumped to. Jump straight to our main routine.
.pushseg
.segment "STARTUP"
	jmp main
.popseg

; Main program function. We're allowed to modify registers, etc within this
; routine. Once done, we use RTS to pop the OS' return address from the
; stack and return control to the OS.
.proc main
	lda #%00000001			; Set port B pin 0 to output
	sta VIA1_DDRB

blinkloop:
	lda #1				; pin 0 -> HIGH
	sta VIA1_ORB
	jsr wait			; wait
	lda #0				; pin 0 -> LOW
	sta VIA1_ORB
	jsr wait			; wait
	bra blinkloop

	; This is never reached since blinkloop is infinite
	rts				; Exit from program
.endproc

; Delay loop. Count to $10000 as fast as possible
.proc wait
	phx
	phy

	ldy #0
yloop:
	ldx #0

xloop:
	inx
	cpx #0
	bne xloop
endxloop:

	iny
	cpy #0
	bne yloop

	ply
	plx
	rts
.endproc

