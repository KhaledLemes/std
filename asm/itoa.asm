.intel_syntax noprefix
.global _start
.text
_start:
 mov rdi, 2587424654
 lea rsi, [str]
 call _itoa
 
 lea rdi, [str]
 call strlen

 lea rsi, [str]
 mov rdx, rax
 call print

.exit:
 mov rax, 60
 mov rdi, 0
 syscall

print:
 mov rax, 1
 mov rdi, 1
 syscall
 ret

;# char * itoa(int n, char *str)
_itoa:
 mov rax, rdi ;# prepares RAX for division
 mov r8b, 0 ;# int negative = 0;
 mov r9b, 0 ;# int i = 0;

 cmp rdi, 0 ;# if (!n)
 jne .not_zero

 .ret_zero:
  mov byte ptr [str], '0' ;# str[0] = '0'
  mov byte ptr [str+1], 0 ;# str[1] = 0
  lea rbx, [str] ;# return str
  ret

 .not_zero:
 cmp rdi, 0 ;# negative = (n < 0)
 jl .is_neg

 ;# while (n) {
.main_loop:
cmp rdi, 0
je .main_loop_end ;# while (new)

 mov r10, r9 ;# int j = i;
 .shift_loop: 
 cmp r10b, 0 ;# j > 0
 jg .shift

 mov rcx, 10
 cqo
 idiv rcx ;# Divides by 10 and throws mod to rdx

 mov r11b, dl ;# mod = n%10
 add r11b, '0' ;# mod+0x30
 mov byte ptr [str], r11b ;# str[0] = mod

 cmp rax, 0
 je .main_loop_end ;# if (!n) {break;}

 inc r9
 jmp .main_loop ;# } //ends while loop

.is_neg:
 mov r8b, 1
 jmp .not_zero

 .shift:
 lea rsi, [str] ;# Holds [str] addres
 add rsi, r10 ;# str[j]
 mov r11, rsi 
 dec r11 ;# Holds the address of j-1;
 mov r12b, [r11] ;# r14 holds the value of str[j-1];
 mov byte ptr [rsi], r12b ;# str[j] = str[j-1];
 dec r10b ;# j--
 jmp .shift_loop

.main_loop_end:
 lea r10, [str] ;# str[0];
 inc r9
 add r10, r9 ;# str[i+1];
 mov byte ptr [r10], 0 ;# str[i+1] = 0; // puts '\0' at the end
 lea rbx, [str] ;# returns str address to rbx
 ret

strlen:
    mov rax, rdi

.loop:
    cmp byte ptr [rax], 0
    je .done
    inc rax
    jmp .loop

.done:
    sub rax, rdi
    ret

.data
str:
        .skip 32, 0x48
        
ln: .byte '\n'


