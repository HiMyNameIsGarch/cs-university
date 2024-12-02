bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; x - b + 8 + (2 * a - b) / ( b * b ) + e
    ;a-word; b-byte; e-doubleword; x-qword
    a dw 32700
    b db 120
    e dd 10000
    x dq 50000000
    r dq 0

; our code starts here
segment code use32 class=code
    start:
        ;do the parantesis
        mov ax, [a]; AX = a
        movsx eax, ax; sign extend
        add eax, eax; EAX = EAX + EAX ( 2 * a )
        ; use imul 

        mov bl, [b]; BL = b
        movsx ebx, bl; Sign extend BL into EBX
        sub eax, ebx; EAX = EAX - EBX ( 2 * a - b )

        ; parantesis
        mov bl, [b]; BL = b
        movsx ebx,bl; sign extend
        imul ebx; EBX = EBX * EBX ( b * b )

        ; division
        cdq
        idiv ebx; result in eax ( 2 * a - b ) / ( b * b )
        
        ; pune in auxiliar 
        
        ; I only need the result from eax so I can move it else where
        mov ebx, eax
        
        ; store the qword
        mov eax, [x+0]; EAX = x + 0
        mov edx, [x+4]; EBX = x + 4

        mov cl, [b]; CL = b
        movsx ecx, cl; sign extend

        sub eax, ecx ; EAX = EAX - b    ( x - b )
        add eax, 8; EAX = EAX + 8    ( x - b + 8  )

        ; add them together
        add eax, ebx; EAX = x - b + 8 + ( 2 * a - b ) / ( b * b )

        mov ebx, [e]; EBX = 8
        add eax, ebx; EAX = EAX + EBX   x - b + 8 + ( 2 * a - b ) / ( b * b ) + e

        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
