assume cs:code,ds:data,ss:stack             ;����̻����ܹ�

;���ݶ�
data segment
        crlf  db  0dh,0ah,'$'
data ends

;��ջ��
stack segment stack
        dw 15 dup(?)
    btm dw ? 
stack ends
                                
;�����
code segment                                    ;ʹ��ѭ�����
        start:  mov ax,data
                mov ds,ax
                mov ax,stack
                mov ss,ax
                mov sp,offset btm
                add sp,2

                mov cx,9

        begin:  mov ax,cx
                inc ax
                mov bx,11
                sub bx,cx
                push cx
                mov cx,10
        print:  dec ax
                jz  print1
                ;���#
                mov dl,'*'
                push ax
                mov ah,02H
                int 21H
                pop ax
                jmp print
        print1: dec bx
                ;�ж�
                jz done
                ;���#
                mov dl,'#'
                push ax
                mov ah,02H
                int 21H
                pop ax
                jmp print1

        done:   pop cx
                ;�س�+����
                lea dx,crlf
                mov ah,09H
                int 21H
                loop begin
                
                lea dx,crlf
                mov ah,09H
                int 21H

                mov ax,4C00H
                int 21H
code ends
end start