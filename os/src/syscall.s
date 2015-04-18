; Single byte query/set routine

; syscall is a general purpose entry point to the OS which may optionally
; transfer a byte as an argument. On entry, X selects which routine is used
; and A contains the argument. On exit, A contains any return value and
; processor flags may have been modified.
;
; X	Routine
; 0	Query input buffer. Carry is set if input buffer non-empty.
;
; Values of X other than those above will result in an error.

.include "globals.inc"
.include "macros.inc"

.export syscall

.proc syscall
	save_xy
	save_word ptr1
	save_word ptr2

	; TODO: check value of X

	; Get the address of the syscall routine by adding X to
	; jump_table twice
	ldw ptr1, jump_table
	pha
	txa
	add_word ptr1
	add_word ptr1
	pla

	; Then copying word at that address into ptr2
	ldy #0
	lda (ptr1), Y
	sta ptr2, Y
	iny
	lda (ptr1), Y
	sta ptr2, Y

	; Jump to syscall routine at ptr2. Use JSR here to allow
	; syscall's rts instruction to come back here.
	jsr syscall_jump

	restore_word ptr2
	restore_word ptr1
	restore_xy
	rts
.endproc

syscall_jump:
	jmp (ptr2)

jump_table:
	.import haveinput
	.word haveinput
