#include <stdio.h>

int str_len(char* str){
	int count = 0;  /* -1 because we don't count the \0 */
	int cont = 0; /* "boolean" for continuing loop */
	int i = 0;
	while(cont == 0){
		if(*((str+i)+1) != 0){ /* if next two characters are not "\0" */
			count++;
		}
		else{
			count++;
			cont = 1;
		}
		i++;
	}
	return count;
}

void str_cpy(char* src, char* dest){
	int i = 0;
	while(*(src+i) != 0){
		*(dest+i) = *(src+i);
		i++;
	}
	*(dest+i) = 0;
}

int main(){
		
	char* str = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
	
	printf("%s is %d characters long!\n", str, str_len(str));
	
	/* This part tests only str_cpy, uncomment it when str_len is working */

	char str2[100] = "XXXXXXXXXXXXXXXXXXXXXXXXXX   If you're reading this, you probably forgot a '\\0'!";
	
	str_cpy(str, str2);
	
	printf("Copied from:\t%s\nCopied to:\t%s\n", str, str2);
	
	return 0;
}
