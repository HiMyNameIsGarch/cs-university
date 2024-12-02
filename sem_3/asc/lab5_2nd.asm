bits 32 ; assembling for the 32 bits architecture

global start

extern exit,printf,scanf

import exit msvcrt.dll 
import printf msvcrt.dll
import scanf msvcrt.dll



segment data use32 class=data
    ; Read a string and read two characters. 
    ; Replace all occurrences of first character with second character. 
    ; Print on screen the resulted string.

    ; Ex: s = ana are 7 mere si 5 pere, 
    ; c1 = a, c2 = z 
    ; d = znz zre 7 mere si 5 pere
    formatString db 'Write a sentence: ', 0
    formatFirstChar db 'Insert character to search= ', 0
    formatSecondChar db 'Insert character to replace= ', 0
    charFormat db '%c', 0; format string
    outputFormat db 'Resulted sentence is: %s', 10, 0
    buffer db 256, 0; buffer for the input string
    charToSearch db 0
    charToReplace db 0

; our code starts here
segment code use32 class=code
    start:
        ; Prompt for the sentence
        push dword formatString
        call [printf]
        add esp, 4*1

        ; Read the string
        lea eax, [buffer]
        push eax
        call [scanf]
        add esp, 4*2

        ; Prompt for the first character (to search)
        push formatFirstChar
        call [printf]
        add esp, 4

        ; Read the first character
        lea eax, [charToSearch]
        push eax
        push charFormat
        call [scanf]
        add esp, 8

        ; Prompt for the second character (replacement)
        push formatSecondChar
        call [printf]
        add esp, 4

        ; Read the second character
        lea eax, [charToReplace]
        push eax
        push charFormat
        call [scanf]
        add esp, 8

        ; Replace characters
        lea esi, [buffer]  ; Address of the string buffer
        mov al, [charToSearch]    ; Load char1 into AL
        mov bl, [charToReplace]    ; Load char2 into BL
        

        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
