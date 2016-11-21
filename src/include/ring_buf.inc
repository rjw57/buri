; Ring buffer implementation
;
; This file provides macro implementations of a ring buffer. Ring buffers are
; used in interrupt driven applications where a FIFO is required to provie data
; for IRQ handlers to condume or for IRQ handlers to record data for later
; processing.
;
; A ring buffer is a fixed length area of memory with a red and write cursor.
; The read cursor is the offset from which bytes should be read and the write
; cursor is the offset that a new byte should be written to. The read cursor
; "chases" the write cursor. The ring buffer is "lock free" in that the read and
; write cursors are "owned" by either side of the read/write "pipe" and are
; manipulated only by their owners.
;
; When read cursor == write cursor, the buffer is empty. A buffer with read
; cursor == (write cursor + 1) % buffer length is taken as full even though
; there is technically one extra byte available.
;
; To make modular arithmetic easy, the buffer is a power of two. The write
; cursor and read cursor are stored immediately after the buffer in memory.

; Reserve space in BSS for a ring buffer. buf_name is a name used to identify
; the buffer and may be export-ed if the buffer is used elsewhere. buf_len is a
; constant giving the buffer length.
;
; THE BUFFER LENGTH MUST BE A POWER OF TWO
.macro ring_buf_reserve buf_name, buf_len
.pushseg
.bss
buf_name: .res buf_len + 2
.popseg
.endmacro

; Initialise a ring buffer
.macro ring_buf_init buf_name, buf_len
        stz buf_name+buf_len       ; set write cursor
        stz buf_name+buf_len+1     ; set read cursor
.endmacro

; Push byte in A into the ring buffer. Sets carry if the buffer is full, clears
; carry otherwise. Corrupts X and Y.
.macro ring_buf_push buf_name, buf_len
.scope
        pha
        lda buf_name+buf_len            ; would buffer be full after write?
        inc
        and #buf_len-1
        cmp buf_name+buf_len+1
        beq buf_full                    ; yes, abort

        tay                             ; Y <- new write offset
        ldx buf_name+buf_len
        pla
        sta buf_name, X
        tya
        sta buf_name+buf_len
        clc
        bra done
buf_full:
        pla
        sec
done:
.endscope
.endmacro

; Pop a byte from the ring buffer into A. Carry is set if the buffer was empty,
; clear otherwise. Corrupts X.
.macro ring_buf_pop buf_name, buf_len
.scope
        lda buf_name+buf_len
        cmp buf_name+buf_len+1
        bne have_data
        sec
        bra done
have_data:
        ldx buf_name+buf_len+1
        lda buf_name, X
        pha
        txa
        inc
        and #buf_len-1
        sta buf_name+buf_len+1
        pla
        clc
done:
.endscope
.endmacro

; vi:ft=asm_ca65
