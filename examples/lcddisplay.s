; LCD display test program.
;
; Overwrite the putc vector with our own vector which writes characters to an
; attached LCD display. The dislpay should be a memory-mapped HD44780-style LCD
; display. LCD_R0 should be modified to point to the address of R0 in the memory
; map.

; v_putc is the vector table address of the putc routine
.import v_putc

; Registers 0 and 1 of the LCD display
LCD_R0 = $DFE0
LCD_R1 = LCD_R0 + 1

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
	lda #$01			; clear display
	jsr send_cmd
	lda #$02			; return home
	jsr send_cmd
	lda #$06			; entry mode
	jsr send_cmd
	lda #$0D			; display/cursor
	jsr send_cmd
	lda #$38			; bus width/interface
	jsr send_cmd

	;; replace system putc
	lda #<my_putc
	sta v_putc
	lda #>my_putc
	sta v_putc+1

	rts				; Exit from program
.endproc

my_putc:
	jsr wait_display
	sta LCD_R1
	rts

send_cmd:
	jsr wait_display
	sta LCD_R0
	rts

.proc wait_display
	pha
@loop:
	lda LCD_R0			; busy flag is bit 7 => N
	bmi @loop			; loop if flag set
	pla
	rts
.endproc
