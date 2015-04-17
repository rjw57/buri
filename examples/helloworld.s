.import v_putc

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
	ldx #0				; X will be our string index
loop:
	lda hello_world, X		; Get character at index X
	cmp #0				; Is it zero?
	beq exit			; Yes, exit program
	jsr putc			; Otherwise, output character
	inx				; Increment char. index
	bra loop			; Loop to next character
exit:
	rts				; Exit from program
.endproc

putc:
	jmp (v_putc)
	rts

; The DATA segment holds the program's initialised data. In this case, it is a
; C-style string.
.segment "DATA"
hello_world:
	.byte "Hello, World!", $0A, $0D, $00

