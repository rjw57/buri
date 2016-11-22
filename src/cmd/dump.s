.include "macros.inc"

.importzp tmp1, ptr1, sreg
.import _cli_buf, _cli_arg_offsets, _cli_arg_count
.import _put_hex_8, _putc
.import parse_hex_32

.bss

dump_address: .res 2
dump_remaining: .res 2
dump_output_count: .res 1
dump_bank: .res 1
dump_buffer: .res 16

.code

.export dump
.proc dump
        ldx #0
        lda _cli_arg_offsets, X
        m16                             ; A, X <- address of first arg
        and #$FF
        add #_cli_buf
        m8
        xba
        tax
        xba
        jsr parse_hex_32                ; parse argument
        bcc @parse_ok
        rts
@parse_ok:

        sta dump_address                ; set up address and bank
        stx dump_address+1
        lda sreg
        sta dump_bank

parse_length:
        ldx #1
        lda _cli_arg_offsets, X
        m16                             ; A, X <- address of first arg
        and #$FF
        add #_cli_buf
        m8
        xba
        tax
        xba
        jsr parse_hex_32                ; parse argument
        bcc @parse_ok
        rts
@parse_ok:

        sta dump_remaining              ; store remaining
        stx dump_remaining+1

loop:
        m16                             ; check remaining count
        lda dump_remaining
        bnz carry_on
        m8
        bra exit
carry_on:
        m8
        lda dump_output_count           ; get output count mod 16
        and #$0F
        bnz no_addr_out

        jsr write_address

no_addr_out:
        x16                             ; load byte from bank and address
        ldx dump_address
        lda dump_bank
        phb
        pha
        plb
        lda a:0, X                      ; the address size operator is
        plb                             ; req. here to make sure direct
        x8                              ; page is not used

        tax
        lda dump_output_count           ; get output count mod 16
        and #$0F
        tay
        txa
        sta dump_buffer, Y

        lda dump_output_count
        and #$0F
        cmp #$0F
        bne no_output

        lda #' '
        jsr _putc

        ldx #0
write_loop:
        lda dump_buffer, X
        phx
        jsr _put_hex_8
        plx

        cpx #$07
        bne no_space
        lda #' '
        phx
        jsr _putc
        plx
no_space:

        inx
        cpx #$10
        bne write_loop

        lda #$0A
        jsr _putc
        lda #$0D
        jsr _putc

no_output:
        inc dump_output_count           ; next iteration
        m16
        dec dump_remaining
        inc dump_address
        m8
        bnz no_inc_bank
        inc dump_bank
no_inc_bank:
        bra loop

exit:
        rts

; sub-subroutines
write_address:
        lda dump_bank
        jsr _put_hex_8
        lda dump_address+1
        jsr _put_hex_8
        lda dump_address
        jsr _put_hex_8
        rts

.endproc
.export _dump := dump
