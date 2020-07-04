org 0x7C00
bits 16

jmp main

message db 'Hello World!', 13, 10, 0

%include "src/Write.asm"

main:
	xor ax,ax
	mov ds, ax

	cld
	BiosWriteLine message
	hlt

times 510 - ($-$$) db 0
dw 0xAA55