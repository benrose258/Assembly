;
; AssemblerApplication1.asm
;
; Created: 10/2/2018 5:36:18 PM
; Author : Ben Rose
;


; Replace with your application code

.include "m328Pdef.inc"

init:
ldi r22, 0x20
sts 0x0100, r22

main:
ldi zh, 0x01
ldi zl, 0x00
clr 22
ld r22, z