BITS 64
GLOBAL _start

SECTION .data
msg:    db "Hello, world!", 10
len_msg equ $ - msg
hexbuf: times 48 db 0

SECTION .text

_start:
    xor rax, rax
    rdtsc
    shl rdx, 32
    or rax, rdx
    mov rcx, 7
    xor rdx, rdx
    div rcx
    mov rsi, rdx

    cmp rsi, 0
    je use_variant0
    cmp rsi, 1
    je use_variant1
    cmp rsi, 2
    je use_variant2
    cmp rsi, 3
    je use_variant3
    cmp rsi, 4
    je use_variant4
    cmp rsi, 5
    je use_variant5
use_variant6:
    lea r12, [rel variant6_start]
    lea rax, [rel variant6_end]
    sub rax, r12
    mov r13, rax
    jmp alloc_and_copy
use_variant5:
    lea r12, [rel variant5_start]
    lea rax, [rel variant5_end]
    sub rax, r12
    mov r13, rax
    jmp alloc_and_copy
use_variant4:
    lea r12, [rel variant4_start]
    lea rax, [rel variant4_end]
    sub rax, r12
    mov r13, rax
    jmp alloc_and_copy
use_variant3:
    lea r12, [rel variant3_start]
    lea rax, [rel variant3_end]
    sub rax, r12
    mov r13, rax
    jmp alloc_and_copy
use_variant2:
    lea r12, [rel variant2_start]
    lea rax, [rel variant2_end]
    sub rax, r12
    mov r13, rax
    jmp alloc_and_copy
use_variant1:
    lea r12, [rel variant1_start]
    lea rax, [rel variant1_end]
    sub rax, r12
    mov r13, rax
    jmp alloc_and_copy
use_variant0:
    lea r12, [rel variant0_start]
    lea rax, [rel variant0_end]
    sub rax, r12
    mov r13, rax

alloc_and_copy:
    xor rdi, rdi
    mov rsi, r13
    mov rdx, 0x7
    mov r10, 0x22
    mov r8, -1
    xor r9, r9
    mov rax, 9
    syscall
    mov r14, rax

    mov rcx, r13
    mov rsi, r12
    mov rdi, r14
    cld
    rep movsb

    lea rsi, [r14]
    lea rdi, [rel hexbuf]
    mov rcx, 16
dump_loop:
    mov al, [rsi]
    mov ah, al
    shr al, 4
    and al, 0x0F
    add al, 0x30
    cmp al, 0x39
    jbe skipA
    add al, 7
skipA:
    mov [rdi], al
    inc rdi
    mov al, ah
    and al, 0x0F
    add al, 0x30
    cmp al, 0x39
    jbe skipB
    add al, 7
skipB:
    mov [rdi], al
    inc rdi
    mov byte [rdi], ' '
    inc rdi
    inc rsi
    loop dump_loop

    mov rdx, 49
    mov rax, 1
    mov rdi, 1
    lea rsi, [rel hexbuf]
    syscall

    mov rax, 1
    mov rdi, 1
    mov rsi, msg
    mov rdx, len_msg
    syscall

    call r14

    mov rax, 60
    xor rdi, rdi
    syscall

variant0_start:
    push rbp
    mov rbp, rsp
    xor rax, rax
    mov al, 1
    syscall
    pop rbp
    ret
variant0_end:

variant1_start:
    push rbx
    xchg rbx, rbx
    mov rax, 1
    syscall
    pop rbx
    ret
variant1_end:

variant2_start:
    mov rax, 1
    nop
    nop
    syscall
    ret
variant2_end:

variant3_start:
    push rbx
    push rcx
    mov rbx, rdi
    mov rcx, rsi
    xor rax, rax
    add rbx, 0
    add rcx, 0
    mov rdi, rbx
    mov rsi, rcx
    mov rax, 1
    syscall
    pop rcx
    pop rbx
    ret
variant3_end:

variant4_start:
    push r15
    push r14
    push r13
    xor r15, r15
    lea r14, [r15 + 0]
    add r14, 0
    mov rax, 1
    syscall
    pop r13
    pop r14
    pop r15
    ret
variant4_end:

variant5_start:
    jmp entry5
entry5:
    nop
    nop
    mov rax, 0
    cmp rax, 0
    je do_syscall5
    jmp endv5
do_syscall5:
    mov rax, 1
    syscall
endv5:
    ret
variant5_end:

variant6_start:
    xor rax, rax
    mov al, 1
    syscall
    ret
variant6_end:
