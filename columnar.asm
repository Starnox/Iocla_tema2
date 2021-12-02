%include "io.mac.asm"
section .data
    extern len_cheie, len_haystack

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

    xor edx, edx

    ;; get the number of lines and store aon the stack
    mov eax, [len_haystack]
    mov ecx, [len_cheie]
    div ecx
    inc eax
    push eax


    xor ecx, ecx
    xor si, si

columnar_loop:

    xor eax, eax
    ;; index of the current column
    mov edx, [edi + (ecx * 4)]

column_loop:
    push edi
    mov edi, [len_cheie]
    imul edi, eax
    mov [ebx + si], [esi + edi]
    pop edi
    inc si

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

    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY