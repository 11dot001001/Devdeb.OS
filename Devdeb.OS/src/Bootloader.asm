;******************
org 0x7c00
bits 16

Start:
   mov ax, cs
   cli
   mov ss, ax
   mov es, ax
   mov ds, ax
   sti

   mov cx, 1 ;symbol repetitions number 

   ;cursor setter
   mov ah, 2
   mov bh, 0
   mov dh, 0
   mov dl, 0
   int 10h
   ;symbol output
   mov ah, 9
   mov bx, 0Fh
   mov al, 'H'
   int 10h 

   ;cursor setter
	mov ah, 2
	mov bh, 0
	mov dh, 0
	mov dl, 1
	int 10h
	;symbol output
	mov ah, 9
	mov bx, 0Fh
	mov al, 'I'
	int 10h 

	hlt

times 510 - ($-$$) db 0
dw 0xAA55