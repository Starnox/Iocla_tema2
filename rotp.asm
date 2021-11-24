%include "io.mac.asm"

section .text
    global rotp

extern printf

;; void rotp(char *ciphertext, char *plaintext, char *key, int len);
rotp:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]  ; ciphertext
    mov     esi, [ebp + 12] ; plaintext
    mov     edi, [ebp + 16] ; key
    mov     ecx, [ebp + 20] ; len
    ;; DO NOT MODIFY

    ;; TODO: Implment rotp
    ;; FREESTYLE STARTS HERE

    xor     eax, eax
main_loop: 
    xor     ebx, ebx
    mov     bl, [esi + eax]
    mov     bh, [edi + ecx - 1]
    xor     bl, bh
    mov     byte[edx + eax], bl
    inc     eax

    loop    main_loop

    mov     byte[edx + eax], 0

    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY