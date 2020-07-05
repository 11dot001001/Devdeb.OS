PositionX db 0
PositionY db 0
Reg16BitValue dw 0 
Reg16BitOutput db '0x0000', 0 
HexArray db '0123456789ABCDEF'
EmptySymbol db ' '
ConsoleRowCount equ 20
ConsoleColumnCount equ 80
CharacterByteCount equ 2
VideoMemory equ 0xb800
CharacterColor equ 0x0F;white on black

%macro BiosWriteLine 1
 	mov si, word %1
biosWriteLine_cicle:
	lodsb
	or al, al
	jz exit
	mov ah, 0x0E
	mov bh, 0
	int 0x10
	jmp biosWriteLine_cicle
exit:
%endmacro

%macro WriteLine 1
	cld
 	mov si, word %1
	call writeline2
%endmacro

PrintReg16Bit:
;in Reg16BitValue word contains reg value
	mov ax, [Reg16BitValue]
	mov di, Reg16BitOutput + 2
	mov si, HexArray
	mov cx, 4
	cld
printReg16Bit_hexloop:
	rol ax, 4
	mov bx, ax
	and bx, 0xf
	mov bl, [si + bx]
	mov [di], bl
	inc di
	loop printReg16Bit_hexloop

	WriteLine Reg16BitOutput
ret

ClearConsole:
	mov ax, VideoMemory
	mov es, ax
	mov byte [PositionX], 0
	mov byte [PositionY], 0
	mov cx, ConsoleRowCount
clearRow:
	mov al, byte [PositionX]
	cmp al, ConsoleColumnCount
	jz switchNextRow
	mov al, [EmptySymbol]
	call writeCharacter
	loop clearRow
switchNextRow:
	mov al, byte [PositionY]
	cmp al, ConsoleRowCount
	jz ClearConsole_exit
	add byte [PositionY], 1
	mov byte [PositionX], 0
	jmp clearRow
ClearConsole_exit:
	mov byte [PositionX], 0
	mov byte [PositionY], 0
ret

writeline2:
	mov ax, VideoMemory
	mov es, ax
	lodsb
	cmp al, 0
	je exit
	call writeCharacter
	jmp writeline2
exit:
	mov byte [PositionX], 0
	add byte [PositionY], 1
ret

writeCharacter:
;in al contains character
	mov ah, CharacterColor
	mov cx, ax
	movzx ax, byte [PositionY] 
	mov dx, CharacterByteCount * ConsoleColumnCount
	mul dx
	movzx bx, byte [PositionX]
	shl bx, 1

	mov di, 0
	add di, ax ;Y offset
	add di, bx ;X offset

	mov ax, cx
	stosw
	add byte [PositionX], 1
ret