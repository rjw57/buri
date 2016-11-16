; Shared global state for console

; =========================================================================
; Zero page global variables
; =========================================================================
.segment "OSZP": zeropage

; Current row and column position of console cursor. The cursor is the location
; on screen where the next character will be printed.
.exportzp console_cursor_col, console_cursor_row
console_cursor_col: .res 1
console_cursor_row: .res 1

.bss

; Cached address of cursor in VRAM. Cursor manipulation routines update this
; address along with row and column
.export console_cursor_vram_addr
console_cursor_vram_addr: .res 2

; Saved byte under cursor
.export console_cursor_save
console_cursor_save: .res 1

; Cursor character. $00 == cursor off
.export console_cursor_char
console_cursor_char: .res 1
