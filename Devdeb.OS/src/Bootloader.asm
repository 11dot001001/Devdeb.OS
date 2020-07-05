org 0x7C00
bits 16

jmp main

%include "src/Write.asm"

main:
	xor ax, ax    
	mov ds, ax  
	mov ss, ax
	mov sp, 0x9c00   

    call ClearConsole
	WriteLine msg

	mov ax, 0xFF0F
	mov word [Reg16BitValue], ax
	call PrintReg16Bit
	
	hlt

msg db "OS is running...", 0
times 510 - ($-$$) db 0
dw 0xAA55