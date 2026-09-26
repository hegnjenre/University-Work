#include <stdio.h>

void print_array(int* ptr, int len){
	for(int offset = 0; offset<len; offset++){
		int curArr = *(ptr+offset);
		if(offset+1 < len){
		    printf("%d, ", curArr);
		}
		else{
		    printf("%d ", curArr);
		}
	}
	printf("\n");
}

void print_2d_array(char* ptr, int col, int row){
	int ptrOffsetMult = (row-1);
	for(int offsetCol = 0; offsetCol < col; offsetCol++){
		printf("\n%d -", offsetCol); //debug
		for(int offsetRow = 0; offsetRow < row; offsetRow++){
			printf("\n %d: \n", offsetRow); //debug
			if(offsetRow+1 < row){
				printf("%c, ", *(ptr+(offsetCol*ptrOffsetMult)+(offsetRow+offsetCol))); 
				// (offsetRow+offsetCol) add offsetCol because 0,4 (ptr+(0*4)+4) is the same as 1,0 (ptr+(1*4)+0) without it
			}
			else{
				printf("%c", *(ptr+(offsetCol*ptrOffsetMult)+(offsetRow+offsetCol)));
			}
		}
	}
	printf("\n");
	
}

int main(){
	
	int arr[10] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10};
	int* pointArr = &arr[0];
	
	print_array(pointArr, 10); 
	
		
char arr2[2][4] = {
		{'F', 'I', 'Z', 'Z'},
		{'B', 'U', 'Z', 'Z'}};

	
	char* pointArr2 = &arr2[0][0];
	
	print_2d_array(pointArr2, 2, 4);
	
	return 0;
}

