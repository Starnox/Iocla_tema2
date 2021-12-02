%include "io.mac.asm"
; This is your structure
struc  my_date
    .day: resw 1
    .month: resw 1
    .year: resd 1
endstruc


section .text
    global ages

extern printf

; void ages(int len, struct my_date* present, struct my_date* dates, int* all_ages);
ages:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]  ; len
    mov     esi, [ebp + 12] ; present
    mov     edi, [ebp + 16] ; dates
    mov     ecx, [ebp + 20] ; all_ages
    ;; DO NOT MODIFY

    ;; TODO: Implement ages
    ;; FREESTYLE STARTS HERE

main_loop:
    xor     eax, eax
    xor     ebx, ebx
    mov     ax, word[edi + my_date_size * (edx - 1) + my_date.year] ;; get the year
    mov     bx, word[esi + my_date.year] ;; get the current year
    sub     bx, ax
    

    mov     ax, word[edi + my_date_size * (edx - 1) + my_date.month] ;; get the month
    cmp     ax, word[esi + my_date.month]
    jl      continue

    cmp     ax, word[esi + my_date.month]
    je      same_month

    dec     bx
    jmp     continue

same_month:
    mov     ax, word[edi + my_date_size * (edx - 1) + my_date.day] ;; get the day
    cmp     ax, word[esi + my_date.day]
    jle      continue

    dec     bx

    cmp     bx, 0xffff
    jne     continue

    mov     bx, 0

continue:

    ; PRINTF32 `%u\n\x0`, ebx
    mov     [ecx + 4 * (edx - 1)], ebx

    dec     edx
    cmp     edx, 0
    jne     main_loop

    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY
