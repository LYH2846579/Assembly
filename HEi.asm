DATA    SEGMENT
        pkey   DB  0DH,0AH, 'please input str1 end by enter:','$'
        qkey   DB  0DH,0AH,'please input str2 end by enter:','$'
        skey   DB  0DH,0AH,'MATCH','$'
        tkey   DB  0DH,0AH,'NO MATCH','$' 
        BUFF1  DB  101,0,101 DUP(0)
        BUFF2  DB  101,0,101 DUP(0)
DATA    ENDS

CODE    SEGMENT
        ASSUME  CS:CODE,DS:DATA 
        
START:  MOV AX,DATA
        MOV DS,AX
        MOV ES,AX          ;数据段和堆栈段初始化
              
        LEA DX,pkey             
        MOV AH,9
        INT 21H               ;DOS功能调用，输出字符串
        LEA DX,BUFF1
        MOV AH,0AH
        INT 21H               ;输入第一个字符串到BUFF1缓冲区
        
        LEA DX,qkey
        MOV AH,9
        INT 21H
        LEA DX,BUFF2
        MOV AH,0AH
        INT 21H               ;输入第二个字符串到BUFF2缓冲区
   
        LEA SI,BUFF1          ;将第一个字符串给SI
        LEA DI,BUFF2          ;将第二个字符串给DI
        MOV CX,53            ;给计数器值
        CLD                  ;清方向标准DF
        REPZ CMPSB        ;一个字节一个字节比较字符串，SI和DI递增
        JZ MATCH             ;全部字节都相等输出MATCH
        LEA DX,tkey
        MOV AH,9
        INT 21H               ;不等输出NO MATCH
        JMP START 
        
MATCH:  LEA DX,skey
        MOV AH,9
        INT 21H               ;DOS功能调用，输出MATCH
        JMP START

CODE    ENDS
END     START