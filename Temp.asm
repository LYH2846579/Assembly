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