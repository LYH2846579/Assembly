assume cs:code,ds:data,ss:stack             ;����̻����ܹ�

;���ݶ�
data segment
        db '000000010000000'
        db '000000111000000'
        db '000001111100000'                           ;˼·���Ƚ����������ݶ�д���������������û���������д������
        db '000011111110000'
        db '000111111111000'
        db '000001111100000'
        db '000011111110000'                            ;2021-10-23 09:11
        db '000111111111000'                            ;�����ʵ��
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

                ;��ʾ����ǰ���ַ�
                lea dx,INPUT1
                mov ah,09H
                int 21h

                ;��ȡǰ���ַ�
                mov ah,01h
                int 21h
                mov bl,al               ;����bx�ĵͰ�λ                 ǰ���ַ� -> bl

                ;����
                lea dx,crlf
                mov ah,09H
                int 21H

                ;��ʾ������ַ�
                lea dx,INPUT2
                mov ah,09H
                int 21h

                ;��ȡ���ַ�
                mov ah,01h
                int 21h
                mov bh,al               ;����bx�ĸ߰�λ                 ���ַ� -> bh

                ;����
                lea dx,crlf
                mov ah,09H
                int 21H

                mov cx,0E1H               ;ѭ�����

                ;����ַ�
                mov si,0
       begin:   mov al,ds:[si]  
                sub al,30H                              ;һ��ע��0��ASCII��ֵΪ30!
                jz  replace0
                mov ds:[si],bh          ;���ַ��滻
                jmp continue
    replace0:   mov ds:[si],bl          ;ǰ���ַ��滻
    continue:   inc si
                loop begin


                ;�滻���֮�󣬽��ַ��������
                mov cx,15               ;����15��ѭ��
                mov si,0

        flag1:  push cx
                mov cx,15
        flag:   mov dl,ds:[si]
                mov ah,02H
                int 21H
                inc si                  ;ǧ��Ҫ����si������!
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