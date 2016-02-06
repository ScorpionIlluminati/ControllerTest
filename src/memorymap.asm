;==============================================================
;     Scorpion Illuminati Controller Test
;==============================================================
;   SEGA Genesis (c) Scorpion Illuminati 2015
;==============================================================

; **********************************************
; Various size-ofs to make this easier/foolproof
; **********************************************
SizeByte:               equ 0x01
SizeWord:               equ 0x02
SizeLong:               equ 0x04
SizeSpriteDesc:         equ 0x08
SizeTile:               equ 0x20
SizePalette:            equ 0x40

; ************************************
; System stuff
; ************************************
hblank_counter          equ 0x00FF0000                                         ; Start of RAM
vblank_counter          equ (hblank_counter+SizeLong)
audio_clock             equ (vblank_counter+SizeLong)

; ************************************
; Game globals
; ************************************
controllerinput         equ (audio_clock+SizeWord)