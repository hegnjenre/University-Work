#include <stdio.h>

int main(void){

	char c = 'b';
	short s = 10;
	int i = 100;
	long l = 1000;
	float f = 1.1;
	double d = 2.2;
	int arr[10] = {1,2,3,4,5,6,7,8,9,10};
	char str[6] = "Hello";

	//printf("%c, %d, %d, %ld, %f, %lf, %d, %s\n", c, s, i, l, f, d, arr[4], str);
	printf("%d, %c\n", c, i);

	return 0;
	
}