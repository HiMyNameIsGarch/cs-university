bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ( b - a ) + 3 + d - c
    ; a - word, b - byte, c - word, d - byte, r - double word
    a dw 5000
    b db 255
    c dw 1000
    d db 255
    r dd 0

; our code starts here
segment code use32 class=code
    start:
        ; Parantesis ( b - a )
        ; Put b into AX with zero extended
        movzx ax, [b]; AX = b

        ; put a into BX ( a is word 16 bytes )
        mov bx, [a] ;BX = a

        ; Sub b - a into AX
        sub ax, bx; AX = b - a

        ; Add 3 to AX
        add ax, 3; AX = AX + 3 ( b - a ) + 3

        ; Add d into AX
        add ax, [d]; AX = AX + d

        ; Subtract c
        sub ax, [c]; AX = AX - c

        ; Zero extend AX to EAX
        movzx eax, ax; EAX = AX

        ; Put result in r
        mov [r], eax; r = EAX

        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
