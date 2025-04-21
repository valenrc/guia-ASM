extern sumar_c
extern restar_c
;########### SECCION DE DATOS
section .data

;########### SECCION DE TEXTO (PROGRAMA)
section .text

;########### LISTA DE FUNCIONES EXPORTADAS

global alternate_sum_4
global alternate_sum_4_using_c
global alternate_sum_4_using_c_alternative
global alternate_sum_8
global product_2_f
global product_9_f

;########### DEFINICION DE FUNCIONES
; uint32_t alternate_sum_4(uint32_t x1, uint32_t x2, uint32_t x3, uint32_t x4);
; parametros: 
; x1 --> EDI
; x2 --> ESI
; x3 --> EDX
; x4 --> ECX
alternate_sum_4:
  sub EDI, ESI
  add EDI, EDX
  sub EDI, ECX

  mov EAX, EDI
  ret

; uint32_t alternate_sum_4_using_c(uint32_t x1, uint32_t x2, uint32_t x3, uint32_t x4);
; parametros: 
; x1 --> EDI
; x2 --> ESI
; x3 --> EDX
; x4 --> ECX
alternate_sum_4_using_c:
  ;prologo
  push RBP ;pila alineada
  mov RBP, RSP ;strack frame armado
  push R12
  push R13	; preservo no volatiles, al ser 2 la pila queda alineada

  mov R12D, EDX ; guardo los parámetros x3 y x4 ya que están en registros volátiles
  mov R13D, ECX ; y tienen que sobrevivir al llamado a función

  call restar_c 
  ;recibe los parámetros por EDI y ESI, de acuerdo a la convención, y resulta que ya tenemos los valores en esos registros
  
  mov EDI, EAX ;tomamos el resultado del llamado anterior y lo pasamos como primer parámetro
  mov ESI, R12D
  call sumar_c

  mov EDI, EAX
  mov ESI, R13D
  call restar_c

  ;el resultado final ya está en EAX, así que no hay que hacer más nada

  ;epilogo
  pop R13 ;restauramos los registros no volátiles
  pop R12
  pop RBP ;pila desalineada, RBP restaurado, RSP apuntando a la dirección de retorno
  ret

alternate_sum_4_using_c_alternative:
  ;prologo
  push RBP ;pila alineada
  mov RBP, RSP ;strack frame armado
  sub RSP, 16 ; muevo el tope de la pila 8 bytes para guardar x4, y 8 bytes para que quede alineada

  mov [RBP-8], RCX ; guardo x4 en la pila

  push RDX  ;preservo x3 en la pila, desalineandola
  sub RSP, 8 ;alineo
  call restar_c 
  add RSP, 8 ;restauro tope
  pop RDX ;recupero x3
  
  mov EDI, EAX
  mov ESI, EDX
  call sumar_c

  mov EDI, EAX
  mov ESI, [RBP - 8] ;leo x4 de la pila
  call restar_c

  ;el resultado final ya está en EAX, así que no hay que hacer más nada

  ;epilogo
  add RSP, 16 ;restauro tope de pila
  pop RBP ;pila desalineada, RBP restaurado, RSP apuntando a la dirección de retorno
  ret

; uint32_t alternate_sum_8(uint32_t x1, uint32_t x2, uint32_t x3, uint32_t x4, uint32_t x5, uint32_t x6, uint32_t x7, uint32_t x8);
; registros y pila: x1[edi], x2[esi], x3[edx], x4[ecx], x5[r8d], x6[r9d], x7[rbp+16], x8[rbp + 24]
alternate_sum_8:
	;prologo
  push rbp
  mov rbp, rsp

	; (x1 - x2 + x3 - x4) + (x5 - x6 + x7 - x8) = alternate_sum_4(x1,x2,x3,x4) + alternate_sum_4(x5,x6,x7,x8)
  ; EDI, ESI, EDX, ECX son los arg de alt_sum_4 - el resultado se guarda en eax
  call alternate_sum_4
  mov r10d, eax ; guardo en r10d el resultado para despues pasarlo a la funcion sumar_c

  ; paso x5,...,x8 como arg de alt_sum_4
  mov edi, r8d
  mov esi, r9d
  mov edx, [rbp+16]
  mov ecx, [rbp+24]
  call alternate_sum_4
  mov esi, eax ; muevo el resultado al segundo paremetro de sumar_c

  mov edi, r10d ; paso al primer arg lo que habia guardado en r10d
  call sumar_c ; el resultado se va a guardar en eax

	;epilogo
  pop rbp
	ret

; SUGERENCIA: investigar uso de instrucciones para convertir enteros a floats y viceversa
;void product_2_f(uint32_t* destination, uint32_t x1, float f1);
;registros: destination[rdi], x1[esi], f1[xmm0]
product_2_f:
  push rbp
  mov rbp, rsp

  movd xmm1, esi      ; guardar x1 en xmm1
  cvtdq2ps xmm1, xmm1 ; convertirlo a float
  mulps xmm0, xmm1    ; multiplicarlo por f1 (xmm0)
  cvttps2dq xmm0, xmm0 ; convertir el resultado a entero de 32 bits
  movd eax, xmm0       ; guardar el resultado en eax

  ; escribirlo a la direccion en rdi
  mov [rdi], eax

  pop rbp
	ret

;extern void product_9_f(double * destination
;, uint32_t x1, float f1, uint32_t x2, float f2, uint32_t x3, float f3, uint32_t x4, float f4
;, uint32_t x5, float f5, uint32_t x6, float f6, uint32_t x7, float f7, uint32_t x8, float f8
;, uint32_t x9, float f9);
;registros y pila: destination[rdi], x1[?], f1[?], x2[?], f2[?], x3[?], f3[?], x4[?], f4[?]
;	, x5[?], f5[?], x6[?], f6[?], x7[?], f7[?], x8[?], f8[?],
;	, x9[?], f9[?]
product_9_f:
	;prologo
	push rbp
	mov rbp, rsp

	;convertimos los flotantes de cada registro xmm en doubles
	; COMPLETAR

	;multiplicamos los doubles en xmm0 <- xmm0 * xmm1, xmmo * xmm2 , ...
	; COMPLETAR

	; convertimos los enteros en doubles y los multiplicamos por xmm0.
	; COMPLETAR

	; epilogo
	pop rbp
	ret

