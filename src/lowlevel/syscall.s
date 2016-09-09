; Single byte query/set routine

; syscall is a general purpose entry point to the OS which may optionally
; transfer a byte as an argument. On entry, A selects which routine is used
; and X contains the argument. On exit, A contains any return value and
; processor flags may have been modified and X is corrupted.
;
; A	Routine
; 0	Query input buffer. Carry is set if input buffer non-empty.
;
; Values of A other than those above will result in an error.

.include "globals.inc"
.include "macros.inc"

.export syscall

.proc syscall
	; TODO: check value of A < 128

	; Set A, X = X, A*2. This allows the syscall routines to be called with
	; A as the input argument.
	asl
	phx
	tax
	pla

	; Jump to syscall routine. Syscall routine's rts instruction will return
	; to caller.
	jmp (jump_table, X)
.endproc

jump_table:
	.import haveinput
	.word haveinput
