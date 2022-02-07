// direcciones memoria
.const spractive = $d015
.const random_ptr = $10 // numero 'aleatorio' generado
.const inmunity = $fa   
.const inmunity_lenght = 25 // 0.25 seconds
.const screen_control1 = $d011

// CAPS
.const ptr_caps = $22 
.const ptr_player = $23 


// PLAYER
.const sprite_player_color  = $d027
.const sprite_player_pointer  = $07f8
.const sprite_player_x = $d000
.const sprite_player_y = $d001


.const joy_player = $dc01 // port 1

// CAP START
.const sprite_cap_start_color  = $d028
.const sprite_cap_start_pointer  = $07f9 
.const sprite_cap_start_x = $d002
.const sprite_cap_start_y = $d003


// CAP START PREV
.const sprite_cap_start1_color  = $d029
.const sprite_cap_start1_pointer  = $07fa
.const sprite_cap_start1_x = $d004
.const sprite_cap_start1_y = $d005


// CAP START NEXT
.const sprite_cap_start2_color  = $d02a
.const sprite_cap_start2_pointer  = $07fb 
.const sprite_cap_start2_x = $d006
.const sprite_cap_start2_y = $d007


// CAP END
.const sprite_cap_end_color  = $d02b
.const sprite_cap_end_pointer  = $07fc 
.const sprite_cap_end_x = $d008
.const sprite_cap_end_y = $d009


// CAP END PREV
.const sprite_cap_end1_color  = $d02c
.const sprite_cap_end1_pointer  = $07fd
.const sprite_cap_end1_x = $d00a
.const sprite_cap_end1_y = $d00b


// CAP END NEXT
.const sprite_cap_end2_color  = $d02d
.const sprite_cap_end2_pointer  = $07fe 
.const sprite_cap_end2_x = $d00c
.const sprite_cap_end2_y = $d00d


// GENERAL
.const lsbCopyAddress = $0e
.const msbCopyAddress = $0f           
.const scrPtr    = $0400
.const colorPtr  = $d800


.const score = $c000
.const score_c = scrPtr + $01ef - 40 // $05ef
.const score_d = scrPtr + $01f0 - 40 // $05f0
.const score_u = scrPtr + $01f1 - 40 // $05f1

.const hiscore = $c001	
.const hiscore_c = scrPtr + 42 + $01ef // $053d
.const hiscore_d = scrPtr + 42 + $01f0 // $053e
.const hiscore_u = scrPtr + 42 + $01f1 // $053f

.const space_text_base = colorPtr + $0251
.const space_text_status = 1 // 0 = hide, 1 = blinking


	
