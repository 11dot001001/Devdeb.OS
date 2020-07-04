%macro BiosWriteLine 1
 	mov si, word %1
cicle:
	lodsb
	or al, al
	jz exit
	mov ah, 0x0E
	mov bh, 0
	int 0x10
	jmp cicle
exit:
%endmacro