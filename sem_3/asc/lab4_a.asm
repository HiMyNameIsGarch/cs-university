bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; .Se dau 2 siruri de octeti A si B. Sa se construiasca sirul R care sa contina doar elementele impare si pozitive din cele 2 siruri. 
    ; Exemplu:
    ; A: 2, 1, 3, -3
    ; B: 4, 5, -5, 7
    ; R: 1, 3, 5, 7
    
    ; Sirul A
    A db 2, 1, 3, -3
    Alen equ $ - A  
    ; Sirul B
    B db 4, 5, -5, 7
    Blen equ $ - B 
    ; Sirul R care are lungimea maxima A + B
    R resb Alen + Blen
    
; our code starts here
segment code use32 class=code
    start:
        mov esi, 0; the index for A
        mov edi, 0; the index for B
        mov ecx, 0; the index for R
        
        process_A:
            ; check if end of list
            cmp esi, Alen
            ; if yes, go to the next list
            jge process_B
        
            ; get the current element
            mov al, [A + esi]; AL = A[0]
            inc esi; ESI = ESI + 1
            
            ; check if negative
            cmp al, 0
            jle process_A
            
            ; check if odd
            test al, 1
            jz process_A
            
            ; the num is odd and positive, add it into the list
            mov [R + ecx], al
            inc ecx
            jmp process_A
            
         process_B:
            ; check if the list is done searching
            cmp edi, Blen
            ; exit the program if so
            jge exit_program

            ; get the current element
            mov al, [B+edi]; 
            inc edi; EDI = EDI + 1
                        
            ; check if negative
            cmp al, 0
            jle process_B; go to the next element
            
            ; test if odd
            test al, 1
            jz process_B; go next elem
            
            ; the number is odd and positive
            mov [R + ecx], al
            inc ecx; increment the position for ecx
            jmp process_B; go next
            
        exit_program:
            push dword 0
            call [exit]

        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
