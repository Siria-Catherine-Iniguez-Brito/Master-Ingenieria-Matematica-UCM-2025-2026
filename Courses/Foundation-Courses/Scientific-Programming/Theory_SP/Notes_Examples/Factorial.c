#include <stdio.h>

int main(){
    int n; 

    //Solicitar al usuario que introduzca un numero
    printf("Introduce un numero entero positivo: "); 
    scanf("%d", &n); 

    //Validación simple (opcional)
    if(n < 0){
        printf("El numero debe de ser positivo.\n");
        return 1; 
    }

    int cociente = n ; 
    int contar = 0; 

    //Cuenta los ceros finales de n!
    while(cociente > 0){
        cociente /= 5; 
        contar += cociente; 
    }

    printf("Ceros finales en %d!= %d\n", n, contar);
    return 0; 
}