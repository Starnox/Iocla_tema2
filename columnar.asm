%include "io.mac.asm"
section .data
    extern len_cheie, len_haystack
    index dd 0

section .text
    global columnar_transposition

extern printf

;; void columnar_transposition(int key[], char *haystack, char *ciphertext);
columnar_transposition:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha 

    mov edi, [ebp + 8]   ;key
    mov esi, [ebp + 12]  ;haystack
    mov ebx, [ebp + 16]  ;ciphertext
    ;; DO NOT MODIFY

    ;; TODO: Implment columnar_transposition
    ;; FREESTYLE STARTS HERE

    ; PRINTF32 `%u\n\x0`, ecx

    ; Iterate through vector

    ;; ecx iterate through key vector [0, len_cheie -1]
    ;; eax iterate through the column at index ecx
    mov eax, [index]
    xor eax, eax
    mov [index], eax

    xor edx, edx

    ;; get the number of lines and store aon the stack
    mov eax, [len_haystack]
    mov ecx, [len_cheie]
    div ecx
    inc eax
    push eax


    xor ecx, ecx

columnar_loop:

    xor eax, eax
    ;; index of the current column
    

column_loop:
    mov edx, [edi + (ecx * 4)]

    ;; get the index of the char in plain text
    push edi
    mov edi, [len_cheie]
    imul edi, eax
    
    ;; verify 

    ;; save the current index stored in eax
    ;; and put the index of the current character of cypertext
    push eax
    mov eax, [index]

    lea eax, [ebx + eax]
    push ebx
    mov ebx, esi
    lea ebx, [ebx + edi]
    lea ebx, [ebx + edx] 

    mov bl, byte[ebx]
    mov byte[eax], bl

    cmp bl, 31
    jle problem

    jmp no_problem

    cmp bl, 127
    jg  problem

    jmp no_problem

problem:
    ;; if it is 0 put nothing and substract index
    mov byte[eax], ''
    mov eax, [index]
    dec eax
    mov [index], eax
    

no_problem:

    pop ebx 
    
    mov eax, [index]
    inc eax
    mov [index], eax

    pop eax
    pop edi

    ;; see if we completed the column and push the number of lines back on the stack
    inc eax
    pop edx
    push edx
    cmp eax, edx
    jne column_loop


    ;; check if finish
    inc ecx
    cmp ecx, [len_cheie]
    jne columnar_loop


debug:
    mov eax, [index]
    mov byte[ebx + eax], 0

    pop edx

    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY