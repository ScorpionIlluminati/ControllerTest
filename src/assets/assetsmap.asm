;==============================================================
;   Scorpion Illuminati Controller Test
;==============================================================
;   SEGA Genesis (c) Scorpion Illuminati 2015
;==============================================================

; ************************************
; Art asset VRAM mapping
; ************************************
PixelFontVRAM:     equ 0x0000
GameTilesVRAM:     equ PixelFontVRAM+PixelFontSizeB

; ************************************
; Include all art assets
; ************************************
      include assets\fonts\pixelfont.asm
      include assets\tiles\gametiles.asm
      include assets\maps\gamemap.asm

; ************************************
; Include all palettes
; ************************************
      include assets\palettes\palettes.asm

; ************************************
; Include all text strings
; ************************************
      include assets\strings\strings.asm