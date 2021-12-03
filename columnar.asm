section .data
    extern len_cheie, len_haystack
    index dd 0

section .text
    global columnar_transposition


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

    
    mov eax, [index]
    xor eax, eax
    mov [index], eax

    xor edx, edx

    ;; get the number of lines and store on the stack
    mov eax, [len_haystack]
    mov ecx, [len_cheie]
    div ecx
    inc eax
    push eax


    ;; reset ecx register
    xor ecx, ecx

    ; Iterate through vector

    ;; ecx iterate through key vector [0, len_cheie -1]
    ;; eax iterate through the column at index ecx

columnar_loop:

    xor eax, eax
    
    

column_loop:
    ;; index of the current column
    mov edx, [edi + (ecx * 4)]

    ;; get the index of the char in plain text
    push edi
    mov edi, [len_cheie]
    imul edi, eax
    

    ;; save the current index stored in eax
    ;; and put the index of the current character of cypertext
    push eax
    mov eax, [index]

    ;; the index of cypertext where the next character should be
    lea eax, [ebx + eax]

    push ebx
    mov ebx, esi

    ;; get the character from haystack
    lea ebx, [ebx + edi]
    lea ebx, [ebx + edx] 

    mov bl, byte[ebx]

    ;; add the character to cypertext
    mov byte[eax], bl


    ;; verify if we have a valid byte
    cmp bl, 31
    jle problem

    jmp no_problem

    cmp bl, 127
    jg  problem

    jmp no_problem

problem:
    ;; not a valid byte in our string
    ;; put nothing and decrement the index
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

    ;; put \0 to mark the end of the string
    mov eax, [index]
    mov byte[ebx + eax], 0

    ;; clear the stack
    pop edx

    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY