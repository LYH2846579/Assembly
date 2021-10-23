assume cs:code,ds:data,ss:stack             ;汇编编程基本架构

;数据段
data segment
        db '000000010000000'
        db '000000111000000'
        db '000001111100000'                           ;思路是先将代码在数据段写死，接下来根据用户的输入进行代码更改
        db '000011111110000'
        db '000111111111000'
        db '000001111100000'
        db '000011111110000'                            ;2021-10-23 09:11
        db '000111111111000'                            ;已完成实验
        db '001111111111100'
        db '011111111111110'
        db '000001111100000'
        db '000001111100000'
        db '000001111100000'
        db '000001111100000'
        db '000001111100000'
  crlf  db  0dh,0ah,'$'
 INPUT1 db 'Please enter the foreground character:','$'
 INPUT2 db 'Please enter the rear view:','$'
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

                ;提示输入前景字符
                lea dx,INPUT1
                mov ah,09H
                int 21h

                ;读取前景字符
                mov ah,01h
                int 21h
                mov bl,al               ;存入bx的低八位                 前景字符 -> bl

                ;换行
                lea dx,crlf
                mov ah,09H
                int 21H

                ;提示输入后景字符
                lea dx,INPUT2
                mov ah,09H
                int 21h

                ;读取后景字符
                mov ah,01h
                int 21h
                mov bh,al               ;存入bx的高八位                 后景字符 -> bh

                ;换行
                lea dx,crlf
                mov ah,09H
                int 21H

                mov cx,0E1H               ;循环替代

                ;替代字符
                mov si,0
       begin:   mov al,ds:[si]  
                sub al,30H                              ;一定注意0的ASCII码值为30!
                jz  replace0
                mov ds:[si],bh          ;后景字符替换
                jmp continue
    replace0:   mov ds:[si],bl          ;前景字符替换
    continue:   inc si
                loop begin


                ;替换完成之后，将字符序列输出
                mov cx,15               ;共计15轮循环
                mov si,0

        flag1:  push cx
                mov cx,15
        flag:   mov dl,ds:[si]
                mov ah,02H
                int 21H
                inc si                  ;千万不要忘了si的自增!
                loop flag

                lea dx,crlf
                mov ah,09H
                int 21H

                pop cx
                loop flag1



                mov ax,4C00H
                int 21H
code ends
end start