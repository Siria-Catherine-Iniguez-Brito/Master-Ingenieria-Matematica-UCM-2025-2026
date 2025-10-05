#include <stdio.h>

void main(){
    int var1, var2; 
    int *punt1;

    var1 = 2; 
    var2 = 11; 
    punt1 = &var1; 

    printf("\nVariable var1 = %d", var1); 
    printf("\nVariable punt1 = %d\n", *punt1); 
    printf("\nVariable var2 = %d\n", var2); 
    
    *punt1 = 40; 
    printf("\nVariable var1 = %d", var1); 
    printf("\nVariable punt1 = %d", *punt1); 
    printf("\nVariable var2 = %d\n", var2); 

    punt1 = &var2; 
    *punt1 = 40; 
    printf("\nVariable var1 = %d", var1); 
    printf("\nVariable punt1 = %d",*punt1); 
    printf("\nVariable var2 = %d \n", var2); 

}