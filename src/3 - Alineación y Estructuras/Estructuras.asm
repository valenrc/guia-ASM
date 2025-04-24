;########### ESTOS SON LOS OFFSETS Y TAMAÑO DE LOS STRUCTS
; Completar las definiciones (serán revisadas por ABI enforcer):
NODO_OFFSET_NEXT EQU 0
NODO_OFFSET_CATEGORIA EQU 8
NODO_OFFSET_ARREGLO EQU 16
NODO_OFFSET_LONGITUD EQU 24
NODO_SIZE EQU 32
PACKED_NODO_OFFSET_NEXT EQU 0
PACKED_NODO_OFFSET_CATEGORIA EQU 8
PACKED_NODO_OFFSET_ARREGLO EQU 9
PACKED_NODO_OFFSET_LONGITUD EQU 17
PACKED_NODO_SIZE EQU 14
LISTA_OFFSET_HEAD EQU 0
LISTA_SIZE EQU 8
PACKED_LISTA_OFFSET_HEAD EQU 0
PACKED_LISTA_SIZE EQU 8

;########### SECCION DE DATOS
section .data

;########### SECCION DE TEXTO (PROGRAMA)
section .text

;########### LISTA DE FUNCIONES EXPORTADAS
global cantidad_total_de_elementos
global cantidad_total_de_elementos_packed

;########### DEFINICION DE FUNCIONES
;extern uint32_t cantidad_total_de_elementos(lista_t* lista);
;registros: lista[rdi]
cantidad_total_de_elementos:
	push rbp
	mov rbp, rsp

	mov r8, [rdi + LISTA_OFFSET_HEAD] ; primer nodo (head)
	xor eax, eax

	.loop:
		cmp r8, 0 ; nodo == null
		je .end_loop
		mov r9d, [r8+NODO_OFFSET_LONGITUD] ; acumulo la longitud
		add eax, r9d
		mov r8, [r8+NODO_OFFSET_NEXT] ; next
		jmp .loop

	.end_loop:
	pop rbp
	ret

;extern uint32_t cantidad_total_de_elementos_packed(packed_lista_t* lista);
;registros: lista[?]
cantidad_total_de_elementos_packed:
	push rbp
	mov rbp, rsp

	mov r8, [rdi+PACKED_LISTA_OFFSET_HEAD]
	xor eax, eax

	.loop:
		cmp r8, 0
		je .end_loop
		mov r9d, [r8+PACKED_NODO_OFFSET_LONGITUD]
		add eax, r9d
		mov r8, [r8+PACKED_NODO_OFFSET_NEXT]
		jmp .loop
		
	.end_loop:
	pop rbp
	ret

