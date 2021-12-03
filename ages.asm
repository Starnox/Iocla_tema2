; This is your structure
struc  my_date
    .day: resw 1
    .month: resw 1
    .year: resd 1
endstruc

section .text
    global ages

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
    ;; reset the registers
    xor     eax, eax
    xor     ebx, ebx

    ;; get the current birth year
    mov     ax, word[edi + my_date_size * (edx - 1) + my_date.year] 
    mov     bx, word[esi + my_date.year] ;; get the current year
    sub     bx, ax
    

    mov     ax, word[edi + my_date_size * (edx - 1) + my_date.month] ;; get the month
    cmp     ax, word[esi + my_date.month]
    jl      continue

    ;; check if same month
    cmp     ax, word[esi + my_date.month]
    je      same_month

    ;; the birthday wasn't this year
    dec     bx
    jmp     continue

same_month:

    ;; check the day
    mov     ax, word[edi + my_date_size * (edx - 1) + my_date.day] ;; get the day
    cmp     ax, word[esi + my_date.day]
    jle     continue ;; the birthday took place


    ;; the birthday didn't took place
    dec     bx
    cmp     bx, 0xffff
    jne     continue

    mov     bx, 0

continue:
    ;; place the result
    mov     [ecx + 4 * (edx - 1)], ebx

    ;; iterate next
    dec     edx
    cmp     edx, 0
    jne     main_loop

    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY
