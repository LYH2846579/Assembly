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
        MOV ES,AX          ;���ݶκͶ�ջ�γ�ʼ��
              
        LEA DX,pkey             
        MOV AH,9
        INT 21H               ;DOS���ܵ��ã�����ַ���
        LEA DX,BUFF1
        MOV AH,0AH
        INT 21H               ;�����һ���ַ�����BUFF1������
        
        LEA DX,qkey
        MOV AH,9
        INT 21H
        LEA DX,BUFF2
        MOV AH,0AH
        INT 21H               ;����ڶ����ַ�����BUFF2������
   
        LEA SI,BUFF1          ;����һ���ַ�����SI
        LEA DI,BUFF2          ;���ڶ����ַ�����DI
        MOV CX,53            ;��������ֵ
        CLD                  ;�巽���׼DF
        REPZ CMPSB        ;һ���ֽ�һ���ֽڱȽ��ַ�����SI��DI����
        JZ MATCH             ;ȫ���ֽڶ�������MATCH
        LEA DX,tkey
        MOV AH,9
        INT 21H               ;�������NO MATCH
        JMP START 
        
MATCH:  LEA DX,skey
        MOV AH,9
        INT 21H               ;DOS���ܵ��ã����MATCH
        JMP START

CODE    ENDS
END     START