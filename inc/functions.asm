setPositionPlayer: // x as angle
{
	lda sprite_x_angle,x
	sta sprite_player_x
	
	lda sprite_y_angle,x
	sta sprite_player_y

	rts
}


setPositionStartCap: // x as angle
{
	lda sprite_x_angle,x
	sta sprite_cap_start_x
	
	lda sprite_y_angle,x
	sta sprite_cap_start_y

	// prev position
	lda sprite_x_prev_angle,x
	sta sprite_cap_start1_x
	
	lda sprite_y_prev_angle,x
	sta sprite_cap_start1_y


	// next position
	lda sprite_x_next_angle,x
	sta sprite_cap_start2_x
	
	lda sprite_y_next_angle,x
	sta sprite_cap_start2_y

	rts
}

setPositionEndCap: // x as angle
{
	lda sprite_x_angle,x
	sta sprite_cap_end_x
	
	lda sprite_y_angle,x
	sta sprite_cap_end_y

	// prev position
	lda sprite_x_prev_angle,x
	sta sprite_cap_end1_x
	
	lda sprite_y_prev_angle,x
	sta sprite_cap_end1_y


	// next position
	lda sprite_x_next_angle,x
	sta sprite_cap_end2_x
	
	lda sprite_y_next_angle,x
	sta sprite_cap_end2_y
	rts
}


/**
 * show subroutine (x as angle)
 */
showCircle: 
{
	// outer
	lda outer_chars_hi,x
	sta setmem_outer+2
	lda outer_chars_lo,x
	sta setmem_outer+1

	// middle
	lda middle_chars_hi,x
	sta setmem_middle+2
	lda middle_chars_lo,x
	sta setmem_middle+1

	// inner
	lda inner_chars_hi,x
	sta setmem_inner+2
	lda inner_chars_lo,x
	sta setmem_inner+1

	lda #LIGHT_RED

setmem_outer:
	sta $FEFE	// dummy $FEFE - selfmodified code :)
setmem_middle:
	sta $FEFE	// dummy $FEFE - selfmodified code :)
setmem_inner:
	sta $FEFE	// dummy $FEFE - selfmodified code :)
	rts	
}

/**
 * hide subroutine (x as angle)
 */
hideCircle: 
{
	// outer
	lda outer_chars_hi,x
	sta setmem_outer+2
	lda outer_chars_lo,x
	sta setmem_outer+1

	// middle
	lda middle_chars_hi,x
	sta setmem_middle+2
	lda middle_chars_lo,x
	sta setmem_middle+1

	// inner
	lda inner_chars_hi,x
	sta setmem_inner+2
	lda inner_chars_lo,x
	sta setmem_inner+1

	lda #LIGHT_GRAY

setmem_outer:
	sta $FEFE	// dummy $FEFE - selfmodified code :)
setmem_middle:
	sta $FEFE	// dummy $FEFE - selfmodified code :)
setmem_inner:
	sta $FEFE	// dummy $FEFE - selfmodified code :)
	rts	
}	


// guarda en la etiqueta 'random' un numero aleatorio 0-255
randomGenerator:
{
          lda            random_ptr      
          beq            doEor     
          asl
          beq            noEor     
          bcc            noEor     
doEor:    eor            #$1d
noEor:    sta            random_ptr

          rts
}





// copyToScreen: copia desde la direccion que especificamos en las direciones 
//             lsbCopyAddress & msbCopyAddress, hasta la direccion de pantalla $0400 
// ejemplo:
//                ldx            #<screen
//                stx            lsbCopyAddress
//                ldx            #>screen
//                stx            msbCopyAddress
//                jsr            copyToScreen

// punteros utilizados por copyScreen
// lsbCopyAddress = $0e
// msbCopyAddress = $0f           
// scrPtr    = $0400

copyToScreen:
{
// posiciones de pantalla 0 - 255 
          ldy            #$00
loop:
          lda            (lsbCopyAddress),y
          sta            scrPtr,y  
          
          iny
          cpy            #$00       
          bne            loop     
          
// posiciones de pantalla 256 - 512
          ldy            #$00
          inc            msbCopyAddress
loop2:
          lda            (lsbCopyAddress),y
          sta            scrPtr + $100,y
          
          iny
          cpy            #$00       
          bne            loop2

// posiciones de pantalla 513 - 768
          ldy            #$00
          inc            msbCopyAddress
loop3:
          lda            (lsbCopyAddress),y
          sta            scrPtr + $200,y
          
          iny
          cpy            #$00       
          bne            loop3

// 768 - 1000
          ldy            #$00
          inc            msbCopyAddress
loop4:
          lda            (lsbCopyAddress),y
          sta            scrPtr + $300,y
          
          iny
          cpy            #232     
          bne            loop4
          
          rts
}     


fill_color_memory:
	lda fillColor:#$ff
	ldy #0
{	
loop:	
	sta colorPtr, y	
	sta colorPtr + $100, y	
	sta colorPtr + $200, y	
	sta colorPtr + $300, y	
	iny
	bne loop
	rts
}


// copyToScreenColor: copia desde la direccion que especificamos en las direciones 
//             lsbCopyAddress & msbCopyAddress, hasta la direccion de color de pantalla
copyToScreenColor:
{
// 0- 255 
          ldy            #$00
loop:
          lda            (lsbCopyAddress),y
          sta            colorPtr,y  
          
          iny
          cpy            #$00       
          bne            loop     
          
// 256 - 512
          ldy            #$00
          inc            msbCopyAddress
loop2:
          lda            (lsbCopyAddress),y
          sta            colorPtr + $100,y
          
          iny
          cpy            #$00       
          bne            loop2

// 513 - 768
          ldy            #$00
          inc            msbCopyAddress
loop3:
          lda            (lsbCopyAddress),y
          sta            colorPtr + $200,y
          
          iny
          cpy            #$00       
          bne            loop3

// 768 - 1000
          ldy            #$00
          inc            msbCopyAddress
loop4:
          lda            (lsbCopyAddress),y
          sta            colorPtr + $300,y
          
          iny
          cpy            #232     
          bne            loop4
          
          rts
}        









