;一些不符合三段分离式架构的练习题目

;练习一			;编写code段代码，将a和b段中的数据依次相加，将结果存储到c段中
;assume cs:code

;a segment
;	db	1,2,3,4,5,6,7,8
;a ends

;b segment
;	db	8,7,6,5,4,3,2,1
;b ends

;c segment
;	db	7 dup(?)
;btm	db	?
;c ends

;code segment
		;老规矩，设置初始段
;	start:	mov ax,c
;		mov es,ax
		
;		mov bx,0
;		mov cx,8
		
;	flag:	mov ax,a
;		mov ds,ax

;		mov dl,ds:[bx]
		;修改数据段
;		mov ax,b
;		mov ds,ax

;		add dl,ds:[bx]
		;将数据载入
;		mov es:[bx],dl
;		inc bx
;		loop flag



;第二个练习
		;程序如下，编写code中的代码，用Push指令将a段中前8个字型数据，逆序复制到b段中
;assume cs:code

;a segment
;	dw 1,2,3,4,5,6,7,8,0AH,0BH,0CH,0DH
;a ends

;b segment
;	dw 7 dup(?)
;btm	dw ?
;b ends

;code segment
;	start:	mov ax,a
;		mov ds,ax
		
;		mov ax,b
;		mov ss,ax
;		mov sp,10H

;		mov cx,8
;		mov bx,0

;	flag:	push ds:[bx]
;		add bx,2
;		loop flag




;第三个练习
		;使用si和di更灵活的访存方式
;assume cs:code
;code segment
;	start:	mov bx,0
;		mov si,0

;		mov ax,ds:[si]

;		inc si
;		mov ax,ds:[bx+si]

;		mov di,0
;		mov ax,ds:[bx+di]

;		mov al,ds:[bx+5]



;第四个练习
		;对and和or指令的使用练习
;assume cs:code
;code segment
;	start:	mov ax,0
;		mov al,00001111B
;		and al,11110000B

;		mov al,00001111B
;		or  al,11110000B

;		mov ax,4c00H
;		int 21H
;code ends
;end start


;第五个练习
        ;写出下面程序执行之后，ax,bx,cx中的内容
;code segment
;        mov ax,2000H
;        mov ds,ax
        
;        mov bx,1000H

;        mov si,0
        
;        mov ax,ds:[bx+2+si]
;        inc si

;        mov ax,ds:[bx+2+si]
;        inc si

;        mov di,si
;        mov bx,ds:[bx+2+si]

;        mov ax,4C00H
;        int 21H

;code ends
;end 


assume cs:code,ds:data,ss:stack             ;汇编编程基本架构

;数据段
data segment
    INPUT  db 'Please input a string:','$'
    maxlen db ?             ;定义最大长度
    actlen db ?             ;定义实际长度
    crlf   db 0dh,0ah,'$'   ;定义回车+换行
    lfLen  db ?             ;需要填充的空格的长度
    stbuf  db 512 dup(?)    ;初始数据存储的地方
    delbuf db 1024 dup(?)   ;处理之后的数据存储的地方
data ends

;堆栈段
stack segment stack
        dw 15 dup(?)
    btm dw ? 
stack ends

;代码段
code segment    ;一些预处理
        start:  mov ax,data
                mov ds,ax
                mov ax,stack
                mov ss,ax
                mov sp,offset btm
                add sp,2

                ;对字符串存储的预处理
                lea si,stbuf            ;首先存储起来
                lea di,delbuf

                ;输出提示信息
                lea dx,INPUT
                mov ah,09h
                int 21H

                ;读取字符串
                lea dx,stbuf
                mov ah,0AH
                int 21H

                ;对字符串进行处理
                mov al,stbuf+1
                add al,2
                mov ah,0
                mov di,ax
                mov stbuf[di],'$'

                ;指向输出的数据
                lea dx,stbuf+2

                ;显示字符串
                mov ah,09h
                int 21H

                mov ax,4C00H
                int 21H
code ends
end start

