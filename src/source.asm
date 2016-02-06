;==============================================================
;   Scorpion Illuminati Controller Test
;==============================================================
;   SEGA Genesis (c) Scorpion Illuminati 2015
;==============================================================

      ; Include SEGA Genesis ROM header and CPU vector table
      include 'header.asm'

      ; include framework code
      include 'framework\init.asm'
;     include 'framework\collision.asm'
      include 'framework\debugger.asm'                                         ; NOT FOR RELEASE
      include 'framework\gamepad.asm'
      include 'framework\interrupts.asm'
      include 'framework\megacd.asm'
      include 'framework\memory.asm'
      include 'framework\psg.asm'
      include 'framework\sprites.asm'
      include 'framework\text.asm'
      include 'framework\timing.asm'
      include 'framework\tmss.asm'
      include 'framework\palettes.asm'
      include 'framework\planes.asm'
      include 'framework\utility.asm'
      include 'framework\vdp.asm'
      include 'framework\z80.asm'

__main:

      ; ************************************
      ; Load palettes
      ; ************************************
      lea Palette, a0
      move.l #0x0, d0
      jsr LoadPalette

      ; ************************************
      ; Load map tiles
      ; ************************************
      lea GameTiles, a0                                                        ; Move sprite address to a0
      move.l #GameTilesVRAM, d0                                                ; Move VRAM dest address to d0
      move.l #GameTilesSizeT, d1                                               ; Move number of tiles to d1
      jsr LoadTiles                                                            ; Jump to subroutine

      ; ************************************
      ; Load map
      ; ************************************
      lea GameMap, a0                                                          ; Map data in a0
      move.w #GameMapSizeW, d0                                                 ; Size (words) in d0
      move.l #0x0, d1                                                          ; Y offset in d1
      move.w #GameTilesTileID, d2                                              ; First tile ID in d2
      move.l #0x0, d3                                                          ; Palette ID in d3
      jsr LoadMapPlaneA                                                        ; Jump to subroutine

      ; ************************************
      ;  Load the Pixel Font
      ; ************************************
      lea PixelFont, a0                                                        ; Move font address to a0
      move.l #PixelFontVRAM, d0                                                ; Move VRAM dest address to d0
      move.l #PixelFontSizeT, d1                                               ; Move number of characters (font size in tiles) to d1
      jsr LoadFont                                                             ; Jump to subroutine

      ; ************************************
      ; initalize everything
      ; ************************************

      ; ******************************************************************
      ; Main game loop
      ; ******************************************************************
GameLoop:

      jsr ReadPadA                                                             ; Read pad 1 state, result in d0

      move.l #0x0, d2                                                          ; Palette 0
      move.w d0, (controllerinput)                                             ; save controller input into memory for later

      btst #pad_button_up, d0                                                  ; Check up button
      bne @Pad1NoUp                                                            ; Branch if button off
      lea PressedString, a0                                                    ; String address
      move.l #PixelFontTileID, d0                                              ; First tile id
      move.w #0x0404, d1                                                       ; XY (4, 4)
      bra @Pad1UpDone                                                          ; branch when finished
@Pad1NoUp:
      lea NotPressedString, a0                                                 ; String address
      move.l #PixelFontTileID, d0                                              ; First tile id
      move.w #0x0404, d1                                                       ; XY (4, 4)
@Pad1UpDone:
      jsr DrawTextPlaneA                                                       ; Call draw text subroutine

      move.w (controllerinput), d0                                             ; restore controller input from memory

      btst #pad_button_down, d0                                                ; Check down button
      bne @Pad1NoDown                                                          ; Branch if button off
      lea PressedString, a0                                                    ; String address
      move.l #PixelFontTileID, d0                                              ; First tile id
      move.w #0x040A, d1                                                       ; XY (4, 10)
      bra @Pad1DownDone                                                        ; branch when finished
@Pad1NoDown:
      lea NotPressedString, a0                                                 ; String address
      move.l #PixelFontTileID, d0                                              ; First tile id
      move.w #0x040A, d1                                                       ; XY (4, 10)
@Pad1DownDone:
      jsr DrawTextPlaneA                                                       ; Call draw text subroutine

      move.w (controllerinput), d0                                             ; restore controller input from memory

      btst #pad_button_left, d0                                                ; Check left button
      bne @Pad1NoLeft                                                          ; Branch if button off
      lea PressedString, a0                                                    ; String address
      move.l #PixelFontTileID, d0                                              ; First tile id
      move.w #0x0107, d1                                                       ; XY (1, 7)
      bra @Pad1LeftDone                                                         ; branch when finished
@Pad1NoLeft:
      lea NotPressedString, a0                                                 ; String address
      move.l #PixelFontTileID, d0                                              ; First tile id
      move.w #0x0107, d1                                                       ; XY (1, 7)
@Pad1LeftDone:
      jsr DrawTextPlaneA                                                       ; Call draw text subroutine

      move.w (controllerinput), d0                                             ; restore controller input from memory

      btst #pad_button_right, d0                                               ; Check right button
      bne @Pad1NoRight                                                         ; Branch if button off
      lea PressedString, a0                                                    ; String address
      move.l #PixelFontTileID, d0                                              ; First tile id
      move.w #0x0707, d1                                                       ; XY (7, 7)
      bra @Pad1RightDone                                                       ; branch when finished
@Pad1NoRight:
      lea NotPressedString, a0                                                 ; String address
      move.l #PixelFontTileID, d0                                              ; First tile id
      move.w #0x0707, d1                                                       ; XY (7, 7)
@Pad1RightDone:
      jsr DrawTextPlaneA                                                       ; Call draw text subroutine

      move.w (controllerinput), d0                                             ; restore controller input from memory

      btst #pad_button_a, d0                                                   ; Check A button
      bne @Pad1NoButtonA                                                       ; Branch if button off
      lea PressedString, a0                                                    ; String address
      move.l #PixelFontTileID, d0                                              ; First tile id
      move.w #0x0C08, d1                                                       ; XY (13, 8)
      bra @Pad1ButtonADone                                                     ; branch when finished
@Pad1NoButtonA:
      lea NotPressedString, a0                                                 ; String address
      move.l #PixelFontTileID, d0                                              ; First tile id
      move.w #0x0C08, d1                                                       ; XY (13, 8)
@Pad1ButtonADone:
      jsr DrawTextPlaneA                                                       ; Call draw text subroutine

      move.w (controllerinput), d0                                             ; restore controller input from memory

      btst #pad_button_b, d0                                                   ; Check B button
      bne @Pad1NoButtonB                                                                 ; Branch if button off
      lea PressedString, a0                                                    ; String address
      move.l #PixelFontTileID, d0                                              ; First tile id
      move.w #0x1008, d1                                                       ; XY (16, 8)
      bra @Pad1ButtonBDone                                                     ; branch when finished
@Pad1NoButtonB:
      lea NotPressedString, a0                                                 ; String address
      move.l #PixelFontTileID, d0                                              ; First tile id
      move.w #0x1008, d1                                                       ; XY (16, 8)
@Pad1ButtonBDone:
      jsr DrawTextPlaneA                                                       ; Call draw text subroutine

      move.w (controllerinput), d0                                             ; restore controller input from memory

      btst #pad_button_c, d0                                                   ; Check C button
      bne @Pad1NoButtonC                                                       ; Branch if button off
      lea PressedString, a0                                                    ; String address
      move.l #PixelFontTileID, d0                                              ; First tile id
      move.w #0x1408, d1                                                       ; XY (20, 8)
      bra @Pad1ButtonCDone                                                     ; branch when finished
@Pad1NoButtonC:
      lea NotPressedString, a0                                                 ; String address
      move.l #PixelFontTileID, d0                                              ; First tile id
      move.w #0x1408, d1                                                       ; XY (20, 8)
@Pad1ButtonCDone:
      jsr DrawTextPlaneA                                                       ; Call draw text subroutine
; ***********************
; Test Code
; ***********************
     move.w (controllerinput), d0                                             ; restore controller input from memory

      btst #pad_button_x, d0                                                   ; Check C button
      bne @Pad1NoButtonX                                                       ; Branch if button off
      lea PressedString, a0                                                    ; String address
      move.l #PixelFontTileID, d0                                              ; First tile id
      move.w #0x0C04, d1                                                       ; XY (20, 8)
      bra @Pad1ButtonXDone                                                     ; branch when finished
@Pad1NoButtonX:
      lea NotPressedString, a0                                                 ; String address
      move.l #PixelFontTileID, d0                                              ; First tile id
      move.w #0x0C04, d1                                                       ; XY (20, 4)
@Pad1ButtonXDone:
      jsr DrawTextPlaneA
; ***********************
; End Test Code
; ***********************
      move.w (controllerinput), d0                                             ; restore controller input from memory

      btst #pad_button_start, d0                                               ; Check C button
      bne @Pad1NoButtonStart                                                   ; Branch if button off
      lea PressedString, a0                                                    ; String address
      move.l #PixelFontTileID, d0                                              ; First tile id
      move.w #0x080C, d1                                                       ; XY (20, 13)
      bra @Pad1ButtonStartDone                                                 ; branch when finished
@Pad1NoButtonStart:
      lea NotPressedString, a0                                                 ; String address
      move.l #PixelFontTileID, d0                                              ; First tile id
      move.w #0x080C, d1                                                       ; XY (20, 13)
@Pad1ButtonStartDone:
      jsr DrawTextPlaneA                                                       ; Call draw text subroutine
; **********************
; Controller 2 Test
; **********************
      jsr ReadPadB                                                             ; Read pad 2 state, result in d0

      move.w d0, (controllerinput)                                             ; save controller input into memory for later

      btst #pad_button_up, d0                                                  ; Check up button
      bne @Pad2NoUp                                                            ; Branch if button off
      lea PressedString, a0                                                    ; String address
      move.l #PixelFontTileID, d0                                              ; First tile id
      move.w #0x040F, d1                                                       ; XY (4, 15)
      bra @Pad2UpDone                                                           ; branch when finished
@Pad2NoUp:
      lea NotPressedString, a0                                                 ; String address
      move.l #PixelFontTileID, d0                                              ; First tile id
      move.w #0x040F, d1                                                      ; XY (4, 15)
@Pad2UpDone:
      jsr DrawTextPlaneA                                                       ; Call draw text subroutine

      move.w (controllerinput), d0                                             ; restore controller input from memory

      btst #pad_button_down, d0                                                ; Check down button
      bne @Pad2NoDown                                                          ; Branch if button off
      lea PressedString, a0                                                    ; String address
      move.l #PixelFontTileID, d0                                              ; First tile id
      move.w #0x0415, d1                                                       ; XY (4, 21)
      bra @Pad2DownDone                                                        ; branch when finished
@Pad2NoDown:
      lea NotPressedString, a0                                                 ; String address
      move.l #PixelFontTileID, d0                                              ; First tile id
      move.w #0x0415, d1                                                       ; XY (4, 21)
@Pad2DownDone:
      jsr DrawTextPlaneA                                                       ; Call draw text subroutine

      move.w (controllerinput), d0                                             ; restore controller input from memory

      btst #pad_button_left, d0                                                ; Check left button
      bne @Pad2NoLeft                                                          ; Branch if button off
      lea PressedString, a0                                                    ; String address
      move.l #PixelFontTileID, d0                                              ; First tile id
      move.w #0x0112, d1                                                       ; XY (1, 18)
      bra @Pad2LeftDone                                                         ; branch when finished
@Pad2NoLeft:
      lea NotPressedString, a0                                                 ; String address
      move.l #PixelFontTileID, d0                                              ; First tile id
      move.w #0x0112, d1                                                       ; XY (1, 18)
@Pad2LeftDone:
      jsr DrawTextPlaneA                                                       ; Call draw text subroutine

      move.w (controllerinput), d0                                             ; restore controller input from memory

      btst #pad_button_right, d0                                               ; Check right button
      bne @Pad2NoRight                                                         ; Branch if button off
      lea PressedString, a0                                                    ; String address
      move.l #PixelFontTileID, d0                                              ; First tile id
      move.w #0x0712, d1                                                       ; XY (7, 18)
      bra @Pad2RightDone                                                       ; branch when finished
@Pad2NoRight:
      lea NotPressedString, a0                                                 ; String address
      move.l #PixelFontTileID, d0                                              ; First tile id
      move.w #0x0712, d1                                                       ; XY (7, 18)
@Pad2RightDone:
      jsr DrawTextPlaneA                                                       ; Call draw text subroutine

      jsr WaitVBlankStart                                                      ; Wait for start of vblank

      jsr WaitVBlankEnd                                                        ; Wait for end of vblank

      jmp GameLoop                                                             ; Back to the top

      ; ************************************
      ; Data
      ; ************************************

      ; Include framework data
      include 'framework\initdata.asm'
      include 'framework\globals.asm'
      include 'framework\charactermap.asm'

      ; Include game data
      include 'globals.asm'
      include 'memorymap.asm'

      ; Include game art
      include 'assets\assetsmap.asm'

__end                                                                          ; Very last line, end of ROM address
