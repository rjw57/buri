.include "macros.inc"
.include "strings.inc"

.importzp ptr1, ptr2, ptr3
.importzp arg1, arg2
.import line_buffer

.import parsehex
.import putc
.import puthex
.import putln
.import putnewline
.import puts

; record command in command table
registercmd "dump", entry

; dump <addr> [<len>]
;
; Dumps to screen <len> bytes from memory starting at <addr>. Both <len> and
; <addr> are hexadecimal. If <len> is omitted use $100 (one page).
;
; on entry:
; 	arg{1,2,3} - offsets into line_buffer of arguments 1, 2 and 3
;
entry:
	pha
	save_xy
	save_word ptr1
	save_word ptr2
	save_word ptr3

	ldw ptr1, line_buffer		; *ptr1 = first argument
	lda arg1
	add_word ptr1

	ldx #1				; record this is arg1 in X
	jsr parsehex			; parse ptr1 -> ptr2
	bcs @bad_arg
	copy_word ptr3, ptr2		; ptr3 <- ptr2

	ldw ptr1, line_buffer		; *ptr1 = second argument
	lda arg2
	add_word ptr1

	ldx #2				; record this is arg2 in X
	jsr parsehex			; parse ptr1 -> ptr2
	bcs @bad_arg

	lda #0				; check arg2 != 0
	cmp ptr2
	bne @args_parsed
	cmp ptr2+1
	bne @args_parsed
	lda #$01			; set ptr2 = $100
	sta ptr2+1
	bra @args_parsed

@bad_arg:
	txa				; char denoting arg
	add #'0'
	jsr putc
	lda #':'
	jsr putc
	ldw ptr1, bad_arg_str
	jsr putln
	bra @exit

@args_parsed:

	; At this point we've verified the arguments, ptr3 holds the address to
	; read from and ptr2 holds the number of bytes to read.

	lda ptr2			; ptr2 += ptr3
	add ptr3			; (note use of carry)
	sta ptr2
	lda ptr2+1
	adc ptr3+1
	sta ptr2+1

	ldx #0				; X = # bytes dumped modulo 16
@dump_loop:
	; Dump until ptr2 == ptr3
	lda ptr2
	cmp ptr3
	bne @ptr2_not_ptr3
	lda ptr2+1
	cmp ptr3+1
	beq @exit_loop
@ptr2_not_ptr3:
	cpx #0				; beginning of line?
	bne @write_byte			; no, just write byte

	; otherwise, write current address
	lda ptr3+1
	jsr puthex
	lda ptr3
	jsr puthex
	lda #' '
	jsr putc
	lda #' '			; write space
	jsr putc

@write_byte:
	lda (ptr3)			; write byte @ ptr3
	jsr puthex
	lda #' '			; write space
	jsr putc

	; Increment ptr3
	lda #1
	add_word ptr3

	; Formatting
	inx
	cpx #8				; written 8th byte?
	bne @chk2
	lda #' '
	jsr putc			; yes, write extra space
	bra @dump_loop
@chk2:
	cpx #16				; written 16th byte?
	bne @dump_loop
	ldx #0				; reset X
	jsr putnewline			; write newline
	bra @dump_loop			; loop

@exit_loop:
@exit:
	restore_word ptr3
	restore_word ptr2
	restore_word ptr1
	restore_xy
	pla
	rts
