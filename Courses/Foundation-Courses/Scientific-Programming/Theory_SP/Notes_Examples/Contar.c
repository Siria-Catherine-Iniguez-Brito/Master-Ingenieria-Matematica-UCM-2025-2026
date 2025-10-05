#include <stdio.h>
#include <math.h>

int main(){
    int i, j, contador; 
    int x, y, z; 
    contador = 0; 
    for (i = 100; i <= 999; i++){
        int aux = i; 
        for (j = 1; j < 4; j++){
            if(j==1){
                x = aux %10;
            }
            else if (j==2){
                y = aux%10;
            }
            else{
                z = aux%10;
            }
            aux = aux/10; 
        }; 
        if (i == ( pow(x,3) + pow(y,3) + pow(z,3))){
            contador++; 
        }
    }
    printf("Contador = %d\n", contador); 
    return 0; 
}