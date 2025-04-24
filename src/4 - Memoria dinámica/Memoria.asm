extern malloc
extern free
extern fprintf

section .data

section .text

global strCmp
global strClone
global strDelete
global strPrint
global strLen

; ** String **

; int32_t strCmp(char* a, char* b)
; a[rdi]
; b[rsi]
; 0 si son iguales
; 1 si a < b
;-1 si a > b
strCmp:
	push rbp
	mov rbp, rsp
	
	xor r8, r8
	xor r9, r9

	mov BYTE r8b, [rdi]
	mov BYTE r9b, [rsi]

	xor rcx, rcx ; contador
	xor eax, eax

	.loop:
		cmp r8b, 0
		je .endab
		cmp r9b, 0
		je .endb ; aca se que a != 0, entonces a > b

		; comparo por orden lexicografico
		cmp r8b, r9b
		jl .enda ; a < b
		jg .endb ; a > b

		; si no, continuo
		inc rcx
		mov BYTE r8b, [rdi + rcx]
		mov BYTE r9b, [rsi + rcx]
		jmp .loop

	.enda:
		mov eax, 1
		jmp .end

	.endb:
		mov eax, -1
		jmp .end

	.endab:
		cmp r9b, 0 ; comparo si b=0 tambien
		je .equal
		mov eax, 1
		jmp .end

	.equal:
		mov eax, 0

	.end:
	pop rbp
	ret

; char* strClone(char* a)
;strClone:

; void strDelete(char* a)
strDelete:
	ret

; void strPrint(char* a, FILE* pFile)
strPrint:
	ret

; uint32_t strLen(char* a)
;a[rdi]
strLen:
	push rbp
	mov rbp, rsp

	xor rax, rax ; counter
	mov BYTE r8b, [rdi] ; primer char --- BYTE r8b no es redundante?

	.loop:
		cmp r8b, 0
		je .fin

		inc rax
		mov BYTE r8b, [rdi + rax]
		jmp .loop

	.fin:
	pop rbp
	ret


