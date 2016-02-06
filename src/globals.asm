;==============================================================
;   Scorpion Illuminati Controller Test
;==============================================================
;   SEGA Genesis (c) Scorpion Illuminati 2015
;==============================================================

; Sprite plane border
sprite_plane_border  equ 0x0080

; Screen bounds
screen_width         equ 0x0140                                                ; 320 (H40)
screen_height        equ 0x00E0                                                ; 224 (V28)
screen_border_x      equ 0x0010
screen_border_y      equ 0x0010

; object offbounds positions
offscreen_position_x:  equ 0x0090
offscreen_position_y:  equ 0x0090