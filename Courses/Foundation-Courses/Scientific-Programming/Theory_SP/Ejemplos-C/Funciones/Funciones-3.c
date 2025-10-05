/* Producto escalar y vectorial */

#include <stdio.h>

void pvectorial (double*, double*, double*);
double pescalar (double*, double*);

void main(void) {
double v1[3], v2[3], pvect[3];
int i;

printf ("Primer vector:\n");
for (i=0; i<3; i++) {
  printf ("Elemento %d: ", i+1) ; scanf ("%lf", &v1[i]); }

printf ("\nSegundo vector:\n");
for (i=0; i<3; i++) {
  printf ("Elemento %d: ", i+1) ; scanf ("%lf", &v2[i]); }

printf ("\nProducto escalar = %lf\n", pescalar (v1, v2));

pvectorial (v1, v2, pvect);
printf ("\nProducto Vectorial");
for (i=0; i<3; i++) printf ("    %lf", pvect[i]);
printf ("\n");
}

/* ------------------------------------------------------------------ */
void pvectorial (double* x, double* y, double* z) {

z[0] = x[1]*y[2]-y[1]*x[2];
z[1] = x[2]*y[0]-y[2]*x[0];
z[2] = x[0]*y[1]-y[0]*x[1];
return;
}

/* ------------------------------------------------------------------ */
double pescalar (double* x, double* y) {
double escalar = 0.0;
int i;

for (i=0; i<3; i++)
escalar += x[i]*y[i];
return (escalar);
}

