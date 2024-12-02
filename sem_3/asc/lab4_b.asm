bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ;
    ; Se da un sir A de dublucuvinte.
    ; Construiti doua siruri de octeti
    ; - B1: contine ca elemente partea inferioara a cuvintelor inferioare din A
    ; - B2: contine ca elemente partea superioara a cuvintelor superioare din A 
    
    A dd 0x12345678, 0x9ABCDEF0, 0x13579BDF, 0x2468ACE0   ; exemplu de valori pentru A
    Alen equ ($ - A) / 4; the maximum length of inferior part 
    
    B1 resb Alen; the list for B1 ( list of bits ) the last 8 bits
    B2 resb Alen; the list for B2 ( list of bits ) the first 8 bits
    
    ; at final B1 should be: 78 F0 DF E0
    ; at final B2 should be: 12 9A 13 24
    

; our code starts here
segment code use32 class=code
    start:
        mov ecx, Alen
        mov esi, A
        mov edi, B1
        mov ebx, B2
        
        ; we can do this in one loop and increment the indexes of the list accordingly
        repeat:
            mov al, byte[esi]
            mov [edi], al
            inc edi
            
            mov al, byte[esi + 3] 
            mov [ebx], al
            inc ebx
            
            add esi, 4
        loop repeat
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
