#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>
#include <assert.h>

#include "../test-utils.h"
#include "ABI.h"

int main() {
	/* Acá pueden realizar sus propias pruebas */
	uint32_t res = alternate_sum_8(822, 230, 481, 566, 592, 70, 838, 216); // esperado: 1651 (822, 230, 481, 566) + (592, 70, 838, 216) = 507 + 1114 = 1651
	printf("%d\n", res);
	//assert(alternate_sum_4_using_c(8, 2, 5, 1) == 6);
	//int res = 0;
	//product_2_f(&res, 489, 465.01);  // res = 227389,89 = 227388
	return 0;
}
