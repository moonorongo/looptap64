updateScore:
{
    // backup registers
    pha
    txa
    pha
    tya
    pha

    lda score   // get score

    ldy #$2f      
    ldx #$3a      
    sec

l100:     
    iny
    sbc  #100      
    bcs  l100     
          
l10:      
    dex
    adc #10       
    bmi l10      

    adc #$2f      

    sta score_u
    stx score_d
    sty score_c

    // restore registers
    pla
    tay
    pla
    tax
    pla

    rts
}       


updateHiscore:
{
    // backup registers
    pha
    txa
    pha
    tya
    pha

    ldx #8 // h
    stx hiscore_c - 4
    ldx #9 // i
    stx hiscore_c - 3
    ldx #58 // :
    stx hiscore_c - 2

    lda hiscore // get score

    ldy #$2f      
    ldx #$3a      
    sec

l100:     
    iny
    sbc  #100      
    bcs  l100     
          
l10:      
    dex
    adc #10       
    bmi l10      

    adc #$2f      

    sta hiscore_u
    stx hiscore_d
    sty hiscore_c

    // restore registers
    pla
    tay
    pla
    tax
    pla

    rts
}



set_space_mesage_color:
    ldx #0
    lda space_text_color:#$ff // dummy value
loop1: 
    sta space_text_base, x
    sta space_text_base + 40, x
    inx
    cpx #7
    bne loop1
    rts



ramp_cycle_color:
{
    // save Y value..
    tya
    pha 

    lda #48
loop:    
    waitRetrace() // ...because this macro use Y register...
    sbc #1
    bne loop

    // restore Y value
    pla
    tay

    lda spacebar_color_ramp,y
    sta space_text_color
    jsr set_space_mesage_color
    iny
    cpy #5
    bne exit
    
    ldy #0 // reset index cycle color
exit:
    rts
}