;һЩ���������η���ʽ�ܹ�����ϰ��Ŀ

;��ϰһ			;��дcode�δ��룬��a��b���е�����������ӣ�������洢��c����
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
		;�Ϲ�أ����ó�ʼ��
;	start:	mov ax,c
;		mov es,ax
		
;		mov bx,0
;		mov cx,8
		
;	flag:	mov ax,a
;		mov ds,ax

;		mov dl,ds:[bx]
		;�޸����ݶ�
;		mov ax,b
;		mov ds,ax

;		add dl,ds:[bx]
		;����������
;		mov es:[bx],dl
;		inc bx
;		loop flag



;�ڶ�����ϰ
		;�������£���дcode�еĴ��룬��Pushָ�a����ǰ8���������ݣ������Ƶ�b����
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




;��������ϰ
		;ʹ��si��di�����ķô淽ʽ
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



;���ĸ���ϰ
		;��and��orָ���ʹ����ϰ
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


;�������ϰ
        ;д���������ִ��֮��ax,bx,cx�е�����
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


assume cs:code,ds:data,ss:stack             ;����̻����ܹ�

;���ݶ�
data segment
    INPUT  db 'Please input a string:','$'
    maxlen db ?             ;������󳤶�
    actlen db ?             ;����ʵ�ʳ���
    crlf   db 0dh,0ah,'$'   ;����س�+����
    lfLen  db ?             ;��Ҫ���Ŀո�ĳ���
    stbuf  db 512 dup(?)    ;��ʼ���ݴ洢�ĵط�
    delbuf db 1024 dup(?)   ;����֮������ݴ洢�ĵط�
data ends

;��ջ��
stack segment stack
        dw 15 dup(?)
    btm dw ? 
stack ends

;�����
code segment    ;һЩԤ����
        start:  mov ax,data
                mov ds,ax
                mov ax,stack
                mov ss,ax
                mov sp,offset btm
                add sp,2

                ;���ַ����洢��Ԥ����
                lea si,stbuf            ;���ȴ洢����
                lea di,delbuf

                ;�����ʾ��Ϣ
                lea dx,INPUT
                mov ah,09h
                int 21H

                ;��ȡ�ַ���
                lea dx,stbuf
                mov ah,0AH
                int 21H

                ;���ַ������д���
                mov al,stbuf+1
                add al,2
                mov ah,0
                mov di,ax
                mov stbuf[di],'$'

                ;ָ�����������
                lea dx,stbuf+2

                ;��ʾ�ַ���
                mov ah,09h
                int 21H

                mov ax,4C00H
                int 21H
code ends
end start

