.var music = LoadSid("assets/music.sid")
BasicUpstart2(init)

/*
	MEJORAR LIMPIEZA/REDIBUJADO DE CIRCULO
	  armar una tabla de posiciones seguras
	  y que la rutina random elija esas posiciones
	  y a la mierda

	y ya con esto estaria
*/

#import "inc/const.asm"
#import "inc/macros.asm"
#import "inc/sprites.asm"	

*=$1000 "Main"
init: 
#import "inc/sprites_cap.asm"
	cld // clear decimal flag

	// Music Initialization
    lda #$00
    ldx #0
    ldy #0
    lda #music.startSong-1
    jsr music.init

    sei
    lda #<irqMusic
    sta $0314
    lda #>irqMusic
    sta $0315
    asl $d019
    lda #$7b
    sta $dc0d
    lda #$81
    sta $d01a
    lda #$1b
    sta $d011
    lda #$80
    sta $d012
    cli

	// disable screen
	lda screen_control1
	and #$ef // set bit #4 to 0
	sta screen_control1

	// fill color 
	ldx #GRAY 
	stx fillColor
	jsr fill_color_memory

	// colors
	ldx #LIGHT_GRAY
	stx $d020
	stx $d021

	// reset score
	ldx #$00
	stx hiscore

	jsr updateHiscore

	// chars
	lda $d018
	ora #$0e       // set chars location to $3800 for displaying the custom font
	sta $d018      // Bits 1-3 ($400+512bytes * low nibble value) of $d018 sets char location
                   // $400 + $200*$0E = $3800
	lda $d016      // turn off multicolor for characters
	and #$ef       // by cleaing Bit#4 of $D016
	sta $d016

	// draw first arc
	jsr clear_circle 
	ldx #192
	stx start_angle
	ldx #255
	stx end_angle
	jsr draw_arc_with_start_and_end_angle

	// set player initial position 
	ldx #128
	jsr setPositionPlayer


	ldx #<screen
	stx lsbCopyAddress
	ldx #>screen
	stx msbCopyAddress
	jsr copyToScreen

	ldx #<screen + 1000
	stx lsbCopyAddress
	ldx #>screen + 1000
	stx msbCopyAddress
	jsr copyToScreenColor

    // show "space to start" message
	//lda #1
	//sta space_text_color
	//jsr set_space_mesage_color

	// enable screen
	lda screen_control1
	ora #$10 // set bit #4 to 1
	sta screen_control1

menu: 
	// reset inmunity counter
	ldx #$ff


loop_wait:
	waitRetrace()
	dex
	bne loop_wait

	ldy #0 // reset ramp index color 
loop_menu:
	jsr ramp_cycle_color // space to start color cycle

    lda joy_player      
	and #16 
	bne loop_menu

start:
	ldx #$00 // reset score and angle
	stx score 
	jsr updateScore

	// hide "space to start" message
	lda #15
	sta space_text_color
	jsr set_space_mesage_color

new_arc:
	// store x value
	txa
	pha

	jsr clear_circle
	jsr draw_arc
	
	// restore x value
	pla 
	tax

	// reset inmunity counter
	ldy #inmunity_lenght
	sty inmunity

main_loop:
	waitRetrace()

	// check inmunity for decrement
	ldy inmunity
	beq skip_dec_inmunity
	dec inmunity

skip_dec_inmunity:
	// check fire button Joy 1
    lda joy_player      
	and #16 // fire
	bne next

	// check x < end_angle
	txa
	sbc #$05
	cmp end_angle
	bmi check_x_gt_start_angle

	// check inmunity
	ldy inmunity
	bne skip_by_inmunity

	jmp lost_game // lost game!
	
skip_by_inmunity:
	jmp next 

check_x_gt_start_angle:
	txa
	adc #$04
	cmp start_angle
	bpl hit_inside_arc // ok, hit inside arc, add 1 point

	// check inmunity
	ldy inmunity
	bne skip_by_inmunity

	jmp lost_game // lost game !

hit_inside_arc: 
	// previene varios hits de un solo golpe
	ldy inmunity
	bne skip_by_inmunity

	inc score
	jsr updateScore

	jmp new_arc 

next:
	jsr setPositionPlayer
	inx

	jmp main_loop
	
lost_game:
	ldx score 
	cpx hiscore
	bpl newHiscore

	jmp menu

newHiscore:
	stx hiscore
	jsr updateHiscore

	jmp menu

irqMusic:
        asl $d019
        jsr music.play 
        pla
        tay
        pla
        tax
        pla
        rti

// arcs
#import "inc/arc.asm"

//functions
#import "inc/functions.asm"	

// scores + labels
#import "inc/print_on_screen.asm"	

// lookup tables
#import "inc/tables.asm"

screen:
.import binary "assets/screen2.bin"



*=$3800 "Charset"
.import binary "assets/charset.bin"

*=music.location "Music"
.fill music.size, music.getData(i)

/*
.print ""
.print "SID Data"
.print "--------"
.print "location=$"+toHexString(music.location)
.print "init=$"+toHexString(music.init)
.print "play=$"+toHexString(music.play)
.print "songs="+music.songs
.print "startSong="+music.startSong
.print "size=$"+toHexString(music.size)
.print "name="+music.name
.print "author="+music.author
.print "copyright="+music.copyright

.print ""
.print "Additional tech data"
.print "--------------------"
.print "header="+music.header
.print "header version="+music.version
.print "flags="+toBinaryString(music.flags)
.print "speed="+toBinaryString(music.speed)
.print "startpage="+music.startpage
.print "pagelength="+music.pagelength

*/