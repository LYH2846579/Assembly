assume cs:code

code segment		

;��һ����ϰ	
		;��0123456789ABCDEF�洢��2000:1000��ʼ���ڴ��ַ֮��
;		mov ax,2000H	
;		mov ds,ax
;		mov bx,1000H

;		mov dl,0
		

;setnumber:	mov ds:[bx],dl
;		inc bx
;		inc dl
;		jmp setnumber

		;ʹ��loopָ������Ϲ��ܽ���ʵ��
;		mov cx,10H
;flag:		mov ds:[bx],dl
;		inc bx
;		inc dl
;		loop flag
	
;�ڶ�����ϰ
		;�ñ�̽��мӷ�����123*236,������������AX
;		mov cx,123
;		mov ax,0
;		mov bx,236
;flag:		add ax,bx
;		loop flag


;��������ϰ
		;�ñ����FFFF:0��FFFF:F�ֽ������ݵĺͣ���������洢��DX��	->�ֽ������ݣ�
;		mov dl,0
;		mov cx,10H
;		mov ax,0FFFFH		;һ��һ��ע���
;		mov ds,ax
;		mov bx,0
;		mov ah,0		;������� -> ʹ������16λ�Ĵ������
;flag:		mov al,ds:[bx]		;�����Ƿ��������������	->ȷʵ��
;		add dx,ax
;		inc bx
;		loop flag


;���ĸ���ϰ
		;���ڴ�FFFF:0~FFFF:F�ڴ浥Ԫ�е����ݸ��Ƶ�0:200~0:20F��	->����ʹ�ö�ջss��spָ�����ʵ��
;		mov cx,10H
;		mov ax,0
;		mov ss,ax			;ע����ջ��˳������
;		mov sp,0210H			;һ�����÷�Χ����������ڴ�ʱ���ܳ������صĴ��󡾷Ƿ������ڴ桿
;		mov ax,0FFFFH
;		mov ds,ax
;		mov bx,000EH			;һ��ע�⿪ʼ��λ�ã���bxָ����ֽ���bx+1ָ����ֽ���ջ����sp-2,bx+1����sp+1,bx����sp
;flag:		push ds:[bx]			;ջ����ָ��ÿ�β��������ݾ�Ϊ��������!
;		dec bx
;		dec bx
;		loop flag			;ע�⣬������Ὣ��ջָ������޸ģ���û�и��õķ�ʽ�� -> ʹ��es���ӶμĴ���


;���ĸ���ϰ����չ:ʹ��es�Ĵ���
		
;		mov cx,10H
;		mov ax,0FFFFH
;		mov ds,ax
;		mov ax,0020H			;���һ��ʹ��һ��ds����ʵ�ֶ��������ݶ����ݵĲ���
;		mov es,ax
;		mov bx,0
		
		;mov byte ptr es:[bx],ds:[bx]		;�Ƿ���Ҫ��ʾ����?ע�⣬������������������λ���ڴ���!!!    ��

;flag:		mov dl,ds:[bx]			;ľ�����⣡��
;		mov es:[bx],dl
;		inc bx
;		loop flag


;���ĸ���ϰ�ĸĽ���
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



;�������ϰ					;�ֽ�������
		;���ڴ�0:200~0:23F���δ�������0~63(3FH),Ҫ�������ֻ��ʹ��9���������mov ax,4C00H �� int 21H
;		mov ax,20H
;		mov ds,ax
;		mov bx,0
;		mov cx,64
;flag:		mov ds:[bx],bx
;		inc bx
;		loop flag



;��������ϰ
		;��"mov ax,4C00H"֮ǰ��ָ��Ƶ��ڴ�0:200�� -> һ����̫�õ�����
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




;���߸���ϰ
		;��̼�������8���������ݣ�������洢��AX��
		;0,1,2,3,4,5,6,7,8
		;������ָ��֮ǰ���������� -> ʹ��start:��ʶָ�ʼ��λ��
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



;�ڰ˸���ϰ
		;������г������� ջ �������ж��������������
		
;		dw 0123H,0456H,0789H,0ABCH,0DEFH,0FEDH,0CBAH,0987H
;ֱ�ӵ���ϵͳջ���ܴ����ڴ�Ƿ����ʵ��������������Զ���ջ�Ż�����	-> �������⣡
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



;�ڰ˸���ϰ�ĸĽ���
;		dw 0123H,0456H,0789H,0ABCH,0DEFH,0FEDH,0CBAH,0987H

;		dw 0,0,0,0,0,0,0,0	;��16���֣�32���ֽ���Ϊ�Լ����ŵ�ջ�ռ�ʹ��
;		dw 0,0,0,0,0,0,0,0

;	start:  mov ax,cs
;		mov ss,ax
;		mov sp,48

;		mov bx,0
;		mov cx,8

;	flag1:	push cs:[bx]
;		add bx,2
;		loop flag1

		;��������ջ�����ݵ���
;		mov bx,0
;		mov cx,8

;	flag2:	pop cs:[bx]
;		add bx,2
;		loop flag2




;�ھŸ���ϰ
		;����ĳ�������ʵ�����ڴ�0:0~0:15��Ԫ�е����ݸ�д�����е����ݣ���ɳ���
;		dw 0123H,0456H,0789H,0ABCH,0DEFH,0FEDH,0CBAH,0987H

;	start:	mov ax,0
;		mov ds,ax
;		mov bx,0

;		mov cx,8

;	s:	mov ax,ds:[bx]
;		mov cs:[bx],ax
;		add bx,2
;		loop s
	
		;ע�⣬ʹ��debug���е��ԵĹ����з����ڳ���ִ�еĹ���֮�У�0:0~0:15���ڴ��е����ݻᷢ���ı䣡


;�ھŸ���ϰ����һ�ַ�ʽ
		dw 0123H,0456H,0789H,0ABCH,0DEFH,0FEDH,0CBAH,0987H
		;�����ջ
		dw 7 dup(?)
	btm	dw ?		;����btnһ��8���ֿռ䣡
		
		;����ð�ss��ָ������޸�
	start:	mov ax,cs
		mov ss,ax
		mov sp,offset btm	;ע��ռ��С
		mov ax,0
		mov ds,ax
		mov bx,0

		mov cx,8

	s:	push ds:[bx]
		pop cs:[bx]		;���������������Ĺ���֮�л�ʹ��ջ�����ݸı䣬�����Ҫ��ջ
		add bx,2
		loop s
		
		


		mov ax,4C00H
		int 21H
code ends
end start



