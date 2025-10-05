/* Encuentra el mayor y el menor elemento de un array */

#include <stdio.h>

void mayormenor (double*, int, double**, double**);
void sin_punteros (double*, int, int*, int*);

int main () {
double x[]={1.1,8.8,2.2,7.7,3.3,6.6,4.4,5.5};
double *mx, *mn; /* Punteros al menor y mayor valor del array */
int imayor, imenor;

mayormenor (x, 8, &mx, &mn);
printf ("Mayor %lf\nMenor %lf\n", *mx, *mn);

sin_punteros (x, 8, &imayor, &imenor);
printf ("Mayor %lf\nMenor %lf\n", x[imayor], x[imenor]);
}

/* ------------------------------------------------------------------ */
void mayormenor (double *a, int t, double **mayor, double **menor) {
int i;

*mayor = a ; *menor = a;  /* puntero al primer elemento de a */
for (i=1; i<t; i++){
  if (a[i] > **mayor) *mayor = &a[i];
  if (a[i] < **menor) *menor = &a[i]; }
}

/* ------------------------------------------------------------------ */
void sin_punteros (double *a, int t, int *mayor, int *menor) {
  int i;
  double amas, amenos;

  amas = a[0] ; amenos = a[0];
  *mayor = 0 ; *menor = 0;
  for (i=1; i<t; i++){
    if (a[i] > amas) {*mayor = i; amas = a[i];}
    if (a[i] < amenos) {*menor = i; amenos = a[i];}
  }
}

