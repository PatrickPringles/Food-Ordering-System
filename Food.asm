%macro PRINT 3
    	mov eax, 4
    	mov ebx, %1
    	mov ecx, %2
    	mov edx, %3
    	int 0x80
%endmacro

%macro READ 3
    	mov eax, 3
    	mov ebx, %1
    	mov ecx, %2
    	mov edx, %3
    	int 0x80
%endmacro

section .data
    	menu_msg db "A. Rice: Plain Rice    P5.00", 0xA
    		db "B. Rice: Java Rice    P10.00", 0xA
    		db "C. Ulam 1: FIsh    P35.00", 0xA
    		db "D. Ulam 2: Pork    P50.00", 0xA
    		db "E. Ulam 3: Vegetables    P20.00", 0xA
    		db "F. Dessert: Saging con yelo    P60.00", 0xA
    	menu_msg_len equ $ - menu_msg

    	Rice db "Plain Rice    P5.00"
    	Rice2 db "Java Rice    P10.00"
    	
    	Ulam db "Fish    P35.00"
    	Ulam2 db "Pork    P50.00"
    	Ulam3 db "Vegetables    P20.00"
    	
    	Dessert db "Saging con yelo    P60.00"
    	
    	message db "Enter your order: ", 0xA
    	message_len equ $ - message

    	invalid_choice db "Invalid choice! Please try again.", 10
    	invalid_choice_len equ $ - invalid_choice
    	
    	filename db "Receipt.txt", 0
	
	
	decide db "Do you want to order again? (Y/N)", 10
	decide_len equ $ - decide
	
	thank db "Thank you, come again someday!", 10
	thank_len equ $ - thank
	
	newline db 0xA, 0
	
section .bss
    	choice resb 2
    	choosy resb 1
    	fileHandle resd 1

section .text
	global _start

_start:
    	call main_loop
    	call thanks
    	call invalid_section
    	call close_file
    	
    	call exit_program
    	
    	mov eax, 5
    	mov ebx, filename
    	mov ecx, 0x41
    	mov edx, 0x1A4
    	int 0x80
    	mov [fileHandle], eax

main_loop:
    	PRINT 1, menu_msg, menu_msg_len
    	PRINT 1, message, message_len
    	READ 0, choice, 2

    	cmp byte [choice], 'A'
    	je plain_rice

    	cmp byte [choice], 'B'
    	je java_rice

    	cmp byte [choice], 'C'
    	je fish
    
    	cmp byte [choice], 'D'
    	je pork
    	
    	cmp byte [choice], 'E'
    	je vegetables
    	
    	cmp byte [choice], 'F'
    	je dessert
    	
    	jmp invalid_section  ; Loop back to menu after invalid choice

plain_rice:
    	mov eax, 5
    	mov ebx, filename
    	mov ecx, 0x41
    	mov edx, 0x1A4
    	int 0x80
    	mov [fileHandle], eax
    	
    	mov eax, 4
    	mov ebx, [fileHandle]
    	mov ecx, Rice
    	mov edx, 6
    	int 0x80
    	
    	mov eax, 4
    	mov ebx, [fileHandle]
    	mov ecx, newline
    	mov edx, 1
    	int 0x80
    	
    	PRINT 1, decide, decide_len
    	READ 0, choosy, 1
    	
    	mov al, [choosy]
    	cmp al, 'Y'
    	je main_loop
    	cmp al, 'N'
    	je thanks
java_rice:
    	mov eax, 4
    	mov ebx, [fileHandle]
    	mov ecx, Rice2
    	mov edx, 6
    	int 0x80
    	
    	mov eax, 4
    	mov ebx, [fileHandle]
    	mov ecx, newline
    	mov edx, 1
    	int 0x80
    	
    	PRINT 1, decide, decide_len
    	READ 0, choosy, 1
    	
    	mov al, [choosy]
    	cmp al, 'Y'
    	je main_loop
    	cmp al, 'N'
    	je thanks
fish:
    	mov eax, 4
    	mov ebx, [fileHandle]
    	mov ecx, Ulam
    	mov edx, 6
    	int 0x80
    	
    	mov eax, 4
    	mov ebx, [fileHandle]
    	mov ecx, newline
    	mov edx, 1
    	int 0x80
    	
    	PRINT 1, decide, decide_len
    	READ 0, choosy, 1
    	
    	mov al, [choosy]
    	cmp al, 'Y'
    	je main_loop
    	cmp al, 'N'
    	je thanks
pork:
	mov eax, 4
    	mov ebx, [fileHandle]
    	mov ecx, Ulam2
    	mov edx, 6
    	int 0x80
    	
    	mov eax, 4
    	mov ebx, [fileHandle]
    	mov ecx, newline
    	mov edx, 1
    	int 0x80
    	
    	PRINT 1, decide, decide_len
    	READ 0, choosy, 1
    	
    	mov al, [choosy]
    	cmp al, 'Y'
    	je main_loop
    	cmp al, 'N'
    	je thanks
vegetables:
	mov eax, 4
    	mov ebx, [fileHandle]
    	mov ecx, Ulam3
    	mov edx, 6
    	int 0x80
    	
    	mov eax, 4
    	mov ebx, [fileHandle]
    	mov ecx, newline
    	mov edx, 1
    	int 0x80
    	
    	PRINT 1, decide, decide_len
    	READ 0, choosy, 1
    	
    	mov al, [choosy]
    	cmp al, 'Y'
    	je main_loop
    	cmp al, 'N'
    	je thanks
dessert:
	mov eax, 4
    	mov ebx, [fileHandle]
    	mov ecx, Dessert
    	mov edx, 6
    	int 0x80
    	
    	mov eax, 4
    	mov ebx, [fileHandle]
    	mov ecx, newline
    	mov edx, 1
    	int 0x80
    	
    	PRINT 1, decide, decide_len
    	READ 0, choosy, 1
    	
    	mov al, [choosy]
    	cmp al, 'Y'
    	je main_loop
    	cmp al, 'N'
    	je thanks
thanks:
	PRINT 1, thank, thank_len
	
	;PRINT 1, 
	
	jmp exit_program
	
invalid_section:
	mov eax, 4
    	mov ebx, 1
    	mov ecx, invalid_choice
    	mov edx, invalid_choice_len
    	int 0x80
    	
    	jmp main_loop
    	
close_file:
	mov eax, 6
    	mov ebx, [fileHandle]
    	int 0x80
	
exit_program:
    	mov eax, 1
    	xor ebx, ebx
    	int 0x80
