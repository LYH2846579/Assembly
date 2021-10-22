assume cs:code,ds:data,ss:stack             ;����̻����ܹ�

;���ݶ�
data segment
    INPUT  db 'Please input a string:','$'
    maxlen dw 0                    ;������󳤶�
    actlen dw 0                    ;����ʵ�ʳ���
    crlf   db 0dh,0ah,'$'          ;����س�+����
    lfLen  db ?                    ;��Ҫ���Ŀո�ĳ���
    stbuf  db 101,0,101 DUP(0)     ;��ʼ���ݴ洢�ĵط�
    delbuf db 101,0,101 DUP(0)     ;����֮������ݴ洢�ĵط�
    USD    db '$'
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
                mov ah,0AH
                lea dx,stbuf
                int 21H

                ;����������ַ���
                mov al,stbuf+1
                add al,2
                mov ah,0
                mov si,ax
                mov stbuf[si],"$"

                ;��ʱ�Ѿ���������ַ���������stbuf��
                ;1.��stbuf�д洢���ַ�������ɨ��
                mov cx,3
                lea si,stbuf
                add si,2            ;��Ҫ��ָ�������λ    
                
                ;Ϊcmpָ���ֵ
                mov ax,data
                mov es,ax
                lea di,USD
                
                ;��ƥ�䵽$���ŵ�ʱ�������ת
        judge:  cmp byte ptr ds:[si],'$'
                je deal
                cmp byte ptr ds:[si],','    ;�����ַ�Ϊ,�жϵ�ǰͳ�Ƶ���Ч���ȣ���ʹ֮����󳤶Ƚ��бȽ�
                je compare
                cmp byte ptr ds:[si],'.'    ;ͬ��
                je compare
                cmp byte ptr ds:[si],'!'    ;ͬ��
                je compare
                cmp byte ptr ds:[si],'?'    ;ͬ��
                je compare
                ;��ʱ�Ƚ�ʡ�Ժ��ų�����,�����Ͼ�δ��תʱ,
                add word ptr ds:[25],1          ;�������actlen��+1
                inc si
                jmp judge

      compare:  sub ax,ax       ;��ax��bx�Ĵ������     �����maxlen��actlen�����޸�
                sub bx,bx
                lea ax,actlen
                lea bx,maxlen
                ;��ʱ��Ҫ��siָ��+1
                inc si          ;ָ���ս���ŵ���һλ
                cmp ax,bx
                ja  setMax
                jmp judge
        
                ;�޸����ֵ
       setMax:  mov ax,ds:[25]
                ;���޸�maxlen֮��һ����ʼ��actlen -> ��֤��һ��ɨ����ַ���������0��ʼ
                mov word ptr ds:[25],0
                mov ds:[23],ax         ;data�е�23λ��Ϊ���ֵ�洢��
                jmp judge


                ;��������ת���˵ص�ʱ���Ѿ������ֵmaxlen��������
                ;������ַ������г���������
                ;����ʹ��diָ��ָ���ַ����Ŀ�ʼ������������siָ�����ɨ���ַ�����ֱ�������ս����
                ;������ɨ��Ĺ���֮�У�ʹ��actlenͳ����Ч�ַ�����
                ;�������ս���ŵ�ʱ�򣬽�si�ص���diָ��Ŀ�ʼλ�ã�����ͳ�Ƶ���Ч�ַ������������ַ���ǰ����Ҫ��ӵĿո�����
                ;(maxlen - actlen)/2
        deal:   lea si,stbuf        ;��ָ��ָ���ʼλ��
                add si,2            ;�޸�ָ��
                mov di,si           ;��di����ָ��ָ���ʼλ��
                lea bp,delbuf       ;����������֮��Ĵ����뵽delbuf��

                ;��������ʼ���ַ�ɨ��
        deal1:  cmp byte ptr ds:[si],'$'
                je done                     ;��ɨ�赽��ֹ���ŵ�ʱ����ת��done������������ַ���
                cmp byte ptr ds:[si],','    ;����Ϊ�ս����,�����������������
                je strRe
                cmp byte ptr ds:[si],'.'    ;ͬ��
                je strRe
                cmp byte ptr ds:[si],'!'    ;ͬ��
                je strRe
                cmp byte ptr ds:[si],'?'    ;ͬ��
                je strRe
                ;�������������ж�֮��δ������ת�����
                add word ptr ds:[25],1          ;�������actlen��+1
                inc si
                jmp deal1                        ;��������ʼλ��,ע��ǧ��Ҫ��ת��dealλ�ã�


                ;�����ַ�����������
        strRe:  sub ax,ax       ;��ax��bx�Ĵ������     
                sub bx,bx
                mov ax,ds:[25]
                mov bx,ds:[23]
                ;�Ƚ���ʱ��actlen��maxlen��ջ����
                ;push ax
                ;push bx
                ;������������Ҫ������
                sub bx,ax   ;���ｫmaxlen��ֵ��ȥactlen��ֵ -> ������һ����
                mov ax,bx   ;������������ax
                mov bx,2
                div bl      ;����������λ��al,����λ��ah            ->һ��ע�������λ��!!!!!!!!!!!!!!!!!!!!!!!!!!
                ;���������пո�����
                sub cx,cx   ;���Ƚ�ax�Ĵ������
                mov cl,al   ;����ֵ��Ϊ��ӵĿո�����       -> ���ʱ��al��������ֵ����ʱ��Ҫ��ax�Ĵ���
                ;����clΪ�� -> �������ֱ�Ӹ�ֵ
                and cl,1111B
                jz special              ;�������alΪ�㣬����Ϊ0ʱ����Ҫ���⴦��
                jmp add1                ;������Ϊ0����תadd1
      special:  mov cx,ds:[25]       ;����Ч���ȸ�ֵ��cx ->���ֽ�Ϊ��λ         ;��ת֮ǰ���������
                jmp copy
                
        add1:   mov ds:[bp],' '                             ;�ǲ��ǵÿ�����������.�����????????
                inc bp
                loop add1
                ;���������ַ�������
                mov cx,ds:[25]       ;����Ч���ȸ�ֵ��cx ->���ֽ�Ϊ��λ
        copy:   mov bl,ds:[di]
                inc di              ;��ʱʹ��di����ָ����и�ֵ
                mov ds:[bp],bl
                inc bp              ;���Ƶ�bpָ����ڴ浥Ԫ
                loop copy
                ;����������Ҫ�ж�al�Ƿ�Ϊ��
                mov cl,al
                and cl,1111B
                jz  lfd                 ;����Ϊ0��ֱ���������׶�
                ;�������������
                mov cl,al
        add2:   mov ds:[bp],' '
                inc bp
                loop add2

                ;�ڴ��������ϲ���֮��,һ��ʫ���Ѿ����������
                ;��ʱӦ�����һ�����з���!
        lfd:    inc bp
                mov byte ptr ds:[bp],0dh
                inc bp
                mov byte ptr ds:[bp],0ah
                inc bp
                mov byte ptr ds:[bp],'$'
                ;�������޸�siָ��ָ��
                inc si
                mov di,si       ;��diָ����siͬ��
                ;�������޸�actlen!
                mov word ptr ds:[25],0
                jmp deal1       ;��ת�ص�deal1�м��������ַ���


        done:   mov ds:[bp+1],'$'   ;���ַ������ֵ '$'



                

                ;������з�
                lea dx,crlf
                ;add dx,2
                mov ah,09h
                int 21H

                ;ָ�����������
                mov dx,offset delbuf            ;�������������!!!
                ;add dx,2

                ;��ʾ�ַ���
                mov ah,09h
                int 21H

                mov ax,4C00H
                int 21H
code ends
end start