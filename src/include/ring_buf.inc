; A ring buffer for received bytes. The buffer is length 8 (power of twos make
; for easy modular arithmetic) and has a read and write cursor. The cursors
; indicate the offset into the buffer the next read or write would come from/go
; to. When the cursors are equal the buffer is empty and when (buf_name+8+1) %
; 8 == buf_name+9, the buffer is full.
.macro ring_buf_reserve buf_name
.pushseg
.bss
buf_name: .res 10
.popseg
.endmacro

.macro ring_buf_init buf_name
        stz buf_name+8
        stz buf_name+9
.endmacro

; Push byte in A into the ring buffer. Sets carry if the buffer is full, clears
; carry otherwise. Corrupts X and Y.
.macro ring_buf_push buf_name
.scope
        pha
        lda buf_name+8                  ; would buffer be full after write?
        inc
        and #$07
        cmp buf_name+9
        beq buf_full                    ; yes, abort

        tay                             ; Y <- new write offset
        ldx buf_name+8
        pla
        sta buf_name, X
        tya
        sta buf_name+8
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
.macro ring_buf_pop buf_name
.scope
        lda buf_name+8
        cmp buf_name+9
        bne have_data
        sec
        bra done
have_data:
        ldx buf_name+9
        lda buf_name, X
        pha
        txa
        inc
        and #$07
        sta buf_name+9
        pla
        clc
done:
.endscope
.endmacro

; vi:ft=asm_ca65
