TITLE Example of ASM                (asmExample.ASM)

; This program locates the cursor and displays the
; system time. It uses two Win32 API structures.
; Last update: 6/30/2005

INCLUDE Irvine32.inc

; Redefine external symbols for convenience
; Redifinition is necessary for using stdcall in .model directive 
; using "start" is because for linking to WinDbg.  added by Huang

 
main          EQU start@0
.data
pic_hangman BYTE 79 dup(' ') ,0dh,0ah
			BYTE 0B3h,8 dup(' '),0B3h,30 dup(' '),0B3h,'\',14 dup(' '),'/',0B3h , 21 dup(' ') , 0dh,0ah
			BYTE 0B3h,8 dup(' '),0B3h,30 dup(' '),0B3h,1 dup(' '),'\',12 dup(' '),'/',1 dup(' '),0B3h,21 dup (' ') ,0dh,0ah
			BYTE 0B3h,8 dup(' '),0B3h,30 dup(' '),0B3h,2 dup(' '),'\',10 dup(' '),'/',2 dup(' '),0B3h,21 dup (' ') ,0dh,0ah
			BYTE 0B3h,8 dup(0C4h),0B3h,4 dup(' '),3 dup(0C4h),0BFh,3 dup(' '),0DAh,4 dup(0C4h),0BFh,3 dup(' '),0DAh,5 dup(0C4h),0BFh,3 dup(' '),0B3h,3 dup(' ')
			BYTE '\',8 dup(' '),'/',3 dup(' '),0B3h,4 dup(' '),3 dup(0C4h),0BFh,3 dup(' '),0DAh,4 dup(0C4h),0BFh,4 dup (' '),0dh,0ah
			BYTE 0B3h,8 dup(' '),0B3h,7 dup(' '),0B3h,3 dup(' '),0B3h,4 dup(' '),0B3h,3 dup(' '),0B3h,5 dup(' '),0B3h,3 dup(' '),0B3h,4 dup(' ')
			BYTE '\',6 dup(' '),'/',4 dup(' '),0B3h,7 dup(' '),0B3h,3 dup(' '),0B3h,4 dup(' '),0B3h,4 dup (' '),0dh,0ah
			BYTE 0B3h,8 dup(' '),0B3h,3 dup(' '),0DAh,3 dup(0C4h),0B3h,3 dup(' '),0B3h,4 dup(' '),0B3h,3 dup(' '),0B3h,5 dup(' '),0B3h,3 dup(' '),0B3h,5 dup(' ')
			BYTE '\',4 dup(' '),'/',5 dup(' '),0B3h,3 dup(' '),0DAh,3 dup(0C4h),0B3h,3 dup(' '),0B3h,4 dup(' '),0B3h,4 dup (' '),0dh,0ah
			BYTE 0B3h,8 dup(' '),0B3h,3 dup(' '),0B3h,3 dup(' '),0B3h,3 dup(' '),0B3h,4 dup(' '),0B3h,3 dup(' '),0B3h,5 dup(' '),0B3h,3 dup(' '),0B3h,6 dup(' ')
			BYTE '\',2 dup(' '),'/',6 dup(' '),0B3h,3 dup(' '),0B3h,3 dup(' '),0B3h,3 dup(' '),0B3h,4 dup(' '),0B3h,4 dup (' '),0dh,0ah
			BYTE 0B3h,8 dup(' '),0B3h,3 dup(' '),0C0h,3 dup(0C4h),0D9h,3 dup(' '),0B3h,4 dup(' '),0B3h,3 dup(' '),0C0h,5 dup(0C4h),0B3h,3 dup(' '),0B3h,7 dup(' ')
			BYTE '\','/',7 dup(' '),0B3h,3 dup(' '),0C0h,3 dup(0C4h),0D9h,3 dup(' '),0B3h,4 dup(' '),0B3h,4 dup (' '),0dh,0ah
			BYTE 36 dup(' '),0B3h, 42 dup (' ') , 0dh,0ah
			BYTE 36 dup(' '),0B3h, 42 dup (' ') ,0dh,0ah
			BYTE 30 dup(' '),0C0h,5 dup(0C4h),0D9h, 42 dup (' '),0dh,0ah
			BYTE 79 dup (' '),0dh,0ah
			BYTE 79 dup (' '),0dh,0ah				
			BYTE 30 dup(' '),0DAh , 12 dup(0C4h) , 0BFh ,35 dup (' '), 0dh, 0ah
			BYTE 30 dup(' '),0B3h , 12 dup(' ') , 'O' ,35 dup (' '), 0dh, 0ah
			BYTE 30 dup(' '),0B3h , 11 dup(' ') , '/' , '|' , '\',34 dup (' '), 0dh, 0ah
			BYTE 30 dup(' '),0B3h , 11 dup(' ') , '/' , ' ' , '\' ,34 dup (' '), 0dh, 0ah
			BYTE 30 dup(' '),0B3h , 8 dup(' ') ,40 dup (' '), 0dh, 0ah
			BYTE 30 dup(' '),0B3h , 8 dup(' ') ,40 dup (' '), 0dh, 0ah
			BYTE 30 dup(' '),0B3h , 8 dup(' ') ,40 dup (' '), 0dh, 0ah
			BYTE 30 dup(' '),0DAh , 16 dup(0C4h) , 0BFh ,31 dup (' '), 0dh, 0ah
			BYTE 30 dup(' '),0C0h , 16 dup(0C4h) , 0D9h ,31 dup (' '), 0dh,0ah
			BYTE 79 dup (' '), 0dh,0ah,0
				
pic_start BYTE 0DAh , 8 dup(0C4h) , 0BFh , 0dh, 0ah
		  BYTE 0B3h , 8 dup(' ') , 0dh, 0ah
		  BYTE 0B3h , 8 dup(' ') , 0dh, 0ah
		  BYTE 0B3h , 8 dup(' ') , 0dh, 0ah
		  BYTE 0B3h , 8 dup(' ') , 0dh, 0ah
		  BYTE 0B3h , 8 dup(' ') , 0dh, 0ah
		  BYTE 0DAh , 16 dup(0C4h) , 0BFh , 0dh, 0ah
		  BYTE 0C0h , 16 dup(0C4h) , 0D9h , 0

		  
pic_wrong1 BYTE 0DAh , 8 dup(0C4h) , 0BFh , 0dh, 0ah
		   BYTE 0B3h , 8 dup(' ') , 'O' , 0dh, 0ah
		   BYTE 0B3h , 8 dup(' ') , 0dh, 0ah
		   BYTE 0B3h , 8 dup(' ') , 0dh, 0ah
		   BYTE 0B3h , 8 dup(' ') , 0dh, 0ah
		   BYTE 0B3h , 8 dup(' ') , 0dh, 0ah
		   BYTE 0DAh , 16 dup(0C4h) , 0BFh , 0dh, 0ah
		   BYTE 0C0h , 16 dup(0C4h) , 0D9h , 0

pic_wrong2 BYTE 0DAh , 8 dup(0C4h) , 0BFh , 0dh, 0ah
		   BYTE 0B3h , 8 dup(' ') , 'O' , 0dh, 0ah
		   BYTE 0B3h , 8 dup(' ') , '|' , 0dh, 0ah
		   BYTE 0B3h , 8 dup(' ') , 0dh, 0ah
		   BYTE 0B3h , 8 dup(' ') , 0dh, 0ah
		   BYTE 0B3h , 8 dup(' ') , 0dh, 0ah
		   BYTE 0DAh , 16 dup(0C4h) , 0BFh , 0dh, 0ah
		   BYTE 0C0h , 16 dup(0C4h) , 0D9h , 0
	

pic_wrong3 BYTE 0DAh , 8 dup(0C4h) , 0BFh , 0dh, 0ah
		   BYTE 0B3h , 8 dup(' ') , 'O' , 0dh, 0ah
		   BYTE 0B3h , 7 dup(' ') , '/' , '|' , 0dh, 0ah
		   BYTE 0B3h , 8 dup(' ') , 0dh, 0ah
		   BYTE 0B3h , 8 dup(' ') , 0dh, 0ah
		   BYTE 0B3h , 8 dup(' ') , 0dh, 0ah
		   BYTE 0DAh , 16 dup(0C4h) , 0BFh , 0dh, 0ah
		   BYTE 0C0h , 16 dup(0C4h) , 0D9h , 0
		 

pic_wrong4 BYTE 0DAh , 8 dup(0C4h) , 0BFh , 0dh, 0ah
		   BYTE 0B3h , 8 dup(' ') , 'O' , 0dh, 0ah
		   BYTE 0B3h , 7 dup(' ') , '/' , '|' , '\' , 0dh, 0ah
		   BYTE 0B3h , 8 dup(' ') , 0dh, 0ah
		   BYTE 0B3h , 8 dup(' ') , 0dh, 0ah
		   BYTE 0B3h , 8 dup(' ') , 0dh, 0ah
		   BYTE 0DAh , 16 dup(0C4h) , 0BFh , 0dh, 0ah
		   BYTE 0C0h , 16 dup(0C4h) , 0D9h , 0

		  
pic_wrong5 BYTE 0DAh , 8 dup(0C4h) , 0BFh , 0dh, 0ah
		   BYTE 0B3h , 8 dup(' ') , 'O' , 0dh, 0ah
		   BYTE 0B3h , 7 dup(' ') , '/' , '|' , '\' , 0dh, 0ah
		   BYTE 0B3h , 7 dup(' ') , '/' , 0dh, 0ah
		   BYTE 0B3h , 8 dup(' ') , 0dh, 0ah
		   BYTE 0B3h , 8 dup(' ') , 0dh, 0ah
		   BYTE 0DAh , 16 dup(0C4h) , 0BFh , 0dh, 0ah
		   BYTE 0C0h , 16 dup(0C4h) , 0D9h , 0
		   
pic_wrong6 BYTE 0DAh , 8 dup(0C4h) , 0BFh , 0dh, 0ah
		   BYTE 0B3h , 8 dup(' ') , 'O' , 0dh, 0ah
		   BYTE 0B3h , 7 dup(' ') , '/' , '|' , '\', 0dh, 0ah
		   BYTE 0B3h , 7 dup(' ') , '/' , ' ' , '\' , 0dh, 0ah
		   BYTE 0B3h , 8 dup(' ') , 0dh, 0ah
		   BYTE 0B3h , 8 dup(' ') , 0dh, 0ah
		   BYTE 0DAh , 16 dup(0C4h) , 0BFh , 0dh, 0ah
		   BYTE 0C0h , 16 dup(0C4h) , 0D9h , 0
		  
		  
				;"┌────────┐" , 0dh, 0ah
				;"│　　    O"	, 0dh, 0ah
				;"│       /|\" , 0dh, 0ah
				;"│       / \" , 0dh, 0ah
				;"│         " , 0dh, 0ah
				;"│         " , 0dh, 0ah
				;"├────────────────┐" , 0dh, 0ah
				;"└────────────────┘" , 0


Msg1		BYTE "Please input your answer: " , 0
Msg2		BYTE "What alphabet do you guess?: " , 0
Msg3		BYTE "You have got!" , 0 
Msg4		BYTE "You are wrong!" , 0
Msg5		BYTE "You LOSS!" , 0
Msg6		BYTE "The right answer is: " , 0
Msg7		BYTE "Congratulation! You WIN!" , 0
Msg8		BYTE "You can't input special character." , 0dh , 0ah ,0dh , 0ah
			BYTE "Just Input alphabet!" , 0
Msg9		BYTE "You have guessed these : " , 0
Msg10		BYTE "Please guess alphabet." , 0
Msg11		BYTE "Start!" , 0
number		BYTE 6
GuessAlpha  BYTE ?
GuessAnswer BYTE 20 dup(?)
answer		BYTE 20 dup(?)
GuessHistory	BYTE 26 dup(?)
location	BYTE 0
answercount	DWORD ?

.code
main PROC	  

	
	call Clrscr	
	mov eax, white + ( blue * 16 )
	call SetTextColor
	mov edx, offset pic_hangman
	call WriteString
	mov eax, white + ( black * 16 )
	call SetTextColor
	call WaitMsg
	call clrscr
	jmp SetAnswer

ResetAnswer:
	call crlf
	mov edx, offset Msg8
	call WriteString
	call crlf
	call crlf
	mov al, '-'
	call WriteChar
	call crlf 
	call crlf
	
SetAnswer:
	call crlf
	mov edx,  offset Msg1	;請使用者輸入答案
	call WriteString
										   ; 使用者輸入單字
	mov	edx , offset answer                ; 指定緩衝區  
	mov ecx ,  19   ; (20-1)扣掉null，指定最大讀取字串長度
	call ReadString                        ; 輸入字串
	mov answercount , eax                  ; 字串的長度
	
	xor eax, eax
	mov ecx, answercount
	mov edx, offset answer
Judge:		;判斷使用者輸入為英文字母
	mov al, 061h
	cmp [edx], al
	jb ResetAnswer
	mov eax, 7Ah
	cmp [edx], al
	ja ResetAnswer
	inc edx
	Loop Judge
	
	call Clrscr
	
Start:
	call crlf
	mov eax, blue + ( white * 16 )
	call SetTextColor
	mov edx, offset Msg11
	call WriteString
	mov eax, white + ( black * 16 )
	call SetTextColor
	call crlf
	call crlf
	call crlf
	;顯示*字號，並且改變GuessAnswer裡面的東西。
	mov edx, offset GuessAnswer 
	mov ecx, answercount
	mov ebx, '-'
	
Show: 						
	mov [edx], ebx
	Call WriteString
	inc edx
	Loop Show
	
	call crlf
	call crlf
	mov edx, offset pic_start	;顯示圖片
	call WriteString
	jmp Guess
	
ReGuess:
	call crlf
	mov al, '-'
	call WriteChar
	call crlf
	call crlf
	mov edx, offset Msg10
	call WriteString
	
Guess:
	call crlf
	call crlf
	mov edx, offset Msg2
	call WriteString
	call crlf
	
	call Readchar
	mov GuessAlpha, al	

	mov bl, 061h
	cmp al, bl
	jb ReGuess
	mov bl, 7Ah
	cmp al, bl
	ja ReGuess
	
	
	
	mov esi, offset answer
	mov edi, offset GuessAnswer
	mov ecx, answercount
	xor edx, edx
Compare:
	cmp [esi], al
	jnz diff
same:
	mov [edi], al
	inc edx
diff:
	inc esi
	inc edi
	Loop Compare
	

	call Clrscr
	cmp edx, 0
	jnz Get	
	sub number, 1
	call crlf
	mov eax, blue + ( white * 16 )
	call SetTextColor
	mov edx, offset Msg4
	call WriteString
	mov eax, white + ( black * 16 )
	call SetTextColor
	call crlf
	jmp ShowNow
Get:
	call crlf
	mov eax, blue + ( white * 16 )
	call SetTextColor
	mov edx, offset Msg3
	call WriteString
	mov eax, white + ( black * 16 )
	call SetTextColor
	call crlf

	
ShowNow:
	call crlf
	call crlf
	mov edx, offset GuessAnswer
	call WriteString
	call crlf
	call crlf

StoreGuessHistory:
	mov al, GuessAlpha
	mov edx, offset GuessHistory
	movzx ecx, location
	add edx, ecx
	mov [edx] , al
	inc location
	
	mov ecx, answercount
	cld			;compare whether win or not
	mov esi, offset GuessAnswer
	mov edi, offset answer
	repz cmpsb
	jz win
	
	cmp number, 6
	jz L6
	cmp number, 5
	jz L5
	cmp number, 4
	jz L4
	cmp number, 3
	jz L3
	cmp number, 2
	jz L2
	cmp number, 1
	jz L1
	cmp number, 0
	jz Loss
L6:
	mov edx, offset pic_start
	jmp Jumpback
L5:
	mov edx, offset pic_wrong1
	jmp Jumpback
L4:
	mov edx, offset pic_wrong2
	jmp Jumpback
L3:
	mov edx, offset pic_wrong3
	jmp Jumpback
L2:
	mov edx, offset pic_wrong4
	jmp Jumpback
L1:
	mov edx, offset pic_wrong5
Jumpback:
	call WriteString
	call crlf
	call crlf
	mov edx, offset Msg9
	call WriteString

	mov edx, offset GuessHistory
	call WriteString
	
	jmp Guess

	
Loss:
	mov edx, offset pic_wrong6
	call WriteString
	call crlf
	call crlf
	mov edx, offset Msg5
	call WriteString
	call crlf
	call crlf
	mov edx, offset Msg6
	call WriteString
	mov edx, offset answer
	call WriteString
	jmp Over
Win:
	call crlf
	mov edx, offset Msg7
	call WriteString

Over:

	call crlf
	call crlf
	mov edx, offset Msg9
	call WriteString
	mov edx, offset GuessHistory
	call WriteString
	call crlf
	call crlf
	call WaitMsg
	call clrscr
	
	mov edx, offset GuessHistory
	mov ecx, DWORD PTR location
	mov bl, 0
clear:
	mov [edx], bl
	inc edx
	Loop clear
	mov location, 0
	mov number, 6 
	jmp SetAnswer
	exit
	
main ENDP
END main 