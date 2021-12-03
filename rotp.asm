section .text
    global rotp

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

    ;; set eax to 0
    xor     eax, eax
main_loop: 
    ;; set ebx to 0
    xor     ebx, ebx

    ;; get the i character of plaintext in bl
    ;; get the len - i - 1 character of key in bh
    mov     bl, [esi + eax]
    mov     bh, [edi + ecx - 1]

    ;; xor the two of them, store the result and increment i
    xor     bl, bh
    mov     byte[edx + eax], bl
    inc     eax

    loop    main_loop

    ;; mark the end of the string
    mov     byte[edx + eax], 0

    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY