;assume cs:code,ds:data,ss:stack             ;����̻����ܹ�

;���ݶ�
;data segment

;data ends

;��ջ��
;stack segment stack
;        dw 15 dup(?)
;    btm dw ? 
;stack ends
                            ;���³��򣬿���������ֹ��?      
;�����
;code segment
;                mov ax,4C00H
;                int 21H

;        start:  mov ax,0                            ;���ȶԳ�����з���
;            s:  nop                                 ;movָ��Ὣs2��jmp short s1ָ��Ƶ�s��      
;                nop                                 ;ע�⣬��ʱ��ָ�������ΪEBF6    -> �����jmpָ���ǰ��ת10�ֽ�
                                                    ;һ��Ҫ�ر�ע��jmpָ����������ת��ʽ!
;                mov di,offset s
;                mov si,offset s2
;                mov ax,cs:[si]
;                mov cs:[di],ax

;            s0: jmp short s

;            s1: mov ax,0                            ;int 21H�жϵ�0�Ź�����ɶ?  -> ����һ��
;                int 21H
;                mov ax,0

;            s2: jmp short s1
;                nop

;code ends
;end start






;��ϰ2  -> jcxzָ����ϰ

;assume cs:code,ds:data,ss:stack             ;����̻����ܹ�

;���ݶ�
;data segment

;data ends

;��ջ��
;stack segment stack
;        dw 15 dup(?)
;    btm dw ? 
;stack ends
                                ;my little house must think it queer, to stop without a far house near.
;�����
;code segment    ;��s����ȫ��������jcxzָ�ʵ�����ڴ�2000H���в��ҵ���һ��Ϊ0���ֽڣ��ҵ�������ƫ�Ƶ�ַ�洢��dx��
;        start:  mov ax,2000H        ;�� -> һ��ע��2000 != 2000H
;                mov ds,ax
;                mov bx,0

;            s:  ;sub cx,cx       ;���cx
;                ;mov cl,ds:[bx]
;                ;jcxz ok
;                ;inc bx


;                jmp short s

;           ok:  mov dx,bx
                     

;                mov ax,4C00H
;                int 21H
;code ends
;end start



;��ϰ3 loopָ����ϰ

    ;��s����ȫ��������jcxzָ�ʵ�����ڴ�2000H���в��ҵ���һ��Ϊ0���ֽڣ��ҵ�������ƫ�Ƶ�ַ�洢��dx��
;assume cs:code,ds:data,ss:stack             ;����̻����ܹ�

;���ݶ�
;data segment

;data ends

;��ջ��
;stack segment stack
;        dw 15 dup(?)
;    btm dw ? 
;stack ends
                                ;my little house must think it queer, to stop without a far house near.
;�����
;code segment
;        start:  mov ax,2000H
;                mov ds,ax
;                mov bx,0

;            s:  mov cl,ds:[bx]
;                mov ch,0
;                ;inc cx         ;��loopָ�����������!
;                inc bx
;                loop s

;           ok:  dec bx 

;                mov ax,4C00H
;                int 21H
;code ends
;end start





;��ϰ4 �ṹ����ַ����ʽ   -> ������һ������if������ʽ����

;assume cs:code,ds:data,ss:stack             ;����̻����ܹ�

;���ݶ�
;data segment
;        db 100 dup(?)
;data ends

;��ջ��
;stack segment stack
;        dw 15 dup(?)
;    btm dw ? 
;stack ends
                                ;my little house must think it queer, to stop without a far house near.
;�����
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

                ;�޸�CS:IP������ת
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




;��ϰ5 callָ����ϰ
;assume cs:code,ds:data,ss:stack             ;����̻����ܹ�

;���ݶ�
;data segment
;        dw 0,0,0,0
;        dw 0,0,0,0
;data ends

;��ջ��
;stack segment stack
;        dw 0,0,0,0
;        dw 0,0,0,0
;stack ends
                                ;my little house must think it queer, to stop without a far house near.
;�����
;code segment
;        start:  mov ax,stack
;                mov ss,ax
;                mov sp,16

;                mov ds,ax
;                mov ax,0

;                call word ptr ds:[0EH]      ;��������ջ�У�������debug��ʱ���п��ܴ�����һЩ����

;                inc ax
;                inc ax
;                inc ax 

;                mov ax,4C00H
;                int 21H
;code ends
;end start



;��ϰ6 callָ��ʵ������switch�Ľṹ

;assume cs:code,ds:data,ss:stack             ;����̻����ܹ�

;���ݶ�
;data segment
;        dw 100 dup(?)
;data ends

;��ջ��
;stack segment stack
;        dw 15 dup(?)
;    btm dw ? 
;stack ends
                                ;my little house must think it queer, to stop without a far house near.
;�����
;code segment
;        start:  mov ax,data
;                mov ds,ax
;                mov ax,stack
;                mov ss,ax
;                mov sp,offset btm
;                add sp,2

;                mov ax,offset s1        ;��S1��ַд���ڴ�
;                mov ds:[0],ax

;                mov ax,offset s2
;                mov ds:[2],ax

;                mov ax,offset s3
;                mov ds:[4],ax


                ;ѡ�������ת��һ��ָ��
;                mov bx,2

;                mov cx,0
;                jcxz M1002                  ;����֤����תָ������޷�ֱ�Ӹ���callָ�� -> ������תָ��������޸�cs:ip,��ִ��ָ��ƨ��
;        M1002:  call word ptr ds:[bx]                

;                mov ax,4C00H
;                int 21H

;           s1:  mov ax,1000H
;                ret
;           s2:  mov ax,1002H
;                ret
;           s3:  mov ax,1003H
;                ret     
;code ends
;end start



;��ϰ7 -> ���һ�����򣬽������β���ַ����������Ļ��
;      -> ��������ÿһ��������֮�󣬻������


assume cs:code,ds:data,ss:stack             ;����̻����ܹ�

;���ݶ�
data segment            ;0123456789ABCDEF
                db      '1) restart pc   ',0
                db      '2) start system ',0            ;ʹ��jcxz�ж�
                db      '3) show clock   ',0
                db      '4) set clock    ',0
        crlf:   db      0dh,0ah,'$'   
data ends

;��ջ��
stack segment stack
        dw 15 dup(?)
    btm dw ? 
stack ends
                                ;my little house must think it queer, to stop without a far house near.
;�����
code segment
        start:  mov ax,stack
                mov ss,ax
                mov sp,offset btm
                add sp,2

                call init_reg               ;���ó�ʼ���Ĵ�������

                mov si,0
                mov di,160*10 + 30*2        ;��Ļ��ʾ��ֵ��

                mov cx,4

        begin:  push cx                     ;������ʹ��jcxz�жϣ��ὫCXֵ�޸ģ��������ջ
                call show_string
                ;call printCRLF             ;int 21H    �жϲ��ʺ��ڶ�̬��ʾ��ʹ��
                
                add  si,1                   ;�����е��ж����������ǳ���Ҫ!!!   
                add  di,160-16*2            ;��Ҫ���ݺ����ж�si,di�Ĳ������ж����������ۺϷ���
                
                pop  cx
                loop begin


                mov ax,4C00H
                int 21H
;===================================================================
     init_reg:  mov ax,data     ;1����ʼ���Ĵ���
                mov ds,ax
                mov ax,0B800H
                mov es,ax
                ret
;===================================================================
  show_string:  mov cx,0        ;2����ʾ�ַ���
                mov cl,ds:[si]
                jcxz showStringRet
                mov es:[di],cl
                mov es:[di+1],2     ;�����������ĸ���ɫ
                add di,2
                inc si
                loop show_string
;===================================================================
showStringRet:  ret
;==================================================================
    printCRLF:  lea dx,offset crlf
                mov ah,09H
                int 21H
                ret


code ends
end start