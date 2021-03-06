;
; IRQ handling (ATARI version)
;

        .export         initirq, doneirq
        .import         callirq

        .include        "atari.inc"

; ------------------------------------------------------------------------

.segment        "INIT"

initirq:
        lda     VVBLKI
        ldx     VVBLKI+1
        sta     IRQInd+1
        stx     IRQInd+2
        lda     #6
        ldy     #<IRQStub
        ldx     #>IRQStub
        jsr     SETVBV
        rts

; ------------------------------------------------------------------------

.code

doneirq:
        lda     #6
        ldy     IRQInd+1
        ldx     IRQInd+2
        jsr     SETVBV
        rts

; ------------------------------------------------------------------------

.segment        "LOWCODE"

IRQStub:
        cld                             ; Just to be sure
        jsr     callirq                 ; Call the functions
        jmp     IRQInd                  ; Jump to the saved IRQ vector

; ------------------------------------------------------------------------

.data

IRQInd: jmp     $0000
