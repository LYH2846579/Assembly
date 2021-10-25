class  
{
	public static void main(String[] args) 
	{
		System.out.println("Hello World!");
	}
}
//1.寄存器之间是相互独立的，八位寄存器只保留八位数据，十六位寄存器只保留十六位数据。在进行八位运算的时候，若低八位存在进位的时候，不会进位到高八位!

//2.段地址寄存器 ： 偏移地址寄存器
		ds				 sp
		es				 bp
		ss				 si
		cs				 di
						 bx
   （1）地址线的数量决定了CPU的寻址能力 -> 8086设计了20根地址线  00000H~FFFFFH   But8086的寄存器均为16位
   （2）因此设计了地址加法器，用于物理地址计算
   	(3) 段地址 × 16（10H）+ 偏移地址 = 物理地址
		段地址 * 16 = 基础地址
		基础地址 + 偏移地址 = 物理地址
	(4) 例：段地址:F230H   偏移地址:C8H
			有效地址:F23C8H
		思想:从学校到图书馆...
	(5) -d 指令   --> 显示内存区域的内容
				  --> 例：-d 2000:1F60  将该内存地址中的内容全部输出（当然也会将接下来的内存地址顺序输出）
		-e 指令   --> 改变内存单元的内容	(按空格在字节之间进行跳转)
	(6) 可以使用多个段地址+偏移地址的组合来对同一个内存单元

//3.检测点2.2
	(1)练习:段地址为0001H仅仅通过变换偏移地址所能寻址的范围为:00010H~1000FH		[附：段地址为10H！]
	(2)练习:有一个数据存放在20000H的内存单元中，使用SA作为段地址，则SA的范围应为:1001H~2000H	[注意余数！]

//4.CPU区分指令和数据
	(1) -u	将某个内存地址开始的字节，全部当做指令
		-d	将某个内存地址开始的字节，全部当做数据
	(2) 8086CPU将CS:IP指向的内容，全部当做指令来处理
	(3)指令的执行过程：
		->CPU从CS:IP指向的内存单元读取指令，存放到指令缓存器中
		->IP = IP+所读指令的长度，从而指向下一条指令
		->执行指令缓存器的内容，回到步骤1
	(4) -r  观看和修改寄存器的内容
		-t  执行汇编程序，单步跟踪

//5.修改CS和IP的值
	使用转移指令进行赋值
	jmp 2000:0	-> cs:2000H	ip:0000H
	jmp 寄存器	-> 将寄存器中存储的内容送至ip

//6.指令执行过程及设计原因 call
	首先将当前指令的下一条指令地址值存储到栈中，跳转到指定地址，执行完对应的语句之后遇到RET指令，将栈顶元素出栈送IP,
	-> 目前仅可以处理段内地址跳转（段间跳转存在一定的问题!）
	-> 段间跳转的方式：CALL [FAR] 过程名 ，此时CS，IP均要入栈	附：[]应该不输入，且far后面跟随ptr，但是一直无法实现段间跳转！CS的值不变！

//7.实验任务
	INC/DEC -> 自增自减运算符
	loop	-> 首先将CX的值-1并存储在CX中，接下来判断CX是否为零,若不为零，则跳转到指定地址

//8.承上启下
	指令是有长度的，和ip的跳转频度有关
	遗留的问题：段内跳转call和段间跳转存在问题!

//9.字型数据与字节型数据
	一个字型数据在内存中可以由两个连续地址的内存单元来存储
	高地址 内存单元存放 字型数据的 高位字节
	低地址 内存单元存放 字型数据的 低位字节
	例：0	20H					地址0中存放的字节型数据：20H
		1	4EH					地址0中存放的字型数据：4E20H
		2	12H					地址2中存放的字节型数据：12H
		3	00H					地址2中存放的字型数据：0012H
								地址1中存放的字型数据：124EH
//数据转移指令
	(1) Debug中不允许使用mov al,ds:[0] -> 可以使用mov al,[0]
	(2) 段地址寄存器不允许使用立即数直接赋值，可以借助寄存器进行赋值

//在使用命令行执行数据转移及运算的时候需要特别注意：
	(1) 需要注意目的寄存器的位数，是8位还是16位！
	(2) 内存中数据以高位数据存储在高地址段，低位数据存储在低地址段  60 10 -> 1060H
	(3)	需要注意在使用直接寻址方式DS:[1]时，需要注意从0开始！

//检测点
	(1) 注意，对于CS和IP，不可以使用MOV直接对其赋值！	-> 使用 -r / jmp修改
	(2) 可以使用MOV指令对数据段地址进行赋值 MOV ax,ds
	(3) CS:IP -> 读取指令
		DS:[*] -> 读取数据

//栈
	(1) 入栈与出栈指令均操作字型数据
	(2) push指令:将SP的值-2，并将SRC字数据的低八位存储在堆栈段偏移地址(SP),高八位存储在堆栈段偏移地址(SP+1) 
		pop指令:将(SP)中字节数据存入DST的低8位，将(SP+1)中的字节数据存入DST的高八位，并将SP+2

//空间的安全使用
	(1) 0:200~0:2FFH 段[256byte]可以放心使用


//伪指令
	告诉编译器(编译软件)这里如何翻译，那里如何翻译
	对CPU的地址寄存器进行了设置，从而让CPU去按照我们的安排去访问 数据段和栈段

//使用Debug进程程序跟踪
	cx = 程序的长度
	p -> 执行int中断指令
	q -> 退出debug程序

//一定注意使用debug操作和直接文件书写的区别!
	-> debug中默认为16进制字符，后面无需加H
	-> asm文件书写时，输入16进制需要加上H
	-> 在debug中使用-p指令执行INT型中断
	-> mov ax,B008H -> 不被允许 [mov ax,0B800H]

//注意事项
	(1) 在Debug中可以使用jmp 000AH[注意,debug中不带H]的指令对IP进行修改
	(2) 在使用文本编辑的时候，不可以直接使用jmp加地址的形式进行跳转[每次运行时地址不一定相同]，使用变量名跳转2021/10/19
	(3) 使用loop指令时，注意其上来首先无条件-1，也就是当cx=1时，loop后面的指令仅仅执行一次[loop并不跳转 int ]
	(4) 快速跳过loop指令的方法:
		① 当loop指令出现在指令缓存器中的时候，使用-p指令继续执行即可跳过循环
		② 查看loop下一条指令的地址，使用-g指令+段内偏移指令即可实现跳转	-g 14
	(5) 针对(3)的一些解释:当想要loop后面跟随的指令仅仅执行一次的时候，将CX寄存器赋值1即可
		--> 注意注意！loop指令位于执行代码的下端，与do-while指令有一定的相似性！在进入loop周期之前，已经无条件执行了一次
			--> 无法用loop指令实现向上跳转的过程	2021/10/19
	(6) 在文本编辑模式下，可以直接向寄存器中赋值10进制的数，如mov ax,123
	(7) 在进行运算的时候，一定看清是字型数据还是字节型数据【这决定着地址跳转是+1还是+2的问题】
			-> 还需要考虑是否存在溢出的问题

//在代码段中安排自己定义的数据		-》	第七个练习
	(1) 使用dw指令进行定义自己的数据，当然需要配合start：和end satrt进行指令指明
	(2) -> 以上当然也可以在定义的数据之前使用jmp指令直接跳转到指令段，但是在使用自定义的数据的时候需要注意jmp指令所占的空间大小

//在代码段中安排自己定义的栈空间（通过系统分配内存）	-> 第八个练习
	(1) 在code中使用dw指令定义一段数据段，以此作为栈空间
	(2) 汇编不允许两个段寄存器之间直接传输数据	???			mov ss,cs?			
	(3) 注意，在程序运行的过程之中，栈内数据极有可能被改变，因此不要将栈设置为最终的转移目标[可以仅仅借助栈空间]	???
		-> 使用自己开辟的栈空间:
			->		dw 7 dup(?)																			 mov ax,cs
				btn dw ?			-->这样会在code段开辟8个字空间大小的堆栈	->※注意	ss和sp指针的修改 mov ss,ax    mov sp,offset btn
	
//一些思考 -> 代码分区
	(1) 在此之前，我们将数据段、栈段、代码段统统放置在code段中，如下所示

	assume cs:code

	code segment
		
			;数据段
			dw 0123H,2345H
			;栈段
			dw 0,0,0,0,0,0,0,0
			dw 0,0,0,0,0,0,0,0
		

			;代码段
	start:	mov ax,cs
			...

			mov ax,4C00H
			int 21H
	code ends
	end start
	(2) 此种做法会缩短IP寄存器的变化范围 0~FFFFH ，缩短了指令的数量		-> 接下来在test2中对代码架构进行改进
		-> start伪指令：将入口地址记录在exe文件的描述信息中，使得CPU在执行的时候可以根据描述信息修改CS:IP
	(3) 在使用栈段、数据段、代码段三段分离处理之后，会从debug中发现三段的内存地址接近！
		-> 段与段之间相差的最小值为1，但是段相差1导致两个段之间最小的距离为10H，即16个字节			内存对齐！
			-> 一个segment占用空间:16、32、64


//and指令和or指令
	(1) 学习更灵活的定位内存地址的方法
		-> ds:[0]...ds:[bx]		-- bx位偏移地址寄存器
		--> 还可以采用si和di两个寄存器进行访问			-> test3 练习3
			-> 可以直接向偏移地址寄存器中赋值		mov si,0
	(2) and 指令
		mov al,00001010B
		and al,11110101B	-> 就是将0相对应的位设置成0,1对应的位保持不变

		or 指令
		mov al,00001111B
		or	al,11110000B	-> 就是将1对应的位设置为1，0对应的位保持不变
 

//以字符形式给出数据
	(1) 我们在定义数据的时候，当然可以根据字符对应的ASCII表进行定义，但是存在着记忆困难的问题
		-> 因此，改用字符型进行定义 db '1234567'	//一定使用单引号


//字母的大小写转换问题	->在test2 练习2
	(1) 分析大小写字母的ASCII值对应的2进制形式可知，当大写字母的第五位变为1时，即变为对应的小写字母	
		0100 0001 -> 0110 0001			--> 相当于+32
	(2) 注意，在定义字符串的时候一定使用 单引号+db指令!!!!!!!


//[bx+5]的内存访问形式                          ->寄存器相对寻址
	(1) 经过试验验证，可以使用立即数对内存单元中的内容进行加法运算!!!								※※
		-> 试验2的增强版需要反复思考练习！！！！
	(2) 注意堆栈段开辟时的格式，尤其是对sp指针的操作，一定注意避免内存泄露的问题
	(3) 使用要点:当操作的字符串位数相等的时候可以考虑这种方式!


//si、di偏移地址寄存器	-> test2 练习3          
    (1) 使用-p指令可以跳过loop循环指令
    (2) si、di偏移地址寄存器的使用方式与bx类似


//[bx+si][bx+di]    组合偏移地址形式              ->基址变址寻址
    (1) 以上的组合形式可以将ds:bx视为初始地址，而si、di是相对于初始地址的偏移量

//[bx+si+number]、[bx+di+number]                ->相对基址变址寻址
    -> test3 练习5
    -> 针对使用Enter键提示乱七八糟的东西 -> 将设置中的Accept Suggestion On Enter 设置为off


//loop双循环练习    -> test2 练习4
    -> 在进入第二个循环之前将当前的CX值入栈
        ->在第二个循环结束的时候将栈中的CX取出


//不通过寄存器来确定数据的长度
    (1) 在之前的所有练习之中，几乎所有的mov运算等均需要通过寄存器来确定数据的长度
        ->而在直接对内存数据进行操作的时候，需要特别指明操作数的长度
            -> mov ds:[bx],10   -> 这种指令是ERROR的
            -> mov byte ptr ds:[bx],10  ->√
    (2) 目前对于数据的操作，仅仅使用到 word ptr 和 byte ptr 两种
    (3) jmp指令中存在near ptr 和 far ptr

//数据长度练习  -> test2 练习5
    -> 直接对内存中的数据进行操作的时候，需要指明操作数的长度

//div除法指令   ->  test2 练习6 练习7
    (1) 默认有8位和16位两种，在一个寄存器或者内存单元中
    (2) 被除数：放在 AX 或着 AX , DX 中
        -> 倘若除数为8位，被除数为16位，则默认存放在 AX 中
        -> 倘若除数为16位，被除数为32位，则 DX 存放高16位，AX 存放低16位
    (3) 结果：若除数8位，则 AL 存储除法操作的商， AH 存储除法操作的余数
            若除数为16位，则 AX 存储除法操作的商，DX 存储除法操作的余数
    (4) 例：
        16  被除数  -》 ax
        3   除数    -》 寄存器、内存    --> 8位寄存器或者byte ptr
        5   商      -》 存储在al
        1   余数    -》 存储在ah
    (5) 注意！div为单操作数指令!
    (6) 当商的大小大于 ah 或者 ax 可以存储的大小的时候，会有除法栈溢出异常


//dd伪指令
    (1) 用于定义一个双字
//dup伪指令
    (1) 用于重复定义空间    -> db 100 dup('12') ->每一个存储单元内填充12的ASCII码值

//针对于实验七的一些操作
	关于实验7，是对于数据访问、数据计算等操作的综合练习，这里暂时将其跳过，继续向后学习			-> !
	结构化数据访问数据
	将数据进行结构化处理，取到每一组结构存储首地址之后，可以很方便的对其进行访问        	    ->将数据结构化


//第九章 转移指令
	(1) def:可以修改IP或者同时修改CS和IP 的指令
	(2) offset操作符 -> 取得标号数的偏移地址			mov ax,offset s
	(3) 针对于jmp指令的练习						test4 练习1
		-> jmp跳转指令后面的机器码和指令的长度有关
			-> 标号地址 - jmp指令后的第一个字节地址     EB××	
		-->jmp指令的跳转范围
			-> 8位位移		-128~127			指定8位位移 jmp short s
			-> 16位位移		-32768~32767		指定16位位移 jmp near ptr s			[段内跳转?]
	(4) 对于jmp指令的一些更深入理解		-> test4 练习1
	(5) nop:填充指令，增加时延等
	(6) 针对于实验8的总结：				-> test4 练习1
		jmp指令在编译阶段已经将偏移量计算出来，在复制语句的时候并不会发生改变,
		因此jmp语句原来相对于jmp的下一条语句跳转的偏移量在语句复制之后并不会发生改变.
		-> 即原来相对于jmp指令向前跳转10个字节，在复制之后仍相对于复制到的位置的下一条语句向前跳转10个字节
		--> 这涉及到jmp指令的跳转方式计算问题																-> ※

//jcxz条件转移指令
	(1) 语义:jcxz -> jump if cx = 0				--> 当cx寄存器为零的时候进行跳转
	(2) 思考:jcxz与loop指令进行搭配的时候，可以方式由于cx为零导致的陷入loop死循环!							  -> ※
	(3) 注意:所有的条件转移指令都是 短转移(short) -> 位移的范围为 -128~127
			 且经过编译之后，机器码中包含了位移的范围	EBXX	-> 同样为标号处的偏移地址 - jmp指令后的第一个字节地址
	(4) 指令练习 -> test4 练习2
	(5) 注意:针对于段寄存器的赋值操作，首先当然要使用寄存器对其赋值，一定注意10进制与16进制的区别!	2000 != 2000H


//loop指令
	(1) loop也是短转移指令
	(2) 跳转的目的地址是在编译的时候计算得到的
	(3) 指令练习 -> test4 练习3


//转移目的地址在机器码或寄存器中
	(1) 转移的目的地址在机器码中的 jmp指令
		-> jmp 1000:2233					--> EA33220010			[直接修改CS:IP]
	(2) 转移的目的地址在寄存器中的 jmp指令
		-> jmp ax							--> 寄存器寻址

//转移的目的地址在内存中的 jmp指令
	(1) jmp word ptr ds:[0]			-> IP = ds:[0] 的字型数据		--> CS 、IP 寄存器均为4位16进制寄存器
	(2) jmp dword ptr ds:[0]		-> CS = ds:[2] 的字型数据		-> IP = ds:[0] 的字型数据
	(3) 结构化地址访问方式 			 -> 一种类似函数指针的跳转方式	  -> test4 练习4
	(4) 跳转到起始地址 : [默认start位于code段最开始部分]	
				data segment
					db 0
					dw 0					;当然可以使用dw offset start !
				data ends

//实验9 涉及到B800:0000段显示缓存器中的内容   ->  暂时略过


//根据位移 来修改IP寄存器 进行转移指令的优势
	jmp 标号
	jmp short 标号
	jmp near 标号
	jcxz 标号
	loop 标号

	位移 = 标号处的偏移地址 - 转移指令后第一个字节的地址
	CPU 计算转移指令: 转移指令后第一个字节的地址 + 转移指令中机器码内部的位移

	优点：可以在内存中的任何一段都正确运行,注意与test4中实验4的比较


//第十章 CALL和RET指令

//ret 和 retf指令
	(1) def: ret  -> pop ip
			 retf -> pop ip + pop cs
	(2) 使用retf跳转 1000H:0000
		mov ax,1000H
		push ax
		mov ax,0
		push ax
		retf

//call指令
	(1) def: call -> push ip + jmp near ptr 标号			  -> 16位位移
	(2) 语义：将call指令的下一条指令的地址入栈，跳转到标号位置
	(3) 特点：无近转移方式，计算方式与jmp指令相同

//转移的目的地址在指令中的call指令
	(1) 转移的目的地址在指令(机器码)中的call指令
	(2) call far ptr 标号   ->  push cs				-> 将call下一条指令的cs ip 入栈
								push ip
								jmp far ptr 标号
		-> 该指令会被编译为 call 1000:0009形式

//转移地址在寄存器中的call指令
	(1) call + 16位寄存器	->  push ip
								jmp + 16位寄存器	

//转移地址在内存中的call指令		-> test4 练习5
	(1) 格式:call word ptr + 内存单元地址		-> push ip
												  jmp word ptr + 内存单元地址

			 call dword ptr + 内存单元地址		-> push cs
			 									  push ip
												  jmp dword ptr + 内存单元地址
	(2) 注意，无论是在 jmp 指令还是在 call 指令后面的 nop 指令，都会被认为是一个字节的指令!		-> 即跳转指令下一条指令的地址为nop指令地址

//call指令的应用 		-> test4 练习6		-> 相当于switch语句!!!!!  ※
	(1) 使用将跳转地址存储在内存中的形式，接下来通过call word ptr ds:[bx] 形式对其进行访问
	(2) 当前面再加上条件转移指令的时候，是否可以组成 switch 语句?
	(3) 使用call指令将代码进行切割之后，有利于debug
		-> 仅仅针对于某一个模块进行debug				-> ※※！				-> 使用-p 指令跳转过正确的模块

//对call指令的进一步学习	-> test4 练习7
	(1) 针对于call的深入分析 -> 结构化代码
	(2) 思想: 最好在进入call指令之前，将使用到的寄存器全部入栈存储，在call指令结束之后再将原有寄存器中的值取出



//mul指令
	(1) 两个操作数进行相乘 -> 要么都为8位，要么都为16位				-> ※ 注意与div指令做对比
	(2) 若为 8 位，则一个数字默认存储在 al 中，另外一个数字存放在 其他8位寄存器 或者 字节型内存单元中
		al  *(mul)  8位寄存器			=  ax			-> mul 8位寄存器
		al  *(mul)	byte ptr ds:[0]	    =  ax		    -> mul byte ptr ds:[0]
	(3) 若为 16 位，则一个数字默认存储在 ax 中，另外一个数字存放在其他 16 位寄存器中 或者 字型内存单元中
		al  *(mul)	16位寄存器 			=	dx , ax		-> mul 16位寄存器
		al  *(mul)	word ptr ds:[0]	    =   dx , ax		-> mul word ptr ds:[0]

	(4) 结果: 8位乘法得到一个16位数 -> 存储在 ax 中
			  16位乘法得到一个32位数 -> 低16位存储在 ax 中，高16位存放在 dx 中







