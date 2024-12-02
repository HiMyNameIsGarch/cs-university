bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; (50-b-c) * 2 + a * a + d
    ; data types: a,b,c - byte, d - word
    a db 120
    b db 127
    c db 115
    d dw 1000
    r dd 0

; our code starts here
segment code use32 class=code
    start: ; FOR SIGNED OPERATION
    
        ; place b into AL, convert it and move it into AX
        mov al, [b]; AL = b
        cbw; AL to AX convert byte to word
        mov bx, ax; AX = BX, AX = b

        ; place c into AL, convert it and move it into BX
        mov al, [c]; AL = c
        cbw; AL = AX convert byte to word
        add bx, ax; BX = b + c ( bear with me on this one ok? )
        
        ; Add 50 into AX
        mov ax, 50; AX = 50
        ; Do the subtraction
        sub ax, bx ; AX = AX - BX ( 50 - b + c ) which is equivalent to 50 - b - c
        
        ; multiply by 2
        add ax, ax; ( 50 - b - c ) * 2
        ; move the rezult in bx
        mov bx, ax; BX = AX 
        
        ; place a into al, convert it and move it into bx
        mov al, [a]; AL = a
        cbw
        imul ax; AX = AX * AX;  ( a * a )
        
        ; add them together
        add bx, ax; BX = BX + AX ( 50 - b - c ) + ( a * a )
        
        mov ax, [d]; AX = d
        add bx, ax; BX = BX + d ; ( 50 - b - c ) + ( a * a ) + d
        
        ; final result
        mov [r], ebx; r = EBX
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
