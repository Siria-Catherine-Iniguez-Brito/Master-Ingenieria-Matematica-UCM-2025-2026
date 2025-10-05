/* Crea matrices dinamicas y las multiplica */

#include <stdio.h>
#include <stdlib.h>

void main (void) {       /* Programa principal */
int i, j, k, m, n;
double **a, **b, **c;
void mult (int, int, int, double**, double**, double**);

printf ("Crea matrices dinamicas a(m,n), b(n,k), c(m,k), con c=a.b");
printf ("\nIntroduce m, n, k: "); scanf ("%d%d%d", &m, &n, &k);

/* calloc inicializa a 0 los bloques que reserva; devuelve un puntero
   a la primera celda reservada */

a = (double **) calloc (m, sizeof(double *));
a[0] = (double *) calloc (m*n, sizeof(double));
for (i=1; i<m; i++) a[i] = a[i-1] + n;

b = (double **) calloc (n, sizeof(double *));
b[0] = (double *) calloc (n*k, sizeof(double));
for (i=1; i<n; i++) b[i] = b[i-1] + k;

c = (double **) calloc (m, sizeof(double *));
c[0] = (double *) calloc (m*k, sizeof(double));
for (i=1; i<m; i++) c[i] = c[i-1] + k;

printf ("\nElementos de a:\n");
for (i=0; i<m; i++)
  for (j=0; j<n; j++) {
    printf ("a(%2i,%2i)= ", i, j); scanf (" %lf", &a[i][j]); }

printf ("\n\nElementos de b:\n");
for (i=0; i<n; i++)
  for (j=0; j<k; j++) {
    printf ("b(%2i,%2i)= ", i, j); scanf (" %lf", &b[i][j]); }

mult (m, n, k, a, b, c);

free (a);  /* libera de la memoria */
free (b);

printf ("\n\nElementos de c = a.b:\n");
for (i=0; i<m; i++)
  for (j=0; j<k; j++)
    printf ("\nc(%2i,%2i)= %10.1f", i, j, c[i][j]);
printf ("\n");
}

/* ------------------------------------------------------------------ */
/* Multiplica matrices */

void mult (int m, int n, int k, double **a, double **b, double **c) {
double sum;
int i, j, l;

for (i=0; i<m; i++)
  for (j=0; j<k; j++) {
    sum = 0.0;
    for (l=0; l<n; l++) sum += a[i][l]*b[l][j];
    c[i][j] = sum; }
return;
}

