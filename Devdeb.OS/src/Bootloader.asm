org 0x7C00
bits 16

jmp main

msg db "OS is running...", 0
CiclePositionX db 0
CiclePositionY db 0
InputChar db ' ', 0

%include "src/Write.asm"

main:
	xor ax, ax    
	mov ds, ax  
	mov ss, ax
	mov sp, 0x9c00   
	
	call ClearConsole
	WriteLine msg
	mov ax, [PositionX]
	mov [CiclePositionX], ax
	mov ax, [PositionY]
	mov [CiclePositionY], ax
A:
	in al, 0x60
	xor ah, ah
	mov [InputChar], al
	call PrintReg16Bit
	;WriteLine InputChar
	;mov ax, [0x0]
	;mov word [Reg16BitValue], ax
	;call PrintReg16Bit
	mov ax, [CiclePositionX]
	mov [PositionX], ax
	mov ax, [CiclePositionY]
	mov [PositionY], ax
loop A

times 510 - ($-$$) db 0
dw 0xAA55