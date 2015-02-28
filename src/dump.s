.include "macros.inc"
.include "strings.inc"

.importzp ptr1, ptr2, ptr3
.importzp arg1, arg2
.import line_buffer

.import parsehex
.import putc
.import puthex
.import putln

; record command in command table
registercmd "dump", entry

; dump <addr> <len>
;
; Dumps to screen <len> bytes from memory starting at <addr>. Both <len> and
; <addr> are hexadecimal.
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
	bne @arg2_valid
	cmp ptr2+1
	bne @arg2_valid

@bad_arg:
	txa				; char denoting arg
	add #'0'
	jsr putc
	lda #':'
	jsr putc
	ldax_abs bad_arg_str
	jsr putln
	bra @exit

@arg2_valid:

	; At this point we've verified the arguments, ptr3 holds the address to
	; read from and ptr2 holds the number of bytes to read.

	lda ptr2			; ptr2 += ptr3
	add ptr3			; (note use of carry)
	sta ptr2
	lda ptr2+1
	adc ptr3+1
	sta ptr2+1

@dump_loop:
	; Dump until ptr2 == ptr3

	lda ptr2
	cmp ptr3
	bne @no_exit
	lda ptr2+1
	cmp ptr3+1
	beq @exit_loop
@no_exit:
	lda ptr3+1
	jsr puthex
	lda ptr3
	jsr puthex
	lda #':'
	jsr putc

	lda (ptr3)
	jsr puthex

	lda #' '
	jsr putc

	; Increment ptr3
	lda #1
	add_word ptr3
	bra @dump_loop
@exit_loop:

	lda ptr3+1
	jsr puthex
	lda ptr3
	jsr puthex

	lda #':'
	jsr putc

	lda ptr2+1
	jsr puthex
	lda ptr2
	jsr puthex
	bra @exit
@exit:
	restore_word ptr3
	restore_word ptr2
	restore_word ptr1
	restore_xy
	pla
	rts
