#include <stdio.h>

typedef struct EMPLOYEE{
	int employee_number;
	char* firstName[50];
	char* lastName[50];
	char* jobTitle[50];
	float salary;
} Employee;

Employee *new_employee_array(int size);

void delete_employee_array();

void enter_details(Employee *employee);

void print_details(Employee *emp);

Employee *get_highest_paid(arr, size);

