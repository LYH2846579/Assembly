assume cs:code

code segment		

;第一个练习	
		;将0123456789ABCDEF存储在2000:1000开始的内存地址之中
;		mov ax,2000H	
;		mov ds,ax
;		mov bx,1000H

;		mov dl,0
		

;setnumber:	mov ds:[bx],dl
;		inc bx
;		inc dl
;		jmp setnumber

		;使用loop指令对以上功能进行实现
;		mov cx,10H
;flag:		mov ds:[bx],dl
;		inc bx
;		inc dl
;		loop flag
	
;第二个练习
		;用编程进行加法计算123*236,并将结果存放在AX
;		mov cx,123
;		mov ax,0
;		mov bx,236
;flag:		add ax,bx
;		loop flag


;第三个练习
		;用编程求FFFF:0到FFFF:F字节型数据的和，并将结果存储在DX中	->字节型数据！
;		mov dl,0
;		mov cx,10H
;		mov ax,0FFFFH		;一定一定注意※
;		mov ds,ax
;		mov bx,0
;		mov ah,0		;处理溢出 -> 使用两个16位寄存器相加
;flag:		mov al,ds:[bx]		;考虑是否存在溢出的情况？	->确实！
;		add dx,ax
;		inc bx
;		loop flag


;第四个练习
		;将内存FFFF:0~FFFF:F内存单元中的内容复制到0:200~0:20F中	->这里使用堆栈ss和sp指针进行实现
;		mov cx,10H
;		mov ax,0
;		mov ss,ax			;注意入栈的顺序问题
;		mov sp,0210H			;一定看好范围，否则访问内存时可能出现严重的错误【非法访问内存】
;		mov ax,0FFFFH
;		mov ds,ax
;		mov bx,000EH			;一定注意开始的位置！将bx指向的字节与bx+1指向的字节入栈，将sp-2,bx+1进入sp+1,bx进入sp
;flag:		push ds:[bx]			;栈操作指令每次操作的数据均为字型数据!
;		dec bx
;		dec bx
;		loop flag			;注意，这里面会将堆栈指针进行修改，有没有更好的方式？ -> 使用es附加段寄存器


;第四个练习的拓展:使用es寄存器
		
;		mov cx,10H
;		mov ax,0FFFFH
;		mov ds,ax
;		mov ax,0020H			;如此一来使用一个ds即可实现对两个数据段数据的操作
;		mov es,ax
;		mov bx,0
		
		;mov byte ptr es:[bx],ds:[bx]		;是否需要表示长度?注意，不可以两个操作数都位于内存中!!!    ※

;flag:		mov dl,ds:[bx]			;木得问题！！
;		mov es:[bx],dl
;		inc bx
;		loop flag


;第四个练习的改进版
;		mov ax,0FFFFH
;		mov ds,ax
;		mov ax,0020H
;		mov es,ax
;		mov cx,8
;		mov bx,0
;flag:		push ds:[bx]
;		pop es:[bx]
;		add bx,2
;		loop flag



;第五个练习					;字节型数据
		;向内存0:200~0:23F依次传送数据0~63(3FH),要求程序中只能使用9条命令包括mov ax,4C00H 和 int 21H
;		mov ax,20H
;		mov ds,ax
;		mov bx,0
;		mov cx,64
;flag:		mov ds:[bx],bx
;		inc bx
;		loop flag



;第六个练习
		;将"mov ax,4C00H"之前的指令复制到内存0:200处 -> 一个不太好的例子
;/*
;assume cs:code

;code segment
;		mov ax,_____
;		mov ds,ax
;		mov ax,20H
;		mov es,ax
;		mov bx,0
;		mov cx,_____
;s:		mov al,ds:[bx]
;		mov es:[bx],al
;		inc bx
;		loop s
;		
;		mov ax,4c00H
;		int 21H
;
;code ends
;end
;*/




;第七个练习
		;编程计算下面8个字型数据，将结果存储在AX中
		;0,1,2,3,4,5,6,7,8
		;首先在指令之前定义数据项 -> 使用start:标识指令开始的位置
;		dw 1,2,3,4,5,6,7,8

;start:		mov bx,0
;		mov ax,0
;		mov cx,8
;addnumber:	add ax,cs:[bx]
;		add bx,2
;		loop addnumber
;		
;		mov ax,4C00H
;		int 21H
;
;code ends
;
;end start



;第八个练习
		;完成下列程序，利用 栈 将程序中定义的数据逆序存放
		
;		dw 0123H,0456H,0789H,0ABCH,0DEFH,0FEDH,0CBAH,0987H
;直接调用系统栈可能存在内存非法访问的情况，这里进行自定义栈优化处理	-> 存在问题！
;	start:	mov cx,8
;		mov bx,000EH
;	p1:	push cs:[bx]
;		sub bx,2
;		loop p1
;		mov cx,8
;		mov bx,0
;	p2:	pop cs:[bx]
;		add bx,2
;		loop p2



;第八个练习的改进版
;		dw 0123H,0456H,0789H,0ABCH,0DEFH,0FEDH,0CBAH,0987H

;		dw 0,0,0,0,0,0,0,0	;这16个字，32个字节作为自己安排的栈空间使用
;		dw 0,0,0,0,0,0,0,0

;	start:  mov ax,cs
;		mov ss,ax
;		mov sp,48

;		mov bx,0
;		mov cx,8

;	flag1:	push cs:[bx]
;		add bx,2
;		loop flag1

		;接下来将栈中内容弹出
;		mov bx,0
;		mov cx,8

;	flag2:	pop cs:[bx]
;		add bx,2
;		loop flag2




;第九个练习
		;下面的程序依次实现用内存0:0~0:15单元中的内容改写程序中的数据，完成程序
;		dw 0123H,0456H,0789H,0ABCH,0DEFH,0FEDH,0CBAH,0987H

;	start:	mov ax,0
;		mov ds,ax
;		mov bx,0

;		mov cx,8

;	s:	mov ax,ds:[bx]
;		mov cs:[bx],ax
;		add bx,2
;		loop s
	
		;注意，使用debug进行调试的过程中发现在程序执行的过程之中，0:0~0:15段内存中的数据会发生改变！


;第九个练习的另一种方式
		dw 0123H,0456H,0789H,0ABCH,0DEFH,0FEDH,0CBAH,0987H
		;定义堆栈
		dw 7 dup(?)
	btm	dw ?		;加上btn一共8个字空间！
		
		;还真得把ss的指向进行修改
	start:	mov ax,cs
		mov ss,ax
		mov sp,offset btm	;注意空间大小
		mov ax,0
		mov ds,ax
		mov bx,0

		mov cx,8

	s:	push ds:[bx]
		pop cs:[bx]		;由于在整个操作的过程之中会使得栈内数据改变，因此需要弹栈
		add bx,2
		loop s
		
		


		mov ax,4C00H
		int 21H
code ends
end start



