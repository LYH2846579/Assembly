assume cs:code,ds:data,ss:stack             ;����̻����ܹ�

;���ݶ�                             ;��һ�ַ�ʽ�������ݶν�����д��+Ӳѭ��
data segment
  buf   db  '*********#',0dh,0ah,'$'
  buf1  db  '********##',0dh,0ah,'$'
  buf2  db  '*******###',0dh,0ah,'$'
  buf3  db  '******####',0dh,0ah,'$'
  buf4  db  '*****#####',0dh,0ah,'$'
  buf5  db  '****######',0dh,0ah,'$'
  buf6  db  '***#######',0dh,0ah,'$'
  buf7  db  '**########',0dh,0ah,'$'
  buf8  db  '*#########',0dh,0ah,'$'
  ;crlf  db  0dh,0ah,'$'
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

                ;mov cx,0
                mov dx,offset buf
                mov ah,09H
                int 21H
                add dx,13

                mov dx,offset buf1
                mov ah,09H
                int 21H
                add dx,13

                mov dx,offset buf2
                mov ah,09H
                int 21H
                add dx,13


                mov dx,offset buf3
                mov ah,09H
                int 21H
                add dx,13

                mov dx,offset buf4
                mov ah,09H
                int 21H
                add dx,13

                mov dx,offset buf5
                mov ah,09H
                int 21H
                add dx,13

                mov dx,offset buf6
                mov ah,09H
                int 21H
                add dx,13

                mov dx,offset buf7
                mov ah,09H
                int 21H
                add dx,13

                mov dx,offset buf8
                mov ah,09H
                int 21H
                add dx,13
                


                mov ax,4C00H
                int 21H
code ends
end start