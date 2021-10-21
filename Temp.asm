assume cs:code,ds:data,ss:stack

data segment

data ends

stack segment stack

stack ends

code segment
        start:  mov ax,123FH

                mov ax,4C00H
                int 21H
code ends
end start