.include "macros.inc"

; Dump memory contents
.import _putc, _putln

; =========================================================================
; dump: dump memory contents to console
; =========================================================================
.export dump
.proc dump
        lda #<msg
        ldx #>msg
        jsr _putln
        rts
msg:
        .byte "TODO", $00
.endproc
.export _dump := dump
