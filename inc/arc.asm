draw_arc:
    jsr randomGenerator
	ldx random_ptr 
	stx start_angle

	jsr randomGenerator
	lda random_ptr
	and #63 // 00011111 (0 - 63)
	adc #$01 // 1 - 64 (0 gives an error)
	adc start_angle
	sta end_angle

draw_arc_with_start_and_end_angle:
	ldx start_angle:#$ff // dummy value
	
	// enable caps sprites
	lda spractive
	ora #126 // 01111110
	sta spractive

	jsr setPositionStartCap

draw_arc_loop:
	jsr showCircle
	inx
	cpx end_angle:#$ff // dummy value
	bne draw_arc_loop
	
	jsr setPositionEndCap
	
	rts

/*
clear_circle:
{
	ldx start_angle

	// disable caps sprites
	lda spractive
	and #129 // 10000001
	sta spractive

clear_loop:
	jsr hideCircle
	inx
	cpx end_angle:#$ff // dummy value
	bne clear_loop	
	rts
}
*/

clear_circle:
{
	ldx #00

	// disable caps sprites
	lda spractive
	and #129 // 10000001
	sta spractive

clear_loop:
	jsr hideCircle
	inx
	bne clear_loop	
	rts
}
