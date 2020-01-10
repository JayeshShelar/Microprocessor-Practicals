;------------------------------------------------------------------------------------------------

;Roll No	: 	SECOB268
;Name		: 	Jayesh Shelar
;Assignment Name:	ALP for Block transfer Non Overlapped without String Instructions
;Assignment No	: 	2a.asm

;-------------------------------------------------------------------------------------------------
%macro	print	2
	
	mov	rax,1
	mov	rdi,1
	mov	rsi,%1
	mov	rdx,%2
	syscall
%endmacro


%macro	exit	0
	print	nline,nline_len
	mov	rax,60
	mov	rdi,0
	syscall
%endmacro
	
;-------------------------------------------------------------------------------------------------

section .data

	space 		db 	" "
	nline		db	10
	nline_len	EQU	$-nline
	
	ano		db	10,10,"Assignment 2 -->> Block transfer Non Overlapped without String Instructions",10
	ano_len		EQU	$-ano

	smsg		db	10,"	Source Block 		= "
	smsg_len	EQU	$-smsg
	
	dmsg		db 	10,"	Destination Block 	= "
	dmsg_len	EQU	$-dmsg
	
	bmsg		db	10,10,"Block before Transfer"
	bmsg_len	EQU	$-bmsg
	
	amsg		db	10,10,"Block after Transfer"
	amsg_len	EQU	$-amsg
	
	sblock		db	10h,20h,30h,40h,50h
	dblock		times 	5	db	0
;-----------------------------------------------------------------------------------------------------

section	.bss
	char_ans	resb	2
;-----------------------------------------------------------------------------------------------------

section	.text
global _start

_start:
	print 	ano,ano_len
	
	print 	bmsg,bmsg_len

	print 	smsg,smsg_len
	mov 	rsi,sblock
	call 	display_block
	
	print	dmsg,dmsg_len
	mov 	rsi,dblock
	call	display_block
	
	call BT_NO
	
	print 	amsg,amsg_len
	
	print 	smsg,smsg_len
	mov	rsi,sblock
	call 	display_block
	
	print	dmsg,dmsg_len
	mov	rsi,dblock
	call 	display_block
				
	exit
	
;------------------------------------------------------------------------------
display_block:
	mov 	rbp,5
	
back:
	xor	rax,rax
	mov 	al,[rsi]
	push	rsi	
	
	call	display
	print	space,1
	
	pop	rsi
	inc 	rsi
	dec	rbp
	jnz	back
	
	ret
;-------------------------------------------------------------------------------	
display:
	mov	rbx,16
	mov	rcx,2
	mov	rsi,char_ans+1
	
	back2:
		mov	rdx,0
		div	rbx
		cmp	rdx,09h
		jbe	add30
		add	rdx,07h	
	
	add30:
		add	rdx,30h
		mov 	[rsi],dl
		dec	rsi
		dec	rcx
		jnz	back2
		print	char_ans,16

	ret
;--------------------------------------------------------------------------------
BT_NO:
	mov	rcx,5
	mov 	rsi,sblock
	mov	rdi,dblock
	
back3:	mov 	al,[rsi]
	mov 	[rdi],al
	
	inc 	rsi
	inc 	rdi
	
	dec	rcx
	jnz	back3
	
	ret
;---------------------------------------------------------------------------------
