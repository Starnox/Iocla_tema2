;; defining constants, you can use these as immediate values in your code
CACHE_LINES  EQU 100
CACHE_LINE_SIZE EQU 8
OFFSET_BITS  EQU 3
TAG_BITS EQU 29 ; 32 - OFSSET_BITS

section .data
    reg_address dd 0
    tags        dd 0
    cache       dd 0
    address     dd 0
    to_replace  dd 0

section .text
    global load
    extern printf

;; void load(char* reg, char** tags, char cache[CACHE_LINES][CACHE_LINE_SIZE], char* address, int to_replace);
load:
    ;; DO NOT MODIFY
    push ebp
    mov ebp, esp
    pusha

    mov eax, [ebp + 8]  ; address of reg
    mov ebx, [ebp + 12] ; tags
    mov ecx, [ebp + 16] ; cache
    mov edx, [ebp + 20] ; address
    mov edi, [ebp + 24] ; to_replace (index of the cache line that needs to be replaced in case of a cache MISS)
    ;; DO NOT MODIFY

    ;; TODO: Implment load
    ;; FREESTYLE STARTS HERE

    ;; put all the parameters in global variables so we have registers to work it
    mov [reg_address], eax
    mov [tags], ebx
    mov [cache], ecx
    mov [address], edx
    mov [to_replace], edi    

    ;; look if we have the tag in our list of tags


    ;; the tag is made out of the first 29 bits of the address recieved
    ;; mask of the last 3 bits
    mov eax, 0xffffffff
    xor eax, 7
    and edx, eax

    ;; edx now holds the tag
    ;; search tag in tags
    mov ecx, CACHE_LINES

    ;; ebx holds the tags vector
    mov ebx, [tags]
search_tag:
    cmp edx, [ebx + ecx - 1]
    je cache_hit

    loop search_tag

cache_miss:
    ;; edi is the index where we should write data
    ;; save edi to ecx because we will use it when we load
    mov ecx, edi

    ;; add to the tags vector
    mov [ebx + edi - 1], edx

    ;; populate cache with what is at the address given

    ;; get the cache address
    mov edx, [cache]

    imul edi, CACHE_LINE_SIZE

    ;; get the correct line
    
    lea edx, [edx + edi]

    ;; we have in edx where we should put the data

    ;; get the address and mask off the last 3 bits
    mov eax, [address]
    mov ebx, 0xffffffff
    xor ebx, 7
    and eax, ebx

    ;; move the first 4 bytes
    mov eax, [eax]
    mov [edx], eax

    ;; get the address and mask off the last 3 bits and add 4
    mov eax, [address]
    mov ebx, 0xffffffff
    xor ebx, 7
    and eax, ebx
    add eax, 4

    ;; move the next 4 bytes
    mov eax, [eax]
    mov [edx + 4], eax


cache_hit:
    ;; ecx will store the at which tha tag was found

    ;; calculate offset
    mov eax, [address]
    and eax, 7

    ;; get the register address
    mov ebx, [reg_address]

    ;; get the cache address
    mov edx, [cache]

    imul ecx, CACHE_LINE_SIZE

    ;; get the correct line
    lea edx, [edx + ecx]

    ;; add the index to get the column
    lea edx, [edx + eax]

    ;; set the byte in the register address
    mov dl, byte[edx]
    mov byte[ebx], dl

    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY


