bits 32

global start

extern exit,printf,scanf 

import exit msvcrt.dll   
import printf msvcrt.dll  
import scanf msvcrt.dll

segment data use32 class=data
    ; Read two numbers a and b in decimal. 
    ; Calculate a / b and display the quotient and the remainder in the following format: 
    ; "Quotient = <quotient>, remainder = <remainder>". 
    
    ; Example: a = 23, b = 10 =>
    ; Quotient = 2, remainder = 3. 
    ; The values will be displayed in decimal format.
    a dd 0
    b dd 0
    quotient dd 0
    reminder dd 0
    formatA db 'Insert a decimal value for A=', 0
    formatB db 'Insert a decimal value for B=', 0
    readFormat db "%d", 0
    printformat db 'Quotient = %d, reminder = %d', 0 
    
; our code starts here
segment code use32 class=code
    start:
        ; print the format for A string
        push dword formatA
        call [printf]
        add esp, 4*1
        
        ; read the A number
        push dword a ; se pune pe stiva offset-ul variabilei!!
        push dword readFormat
        call [scanf]
        add esp, 4*2
        
        ; print the format for B string
        push dword formatB
        call [printf]
        add esp, 4*1
        
        ; read the B number
        push dword b ; se pune pe stiva offset-ul variabilei!!
        push dword readFormat
        call [scanf]
        add esp, 4*2
        
        mov eax, [a]
        mov ebx, 0
        mov bx, [b]
        cwd
        idiv ebx; EAX:EDX
        
        mov [quotient], EAX
        mov [reminder], EDX
        
        push dword[reminder]
        push dword[quotient]
        push dword printformat 
        call [printf]
        add esp, 4*4
        
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
