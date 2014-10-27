#include <stdio.h>

int main() {
	int a = 1; 
	int b = 2;
	int c = a + b;
	
	if (c < 0) {
		c = -c;
	}

	return c;
}
