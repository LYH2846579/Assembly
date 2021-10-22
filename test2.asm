;练习1：一使用规范分段，设置初始值的练习				->本文件为了对代码框架进行多加练习，每个练习都需要写出自己的框架！
;assume cs:code,ds:data,ss:stack

;data segment
;	dw 0123H,0456H,0789H,0ABCH,0DEFH,0FEDH,0CBAH,0987H
;data ends

;stack segment stack
;	dw 7 dup(?)
;btn	dw ?
;stack ends

;code segment
		;设置各项数据段
;	start:	mov ax,stack
;		mov ss,ax
;		mov sp,offset btn
;
;		mov ax,data
;		mov ds,ax
;
;		push ds:[0]
;		push ds:[2]
;		pop ds:[2]
;		pop ds:[0]

;		mov ax,4C00H
;		int 21H
;code ends
;end start



;练习2：实现字母的大小写转换
;assume cs:code,ds:data,ss:stack

;data segment
;	db 'Basic'			;将第一个字符串转换为大写
;	db 'iNfOrnMaTiOn'		;将第二个字符串转换为小写
;data ends

;stack segment stack
;	dw 15 dup(?)
;btm	dw ?
;stack ends

;code segment
;	start:	mov ax,stack
;		mov ss,ax
;		mov sp,offset btm

;		mov ax,data
;		mov ds,ax

;		mov bx,0
;		mov cx,5

;     upLetter:	mov al,ds:[bx]
;		and al,11011111B
;		mov ds:[bx],al
;		inc bx
;		loop upLetter

		;接下来将第二个字符串转换为小写
;		mov cx,12				;一定注意循环条件书写的位置
;    lowLetter:	mov al,ds:[bx]
;		or  al,00100000B
;		mov ds:[bx],al
;		inc bx
;		loop lowLetter

;		mov ax,4C00H
;		int 21H
;code ends
;end start




;练习2增强版		-> 一次将两个字母进行变化
;assume cs:code,ds:data,ss:stack

;data segment
;	db 'Basic'		;将该字符串改写为全小写
;	db 'MinIx'		;将该字符串改写为全大写
;data ends

;stack segment stack
;	dw 15 dup(?)
;btm	dw ?
;stack ends

;code segment	;初始化
;	start:	mov ax,stack
;		mov ss,ax
;		mov sp,offset btm
;		add sp,2		;依据debug中的结果，是否需要对sp指针修改?	-> 确实需要修改!否则存在内存泄露问题

;		mov ax,data
;		mov ds,ax

		;开始改写
;		mov bx,0
;		mov cx,5

;	flag:	or  byte ptr ds:[bx],00100000B			;使用立即数直接对内存单元操作!!!!!!!!!!!!!※
;		and byte ptr ds:[bx+5],11011111B		;试验成功!!!!!!!!!!!!!※
;		inc bx
;		loop flag
		

;		mov ax,4C00H
;		int 21H
;code ends

;end start



;练习3
		;用si和di实现将字符串'welcome to mams!'的复制
;assume cs:code,ds:data,ss:stack

;data segment
;	db 'Welcome to masm!'
;	db '----------------'
;data ends

;stack segment stack
;        dw 15 dup(?)
;    btm dw ?
;stack ends

;code segment
;        start:  mov ax,data
;                mov ds,ax
;                mov ax,stack
;                mov ss,ax
                
;                mov bx,0
;                mov cx,8

;        flag:   mov ax,ds:[bx]
;                mov ds:[bx+16],ax
;                add bx,2
;                loop flag

;                mov ax,4C00H
;                int 21H
;code ends

;end start




;练习4      ->栈+双loop
                ;将data段中的每一个单词都改写为大写字母
;data segment
            ;0123456789ABCDEF   
;        db  'ibm             '              ;IBM
;        db  'dec             '
;        db  'dos             '
;        db  'vax             '    
;data ends

;stack segment stack
;        dw 15 dup(?)
;    btm dw ?
;stack ends

;code segment
;         start: mov ax,data
;                mov ds,ax
;                mov ax,stack
;                mov ss,ax
;                mov sp,offset btm
;                add sp,2

;                mov cx,4
;                mov bx,0
;         upRow: push cx
;                mov cx,3
;                mov si,0
                
;      upLetter: and byte ptr ds:[bx+si],11011111B
;                inc si
;                loop upLetter
                
;                add bx,16
;                pop cx
;                loop upRow


 ;               mov ax,4C00H
 ;               int 21H
;code ends
;end start


;练习5
;assume cs:code,ds:data,ss:stack

;data segment
;    db  'DEC'               ;公司名
;    db  'Ken Olsen'         ;总裁名
;    dw  137                 ;排名       -> 修改为38             ;12
;    dw  40                  ;收入       -> 增加70               ;14
;    db  'PDP'               ;著名产品   -> 修改为'VAX'          ;16
;data ends

;stack segment stack
;        dw 15 dup(?)
;    btm dw ?
;stack ends

;code segment
;        start:  mov ax,data
;                mov ds,ax
;                mov ax,stack
;                mov ss,ax
;                mov sp,offset btm
;                add sp,2

;                mov si,12
;                mov word ptr ds:[si],38
;                add word ptr ds:[si+2],70
;                mov byte ptr ds:[si+4],'V'
;                mov byte ptr ds:[si+5],'A'
;                mov byte ptr ds:[si+6],'X'


;                mov ax,4C00H
;                int 21H
;code ends
;end start



;练习6 针对除法操作进行学习
;assume cs:code,ds:data,ss:stack             

;数据段
;data segment

;data ends

;堆栈段
;stack segment stack
;        dw 15 dup(?)
;    btm dw ? 
;stack ends

;代码段
;code segment
;        start:  mov ax,data
;                mov ds,ax
;                mov ax,stack
;                mov ss,ax
;                mov sp,offset btm
;                add sp,2

;                mov ax,16
;                mov bl,3
;                div bl

;                mov ax,4C00H
;                int 21H
;code ends
;end start



;练习7
;利用除法指令计算 100001 / 100
;利用除法指令计算 1001 / 100


assume cs:code,ds:data,ss:stack            

;数据段
data segment

data ends

;堆栈段
stack segment stack
        dw 15 dup(?)
    btm dw ? 
stack ends

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






















