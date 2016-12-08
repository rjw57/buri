; Useful macros

; ===========================================================================
; 8-bit/16-bit mode

; Set accumulator to 8-bit mode
.macro m8
        sep     #$20
        .a8
.endmacro

; Set accumulator to 16-bit mode
.macro m16
        rep     #$20
        .a16
.endmacro

; Set index to 8-bit mode
.macro x8
        sep     #$10
        .i8
.endmacro

; Set index to 16-bit mode
.macro x16
        rep     #$10
        .i16
.endmacro

; Set accumulator & index to 8-bit mode
.macro mx8
        sep     #$30
        .a8
        .i8
.endmacro

; Set accumulator & index to 16-bit mode
.macro mx16
        rep     #$30
        .a16
        .i16
.endmacro

; ===========================================================================
; Emulation mode

; Enable emulation mode
.macro set_emulation
        sec
        xce
.endmacro

; Enable native moe
.macro set_native
        clc
        xce
.endmacro

; ===========================================================================
; Pseudo instructions

; add without carry
.macro add arg
        clc
        adc arg
.endmacro

; subtract without carry
.macro sub arg
        sec
        sbc arg
.endmacro

; branch if less than (another name for bcc)
.macro blt arg
        bcc arg
.endmacro

; branch if greater than or equal (another name for bcs)
.macro bge arg
        bcs arg
.endmacro

; branch if greater than
.macro bgt arg
        .local L
        beq L
        bcs arg
L:
.endmacro

; branch if less than or equal
.macro ble arg
        beq arg
        bcc arg
.endmacro

; branch if not zero (another name for bne)
.macro bnz arg
        bne arg
.endmacro

; branch if zero (another name for beq)
.macro bze arg
        beq arg
.endmacro

; ===========================================================================
; Interrupt routines

; Patch irq_handler into IRQ chain stashing next handler in next_handler.
.macro irq_add_handler this_handler, next_handler
.import irq_first_handler
        sei                             ; disable interrupts
        m16                             ; insert our interrupt handler
        lda irq_first_handler
        sta next_handler
        lda #this_handler
        sta irq_first_handler
        m8
        cli                             ; enable interrupts
.endmacro

; ===========================================================================
; Idle handlers

; Patch idle_handler into idle chain stashing next handler in next_handler.
.macro idle_add_handler this_handler, next_handler
.import idle_first_handler
        m16                             ; insert our handler
        lda idle_first_handler
        sta next_handler
        lda #this_handler
        sta idle_first_handler
        m8
.endmacro

; vi:ft=asm_ca65
