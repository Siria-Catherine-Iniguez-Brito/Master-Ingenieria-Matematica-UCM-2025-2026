/* Numeros aleatorios. Tiempo de calculo */

#include <stdlib.h>
#include <stdio.h>
#include <time.h>

main () {
int n=10000000, i;
double x, suma, t1, t2;
/* t1 y t2 se pueden declarar con tipo float, double o clock_t */

t1 = clock();
suma = 0;
for (i=1; i<=n; i++) {
  x = double(rand())/RAND_MAX; 
  suma += x;
}
t2 = clock();

printf ("%s%f\n", "media = ", suma/n);
printf ("%s%f\n", "tiempo CPU = ", t2-t1);
printf ("maxima constante RAND_MAX = %d\n", RAND_MAX);
}

