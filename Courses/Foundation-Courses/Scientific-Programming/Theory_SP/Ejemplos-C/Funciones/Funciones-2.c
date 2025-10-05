/* Uso de funciones */

#include <stdio.h>
#define nmax 100

/* declaracion de funciones */

float media (float*, int);
float maximo (float*, int);
float minimo (float*, int);
float semisuma (float, float);

void main (void) {
float vec[nmax];
int n, i;

printf ("Numero de datos (<=100) = ") ; scanf ("%d", &n);
printf ("\nIntroduce los %d datos:\n", n);
for (i=0; i<n; i++) {
  printf ("Dato %d: ", i+1) ; scanf ("%f", &vec[i]); }

printf ("\n");
printf ("media   = %7.2f \n", media(vec,n));
printf ("maximo  = %7.2f \n", maximo(vec,n));
printf ("minimo  = %7.2f \n", minimo(vec,n));
printf ("semisuma= %7.2f \n", semisuma(maximo(vec, n), minimo(vec, n)));
}

/* ------------------------------------------------------------------ */
float media (float* x, int num) {
float suma=0.0, med;
int i;

for (i=0; i<num; i++) suma += x[i];
med = suma/num;
return (med);
}

/* ------------------------------------------------------------------ */
float minimo (float* x, int num) {
int i;
float min;

min = x[0];
for (i=1; i<num; i++)
  if (x[i] < min) min = x[i];
return (min);
}

/* ------------------------------------------------------------------ */
float maximo (float* x, int num) {
int i;
float max;

max = x[0];
for (i=1; i<num; i++)
  if (x[i] > max) max = x[i];
return (max);
}

/* ------------------------------------------------------------------ */
float semisuma (float max, float min) {

return ((max+min)/2.0);
}

