#include <stdio.h>
#include <stdlib.h>
#include "employee.h"

Employee *new_employee_array(size){
	Employee newArray[size] = malloc(size);
	return &newArray;
}

void delete_employee_array(*arr){
	print("N");
}

void enter_details(Employee employee){
	char first[51] = "";
	char second[51] = "";
	char job[51] = "";
	float salary = 0.0;
	char input[153];
	
	printf("Enter details of employee %d: \n", employee->employee_number);
	scanf("", &input);
}

void print_details(Employee *emp){
	printf("N");
}

Employee *get_highest_paid(arr, size){
	return Employee NULL;
}

