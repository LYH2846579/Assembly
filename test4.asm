;assume cs:code,ds:data,ss:stack             ;汇编编程基本架构

;数据段
;data segment

data ends

;堆栈段
;stack segment stack
;        dw 15 dup(?)
;    btm dw ? 
;stack ends
                            ;以下程序，可以正常终止吗?      
;代码段
;code segment
;                mov ax,4C00H
;                int 21H

;        start:  mov ax,0                            ;首先对程序进行分析
;            s:  nop                                 ;mov指令会将s2处jmp short s1指令复制到s处      
;                nop                                 ;注意，此时该指令机器码为EBF6    -> 相对于jmp指令，向前跳转10字节
                                                    ;一定要特别注意jmp指令机器码的跳转方式!
;                mov di,offset s
;                mov si,offset s2
;                mov ax,cs:[si]
;                mov cs:[di],ax

;            s0: jmp short s

;            s1: mov ax,0                            ;int 21H中断的0号功能是啥?  -> 测试一下
;                int 21H
;                mov ax,0

;            s2: jmp short s1
;                nop

;code ends
;end start








assume cs:code,ds:data,ss:stack             ;汇编编程基本架构

;数据段
data segment

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

                mov ax,4C00H
                int 21H
code ends
end start