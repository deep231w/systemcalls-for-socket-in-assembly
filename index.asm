section .data
    ip_address db 0x7f, 0x00, 0x00, 0x01 ; 127.0.0.1 (localhost)
    port dw 80  ; Port 80 (HTTP)

section .bss
    sock_fd resq 1

section .text
    global _start

_start:
    ; Create socket (AF_INET, SOCK_STREAM)
    mov rax, 41         ; syscall number for socket()
    mov rdi, 2          ; AF_INET (IPv4)
    mov rsi, 1          ; SOCK_STREAM (TCP)
    mov rdx, 0          ; Protocol (0 for IP)
    syscall

    ; Save socket descriptor in sock_fd
    mov [sock_fd], rax

    ; Bind socket to port 80 (localhost)
    mov rax, 49         ; syscall number for bind()
    ; (bind address structure setup would go here)
    syscall

    ; Listen for incoming connections
    mov rax, 50         ; syscall number for listen()
    mov rdi, [sock_fd]  ; socket descriptor
    mov rsi, 5          ; backlog
    syscall

    ; Accept incoming connection (this would be the blocking step)
    mov rax, 43         ; syscall number for accept()
    mov rdi, [sock_fd]  ; socket descriptor
    syscall

    ; Handle the connection (sending/receiving data would happen here)
    ; Use sys_send, sys_recv, etc.
