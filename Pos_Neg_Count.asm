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
	nline		db	10
	nline_len	EQU	$-nline
	
	ano		db	"Assignment 1 -->> Count number of posiive and negative numbers"
	ano_len		EQU	$-ano

	pmsg		db 	"Count of positive numbers: "
	pmsg_len	EQU	$-pmsg

	nmsg		db	"Count of negative nubers: "
	nmsg_len	EQU	$-nmsg

	arr64 		dq	11h,22h,-33h,-44h,55h
	n		EQU	5
	
;-----------------------------------------------------------------------------------------------------

section	.bss
	p_count		resq	1
	n_count 	resq	1
	char_ans	resb	4
;-----------------------------------------------------------------------------------------------------

section	.text
global _start

_start:
	print	nline,nline_len
	print 	ano,ano_len
	print	nline,nline_len
		
	mov 	rax,0
	mov 	rcx,0
	mov 	rbx,0
	mov 	rdx,0
	
	mov 	rsi,arr64
	mov	rcx,n
	
	back:	
		mov	rax,[rsi]
		BT	rax,63
		JC	negative
		inc 	rbx
		JMP	next
	
	negative:
		inc	rdx
		
	next:
		add	rsi,8
		dec	rcx
		jnz	back
	
	mov	[p_count],rbx
	mov	[n_count],rdx
	
	print	nline,nline_len
	print	pmsg,pmsg_len
	mov 	rax,[p_count]
	call 	display
	print	nline,nline_len
	
	print	nline,nline_len
	print	nmsg,nmsg_len
	mov 	rax,[n_count]
	call 	display
	print	nline,nline_len
	
	exit
;-------------------------------------------------------------------------------	
display:
	mov	rbx,16
	mov	rcx,4
	mov	rsi,char_ans+3
	
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
