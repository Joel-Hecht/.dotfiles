#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

#define ONE 1

int main() {
	float one = 1.0;
	if (ONE + one == 2) {
		printf("%d + %f = 2\n", ONE, one);
		return 0;
	} else {
		printf("what\n");
		return 1;
	}
}
