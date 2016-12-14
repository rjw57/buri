; Ring buffer implementation
;
; This file provides macro implementations of a ring buffer. Ring buffers are
; used in interrupt driven applications where a FIFO is required to provide data
; for IRQ handlers to consume or for IRQ handlers to record data for later
; processing.
;
; A ring buffer is a fixed length area of memory with a red and write cursor.
; The read cursor and write cursors, modulo the buffer length are the offsets
; into the buffer when bytes should be read from and written to. The read cursor
; always "chases" the write cursor until the become equal. Letting the read
; cursor and write cursor be interpreted modulo the buffer length simplifies
; advancing the cursors; they may simply be incremented via the INC instruction.
;
; When read cursor == write cursor, the buffer is empty. If the cursor values
; are not equal but their value *modulo the ring buffer length* are equal then
; the buffer is full. This can be tested with subtraction. If the difference
; between the cursors is zero, the buffer is empty. If the difference *modulo
; ring buffer length* is zero, the buffer is full.
;
; To make modular arithmetic easy, the buffer is a power of two. The write
; cursor and read cursor are stored immediately after the buffer in memory.
;
; The ring buffer can be considered "lock free" in that reading and writing can
; take place asynchronously. For example, the reader can be in an IRQ handler
; and the write can be in normal code. This is because the reader only modifiers
; the read cursor, the writer only modifies the write cursor and increment
; operations are atomic. It is this increment operation which indicates that a
; read or write has taken place so the writer must make sure it has written the
; byte to the buffer before incrementing and the reader must read the byte
; before incrementing.

; Reserve space in BSS for a ring buffer. buf_name is a name used to identify
; the buffer and may be export-ed if the buffer is used elsewhere. buf_len is a
; constant giving the buffer length.
;
; THE BUFFER LENGTH MUST BE A POWER OF TWO
.macro ring_buf_reserve buf_name, buf_len
.pushseg
.bss
buf_name: .res buf_len+2
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
        .local do_write
        .local buf_full
        .local done

        pha                             ; save byte to write
        lda buf_name+buf_len            ; A <- write cursor
        sub buf_name+buf_len+1          ; compare to read cursor
        beq do_write                    ; if equal, buffer is empty
        and #buf_len-1                  ; modulo buffer len
        beq buf_full                    ; if we now get zero, the cursors were
                                        ; equal modulo buffer len and the buffer
                                        ; is full
do_write:
        lda buf_name+buf_len            ; restore A = write cursor
        and #buf_len-1                  ; A = A % buffer length
        tax                             ; X <- write cursor
        pla                             ; restore byte to write
        sta buf_name, X                 ; write byte
        inc buf_name+buf_len            ; increment write cursor
        clc
        bra done
buf_full:
        pla
        sec
done:
.endmacro

; Pop a byte from the ring buffer into A. Carry is set if the buffer was empty,
; clear otherwise. Corrupts X.
.macro ring_buf_pop buf_name, buf_len
        .local have_data
        .local done

        lda buf_name+buf_len+1          ; there is data to read if the cursors
        cmp buf_name+buf_len            ; are not equal
        bne have_data
        sec
        bra done
have_data:
        and #buf_len-1                  ; A is read cursor modulo buffer length
        tax                             ; cursor -> X
        lda buf_name, X                 ; read byte
        inc buf_name+buf_len+1          ; increment read cursor
        clc
done:
.endmacro

; vi:ft=asm_ca65
