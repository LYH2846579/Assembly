assume cs:code,ds:data,ss:stack             ;汇编编程基本架构

;数据段
data segment
    db 100 dup(?)
data ends

;堆栈段
stack segment stack
        dw 15 dup(?)
    btm dw ? 
stack ends
                                ;my little house must think it queer, to stop without a far house near.
;代码段
code segment
        start:  mov ax,data
                mov ds,ax
                mov ax,stack
                mov ss,ax
                mov sp,offset btm
                add sp,2

                mov ah,01h
                int 21h

                mov ax,4C00H
                int 21H
code ends
end start