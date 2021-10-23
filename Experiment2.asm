assume cs:code,ds:data,ss:stack             ;汇编编程基本架构

;数据段
data segment
        crlf  db  0dh,0ah,'$'
data ends

;堆栈段
stack segment stack
        dw 15 dup(?)
    btm dw ? 
stack ends
                                
;代码段
code segment                                    ;使用循环输出
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
                ;输出#
                mov dl,'*'
                push ax
                mov ah,02H
                int 21H
                pop ax
                jmp print
        print1: dec bx
                ;判断
                jz done
                ;输出#
                mov dl,'#'
                push ax
                mov ah,02H
                int 21H
                pop ax
                jmp print1

        done:   pop cx
                ;回车+换行
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