/* Crea matrices dinamicas en una funcion y las multiplica */

#include <stdio.h>
#include <stdlib.h>

void main (void) {       /* Programa principal */
int i, j, k, m, n, cont;
double **a, **b, **c;
double **creamatriz (int, int);
void mult (int, int, int, double**, double**, double**);

seguir: ;
printf ("Crea matrices dinamicas a(m,n), b(n,k), c(m,k), con c=a.b");
printf ("\nIntroduce m, n, k: "); scanf ("%d%d%d", &m, &n, &k);

a = creamatriz (m, n);
b = creamatriz (n, k);
c = creamatriz (m, k);

printf ("\nElementos de a:\n");
for (i=0; i<m; i++)
  for (j=0; j<n; j++) {
    printf ("a(%2i,%2i)= ", i, j); scanf (" %lf", &a[i][j]); }

printf ("\n\nElementos de b:\n");
for (i=0; i<n; i++)
  for (j=0; j<k; j++) {
    printf ("b(%2i,%2i)= ", i, j); scanf (" %lf", &b[i][j]); }

mult (m, n, k, a, b, c);

free (a);
free (b);
free (c);

printf ("\n\nElementos de c = a.b:\n");
for (i=0; i<m; i++)
  for (j=0; j<k; j++)
    printf ("\nc(%2i,%2i)= %10.1f", i, j, c[i][j]);

printf ("\n\nContinuar (1:Si/0:No) ? ") ; scanf ("%d", &cont);
if (cont == 1) goto seguir;
}

/* ------------------------------------------------------------------ */
/* Crea una matriz (m,n) dinamica */

double **creamatriz (int m, int n) {
double **mat;
int i;

mat = (double **) calloc (m, sizeof(double *));
mat[0] = (double *) calloc (m*n, sizeof(double));
for (i=1; i<m; i++)
  mat[i] = mat[i-1] + n;
return mat;
}

/* ------------------------------------------------------------------ */
/* Multiplica matrices */

void mult (int m, int n, int k, double **a, double **b,double **c) {
double sum;
int i, j, l;

for (i=0; i<m; i++)
  for (j=0; j<k; j++) {
    sum = 0.0;
    for (l=0; l<n; l++) sum += a[i][l]*b[l][j];
    c[i][j] = sum; }
return;
}

