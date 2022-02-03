          // ENABLED SPRITES
          lda spractive
          ora #127 // 01111111
          sta spractive //activamos el sprite 0, 1, 2, 3, 4, 5 y 6

          // COLORS
          // caps
          lda #LIGHT_RED
          sta sprite_cap_start_color
          sta sprite_cap_start1_color
          sta sprite_cap_start2_color
          sta sprite_cap_end_color
          sta sprite_cap_end1_color
          sta sprite_cap_end2_color

          // player
          lda #BLACK
          sta sprite_player_color


          // POINTERS
          // circle caps
          lda #ptr_caps 
          sta sprite_cap_start_pointer
          sta sprite_cap_start1_pointer
          sta sprite_cap_start2_pointer
          sta sprite_cap_end_pointer
          sta sprite_cap_end1_pointer
          sta sprite_cap_end2_pointer

          // player
          lda #ptr_player 
          sta sprite_player_pointer
