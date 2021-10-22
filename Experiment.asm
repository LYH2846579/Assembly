assume cs:code,ds:data,ss:stack             ;汇编编程基本架构

;数据段
data segment
    INPUT  db 'Please input a string:','$'
    maxlen dw 0                    ;定义最大长度
    actlen dw 0                    ;定义实际长度
    crlf   db 0dh,0ah,'$'          ;定义回车+换行
    lfLen  db ?                    ;需要填充的空格的长度
    stbuf  db 101,0,101 DUP(0)     ;初始数据存储的地方
    delbuf db 101,0,101 DUP(0)     ;处理之后的数据存储的地方
    USD    db '$'
data ends

;堆栈段
stack segment stack
        dw 15 dup(?)
    btm dw ? 
stack ends

;代码段
code segment    ;一些预处理
        start:  mov ax,data
                mov ds,ax
                mov ax,stack
                mov ss,ax
                mov sp,offset btm
                add sp,2

                ;对字符串存储的预处理
                lea si,stbuf            ;首先存储起来
                lea di,delbuf

                ;输出提示信息
                lea dx,INPUT
                mov ah,09h
                int 21H

                ;读取字符串
                mov ah,0AH
                lea dx,stbuf
                int 21H

                ;处理输入的字符串
                mov al,stbuf+1
                add al,2
                mov ah,0
                mov si,ax
                mov stbuf[si],"$"

                ;此时已经将输入的字符串保存在stbuf中
                ;1.对stbuf中存储的字符串进行扫描
                mov cx,3
                lea si,stbuf
                add si,2            ;需要将指针后移两位    
                
                ;为cmp指令赋初值
                mov ax,data
                mov es,ax
                lea di,USD
                
                ;当匹配到$符号的时候进行跳转
        judge:  cmp byte ptr ds:[si],'$'
                je deal
                cmp byte ptr ds:[si],','    ;倘若字符为,判断当前统计的有效长度，并使之与最大长度进行比较
                je compare
                cmp byte ptr ds:[si],'.'    ;同上
                je compare
                cmp byte ptr ds:[si],'!'    ;同上
                je compare
                cmp byte ptr ds:[si],'?'    ;同上
                je compare
                ;此时先将省略号排除在外,当以上均未跳转时,
                add word ptr ds:[25],1          ;必须得在actlen上+1
                inc si
                jmp judge

      compare:  sub ax,ax       ;将ax、bx寄存器清空     这里对maxlen、actlen进行修改
                sub bx,bx
                lea ax,actlen
                lea bx,maxlen
                ;此时需要将si指针+1
                inc si          ;指向终结符号的下一位
                cmp ax,bx
                ja  setMax
                jmp judge
        
                ;修改最大值
       setMax:  mov ax,ds:[25]
                ;在修改maxlen之后，一定初始化actlen -> 保证下一次扫描的字符串长度由0开始
                mov word ptr ds:[25],0
                mov ds:[23],ax         ;data中第23位即为最大值存储地
                jmp judge


                ;当程序跳转到此地的时候，已经将最大值maxlen分析出来
                ;这里对字符串进行长度填充分析
                ;首先使用di指针指向字符串的开始，接下来依靠si指针向后扫描字符串，直到遇到终结符号
                ;在整个扫描的过程之中，使用actlen统计有效字符个数
                ;在遇到终结符号的时候，将si回调至di指向的开始位置，依据统计的有效字符个数计算在字符串前后需要添加的空格数量
                ;(maxlen - actlen)/2
        deal:   lea si,stbuf        ;将指针指向初始位置
                add si,2            ;修改指向
                mov di,si           ;将di辅助指针指向初始位置
                lea bp,delbuf       ;将经过处理之后的串加入到delbuf中

                ;接下来开始逐字符扫描
        deal1:  cmp byte ptr ds:[si],'$'
                je done                     ;当扫描到终止符号的时候，跳转到done，接下来输出字符串
                cmp byte ptr ds:[si],','    ;倘若为终结符号,将进入增量处理程序
                je strRe
                cmp byte ptr ds:[si],'.'    ;同上
                je strRe
                cmp byte ptr ds:[si],'!'    ;同上
                je strRe
                cmp byte ptr ds:[si],'?'    ;同上
                je strRe
                ;倘若经过如上判断之后未出现跳转的情况
                add word ptr ds:[25],1          ;必须得在actlen上+1
                inc si
                jmp deal1                        ;回跳至开始位置,注意千万不要跳转到deal位置！


                ;进入字符串处理序列
        strRe:  sub ax,ax       ;将ax、bx寄存器清空     
                sub bx,bx
                mov ax,ds:[25]
                mov bx,ds:[23]
                ;先将此时的actlen、maxlen入栈保存
                ;push ax
                ;push bx
                ;接下来计算需要的增量
                sub bx,ax   ;这里将maxlen的值减去actlen的值 -> 增量的一部分
                mov ax,bx   ;将被除数送至ax
                mov bx,2
                div bl      ;做除法，商位于al,余数位于ah            ->一定注意除数的位数!!!!!!!!!!!!!!!!!!!!!!!!!!
                ;接下来进行空格增量
                sub cx,cx   ;首先将ax寄存器清空
                mov cl,al   ;将商值作为添加的空格数量       -> 这个时候al保存这商值，暂时不要用ax寄存器
                ;倘若cl为零 -> 无需填充直接赋值
                and cl,1111B
                jz special              ;当计算的al为零，即商为0时，需要特殊处理
                jmp add1                ;倘若不为0，跳转add1
      special:  mov cx,ds:[25]       ;将有效长度赋值给cx ->以字节为单位         ;跳转之前这个不能忘
                jmp copy
                
        add1:   mov ds:[bp],' '                             ;是不是得考虑上来就是.的情况????????
                inc bp
                loop add1
                ;接下来将字符串复制
                mov cx,ds:[25]       ;将有效长度赋值给cx ->以字节为单位
        copy:   mov bl,ds:[di]
                inc di              ;这时使用di辅助指针进行赋值
                mov ds:[bp],bl
                inc bp              ;复制到bp指向的内存单元
                loop copy
                ;接下来还需要判断al是否为零
                mov cl,al
                and cl,1111B
                jz  lfd                 ;倘若为0，直接跳过填充阶段
                ;接下来又是填充
                mov cl,al
        add2:   mov ds:[bp],' '
                inc bp
                loop add2

                ;在处理完如上操作之后,一行诗句已经被处理完毕
                ;此时应当添加一个换行符号!
        lfd:    inc bp
                mov byte ptr ds:[bp],0dh
                inc bp
                mov byte ptr ds:[bp],0ah
                inc bp
                mov byte ptr ds:[bp],'$'
                ;接下来修改si指针指向
                inc si
                mov di,si       ;将di指针与si同步
                ;别忘了修改actlen!
                mov word ptr ds:[25],0
                jmp deal1       ;跳转回到deal1中继续处理字符串


        done:   mov ds:[bp+1],'$'   ;在字符串最后赋值 '$'



                

                ;输出换行符
                lea dx,crlf
                ;add dx,2
                mov ah,09h
                int 21H

                ;指向输出的数据
                mov dx,offset delbuf            ;死活不输出正常语句!!!
                ;add dx,2

                ;显示字符串
                mov ah,09h
                int 21H

                mov ax,4C00H
                int 21H
code ends
end start