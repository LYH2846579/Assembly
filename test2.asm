;��ϰ1��һʹ�ù淶�ֶΣ����ó�ʼֵ����ϰ				->���ļ�Ϊ�˶Դ����ܽ��ж����ϰ��ÿ����ϰ����Ҫд���Լ��Ŀ�ܣ�
;assume cs:code,ds:data,ss:stack

;data segment
;	dw 0123H,0456H,0789H,0ABCH,0DEFH,0FEDH,0CBAH,0987H
;data ends

;stack segment stack
;	dw 7 dup(?)
;btn	dw ?
;stack ends

;code segment
		;���ø������ݶ�
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



;��ϰ2��ʵ����ĸ�Ĵ�Сдת��
;assume cs:code,ds:data,ss:stack

;data segment
;	db 'Basic'			;����һ���ַ���ת��Ϊ��д
;	db 'iNfOrnMaTiOn'		;���ڶ����ַ���ת��ΪСд
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

		;���������ڶ����ַ���ת��ΪСд
;		mov cx,12				;һ��ע��ѭ��������д��λ��
;    lowLetter:	mov al,ds:[bx]
;		or  al,00100000B
;		mov ds:[bx],al
;		inc bx
;		loop lowLetter

;		mov ax,4C00H
;		int 21H
;code ends
;end start




;��ϰ2��ǿ��		-> һ�ν�������ĸ���б仯
;assume cs:code,ds:data,ss:stack

;data segment
;	db 'Basic'		;�����ַ�����дΪȫСд
;	db 'MinIx'		;�����ַ�����дΪȫ��д
;data ends

;stack segment stack
;	dw 15 dup(?)
;btm	dw ?
;stack ends

;code segment	;��ʼ��
;	start:	mov ax,stack
;		mov ss,ax
;		mov sp,offset btm
;		add sp,2		;����debug�еĽ�����Ƿ���Ҫ��spָ���޸�?	-> ȷʵ��Ҫ�޸�!��������ڴ�й¶����

;		mov ax,data
;		mov ds,ax

		;��ʼ��д
;		mov bx,0
;		mov cx,5

;	flag:	or  byte ptr ds:[bx],00100000B			;ʹ��������ֱ�Ӷ��ڴ浥Ԫ����!!!!!!!!!!!!!��
;		and byte ptr ds:[bx+5],11011111B		;����ɹ�!!!!!!!!!!!!!��
;		inc bx
;		loop flag
		

;		mov ax,4C00H
;		int 21H
;code ends

;end start



;��ϰ3
		;��si��diʵ�ֽ��ַ���'welcome to mams!'�ĸ���
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




;��ϰ4      ->ջ+˫loop
                ;��data���е�ÿһ�����ʶ���дΪ��д��ĸ
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


;��ϰ5
;assume cs:code,ds:data,ss:stack

;data segment
;    db  'DEC'               ;��˾��
;    db  'Ken Olsen'         ;�ܲ���
;    dw  137                 ;����       -> �޸�Ϊ38             ;12
;    dw  40                  ;����       -> ����70               ;14
;    db  'PDP'               ;������Ʒ   -> �޸�Ϊ'VAX'          ;16
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



;��ϰ6 ��Գ�����������ѧϰ
;assume cs:code,ds:data,ss:stack             

;���ݶ�
;data segment

;data ends

;��ջ��
;stack segment stack
;        dw 15 dup(?)
;    btm dw ? 
;stack ends

;�����
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



;��ϰ7
;���ó���ָ����� 100001 / 100
;���ó���ָ����� 1001 / 100


assume cs:code,ds:data,ss:stack            

;���ݶ�
data segment

data ends

;��ջ��
stack segment stack
        dw 15 dup(?)
    btm dw ? 
stack ends

;�����
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






















