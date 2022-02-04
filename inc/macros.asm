.macro waitRetrace() {
loop:    
    ldy $d012
    bne loop
}

.macro setColor(color) {
    lda #color   
    sta $d020
}