/* Dimensiona un vector v(m:n) */

#include <stdio.h>
#include <stdlib.h>

main () {
int *vectormn (int, int);

int *v1, *v2, *suma;
int m, n, j;

m = 30 ; n = 40;
v1 = vectormn (m, n);
v2 = vectormn (m, n);
suma = vectormn (m,n);

for (j=m; j<=n; j++) {
  v1[j] = j ; v2[j] = 2*j;
  suma[j] = v1[j] + v2[j];
  printf ("%d  %d  %d\n", v1[j], v2[j], suma[j]);}
free (v1); free (v2); free (suma);

printf ("\n");
m = -10 ; n = 5;
v1 = vectormn (m, n);
v2 = vectormn (m, n);
suma = vectormn (m,n);

for (j=m; j<=n; j++) {
  v1[j] = j ; v2[j] = 2*j;
  suma[j] = v1[j] + v2[j];
  printf ("%d  %d  %d\n", v1[j], v2[j], suma[j]);}
free (v1); free (v2); free (suma);

printf ("\n");
m = 0 ; n = 7;
v1 = vectormn (m, n);
v2 = vectormn (m, n);
suma = vectormn (m,n);

for (j=m; j<=n; j++) {
  v1[j] = 3*j ; v2[j] = 2*j;
  suma[j] = v1[j] + v2[j];
  printf ("%d  %d  %d\n", v1[j], v2[j], suma[j]);}
free (v1); free (v2); free (suma);

printf ("\n");
m = -10 ; n = -20;
v1 = vectormn (m, n);
v2 = vectormn (m, n);
suma = vectormn (m,n);

for (j=m; j<=n; j++) {
  v1[j] = j ; v2[j] = 2*j;
  suma[j] = v1[j] + v2[j];
  printf ("%d  %d  %d\n", v1[j], v2[j], suma[j]);}
free (v1); free (v2); free (suma);

}

/* Crea el vector v[m],...,v[n] */

int *vectormn (int m, int n) {
int *v;

if (m > n) {printf ("\n ERROR m>n \n");exit(1);}

v = (int *) calloc (n-m+1,sizeof(int));
if (m>0) v = v - m;
if (m<0) v = v + m;
return v;
}