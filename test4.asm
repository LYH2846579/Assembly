;assume cs:code,ds:data,ss:stack             ;汇编编程基本架构

;数据段
;data segment

;data ends

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






;练习2  -> jcxz指令练习

;assume cs:code,ds:data,ss:stack             ;汇编编程基本架构

;数据段
;data segment

;data ends

;堆栈段
;stack segment stack
;        dw 15 dup(?)
;    btm dw ? 
;stack ends
                                ;my little house must think it queer, to stop without a far house near.
;代码段
;code segment    ;在s处补全程序，利用jcxz指令，实现在内存2000H段中查找到第一个为0的字节，找到后将它的偏移地址存储在dx中
;        start:  mov ax,2000H        ;※ -> 一定注意2000 != 2000H
;                mov ds,ax
;                mov bx,0

;            s:  ;sub cx,cx       ;清空cx
;                ;mov cl,ds:[bx]
;                ;jcxz ok
;                ;inc bx


;                jmp short s

;           ok:  mov dx,bx
                     

;                mov ax,4C00H
;                int 21H
;code ends
;end start



;练习3 loop指令练习

    ;在s处补全程序，利用jcxz指令，实现在内存2000H段中查找到第一个为0的字节，找到后将它的偏移地址存储在dx中
;assume cs:code,ds:data,ss:stack             ;汇编编程基本架构

;数据段
;data segment

;data ends

;堆栈段
;stack segment stack
;        dw 15 dup(?)
;    btm dw ? 
;stack ends
                                ;my little house must think it queer, to stop without a far house near.
;代码段
;code segment
;        start:  mov ax,2000H
;                mov ds,ax
;                mov bx,0

;            s:  mov cl,ds:[bx]
;                mov ch,0
;                ;inc cx         ;与loop指令的相搭配绝了!
;                inc bx
;                loop s

;           ok:  dec bx 

;                mov ax,4C00H
;                int 21H
;code ends
;end start





;练习4 结构化地址处理方式   -> 以下以一种类似if语句的形式呈现

;assume cs:code,ds:data,ss:stack             ;汇编编程基本架构

;数据段
;data segment
;        db 100 dup(?)
;data ends

;堆栈段
;stack segment stack
;        dw 15 dup(?)
;    btm dw ? 
;stack ends
                                ;my little house must think it queer, to stop without a far house near.
;代码段
;code segment
;        start:  mov ax,data
;                mov ds,ax
;                mov ax,stack
;                mov ss,ax
;                mov sp,offset btm
;                add sp,2

;                mov ax,offset s1
;                mov ds:[0],ax

;                mov ax,offset s1
;                mov ds:[2],ax

;                mov ax,offset s1
;                mov ds:[4],ax

;                mov bx,4

                ;修改CS:IP进行跳转
;                jmp word ptr ds:[bx]

;          over: mov ax,4C00H
;                int 21H

;            s1: mov ax,1000H
;                jmp over

;            s2: mov ax,1001H
;                jmp over

;            s3: mov ax,1002H
;                jmp over
;code ends
;end start




;练习5 call指令练习
;assume cs:code,ds:data,ss:stack             ;汇编编程基本架构

;数据段
;data segment
;        dw 0,0,0,0
;        dw 0,0,0,0
;data ends

;堆栈段
;stack segment stack
;        dw 0,0,0,0
;        dw 0,0,0,0
;stack ends
                                ;my little house must think it queer, to stop without a far house near.
;代码段
;code segment
;        start:  mov ax,stack
;                mov ss,ax
;                mov sp,16

;                mov ds,ax
;                mov ax,0

;                call word ptr ds:[0EH]      ;由于是在栈中，在运行debug的时候，有可能存在着一些问题

;                inc ax
;                inc ax
;                inc ax 

;                mov ax,4C00H
;                int 21H
;code ends
;end start



assume cs:code,ds:data,ss:stack             ;汇编编程基本架构

;数据段
data segment
        dw 100 dup(?)
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

                mov ax,offset s1        ;将S1地址写入内存
                mov ds:[0],ax

                mov ax,offset s2
                mov ds:[2],ax

                mov ax,offset s3
                mov ds:[4],ax


                ;选择控制跳转哪一条指令
                mov bx,2

                mov cx,0
                jcxz M1002                  ;经验证，跳转指令后面无法直接跟随call指令 -> 所有跳转指令仅仅是修改cs:ip,关执行指令屁事
        M1002:  call word ptr ds:[bx]                

                mov ax,4C00H
                int 21H

           s1:  mov ax,1000H
                ret
           s2:  mov ax,1002H
                ret
           s3:  mov ax,1003H
                ret     
code ends
end start

