;assume cs:code,ds:data,ss:stack             ;����̻����ܹ�

;���ݶ�
;data segment

data ends

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








assume cs:code,ds:data,ss:stack             ;����̻����ܹ�

;���ݶ�
data segment

data ends

;��ջ��
stack segment stack
        dw 15 dup(?)
    btm dw ? 
stack ends
                                ;my little house must think it queer, to stop without a far house near.
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