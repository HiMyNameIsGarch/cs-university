bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    a dw 0101_1010_0101_1010b
    b dw 1110_0001_0011_1100b
    c dd 0
    
    ; 1011 0100 0100 1111 0000 0000 1111 1111
    ; the bits 8-15 of C have the value 0
    ; the bits 16-23 of C are the same as the bits of 2-9 of B
    ; the bits 24-31 of C are the same as the bits of 7-14 of A
    ; the bits 0-7 of C have the value 1 
    ; we can actually do the final step the second to simplify our work
    ; FINAL C ( 32 bits )
    ; 4 steps
    ; 1010 1010 0101 0101 0000 0000 1111 1111
    ; - 7 ' 14 a -  -   2 ' 9 b  -  -   zeros   -  -    ones  -

; our code starts here
segment code use32 class=code
    start:
        mov ax, [a]
        mov bx, [b]
        mov ecx, [c]
        
        ; A
        rol ax, 1
        mov dx, ax
        rol edx, 16
        and edx, 1111_1111_0000_0000_0000_0000_0000_0000b
        or ecx, edx
        
        mov edx, 0
        
        ; B
        ror bx, 2
        mov dx, bx
        rol edx, 16
        and edx, 0000_0000_1111_1111_0000_0000_0000_0000b
        or ecx, edx
        
        ; put 1's
        or ecx, 0000_0000_0000_0000_0000_0000_1111_1111b
        
        mov [c], ecx
        
        ; put 1's 
        
        ; Step 1: bits 0-7 of C to 1
        ; mov al, 0xFF             ; Set eax to 0x11111111
       
        ; ; Step 2: bits 8-15 of C to 0
        ; mov ah, 0x00

        ; ; Step 3: bits 16-23 of C to bits 2-9 of B
        ; mov bx, [b]; put B into bx
        ; shr bx, 2; shift by 2
        ; and bx, 0xFF; mask to keep the final bits
        ; shl ebx, 16; shift left by 16 to place the bits on the pos 16-23
        ; or eax, ebx; combine into eax the rezult from ebx

        ; ; Step 4: bits 24-31 of C to bits 7-14 of A
        ; mov bx, [a]; put A into bx
        ; shr bx, 7; shift by 7
        ; and bx, 0xFF; mask to keep the final bits
        ; shl ebx, 24; shift left by 24 to place these bits in the 24-31 range
        ; or eax, ebx ; combine into eax the rezult from ebx

        ; ; Store the variable to see it in hex dump :P
        ; mov [c], eax; C = EAX

        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
