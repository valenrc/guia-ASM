#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>
#include <assert.h>

#include "../test-utils.h"
#include "Memoria.h"

int main() {
	/* Acá pueden realizar sus propias pruebas */
	char* a = "taaa";
	char* b = "taaab";
	uint32_t res = strCmp(a,b);
	printf("%d\n", res);
	return 0;
}
