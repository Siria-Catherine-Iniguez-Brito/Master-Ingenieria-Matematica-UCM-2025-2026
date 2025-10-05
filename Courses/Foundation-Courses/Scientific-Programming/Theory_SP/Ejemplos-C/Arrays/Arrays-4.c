/* Suma de arrays mediante subindices y mediante punteros */

#include <stdio.h>
#define NF 4
#define NC 5

main() {
int j, k;
int a1[NF][NC] = { {13,15,17,19,21},
                   {20,22,24,26,28},
                   {31,33,35,37,39},
                   {40,42,44,46,48} };

int a2[NF][NC] = { {10,11,12,13,14},
                   {15,16,17,18,19},
                   {20,21,22,23,24},
                   {25,26,27,28,29} };
int a3[NF][NC], a4[NF][NC], a5[NF][NC];

/* si a es un array de dimensiones a[M][N] la direccion del elemento 
   (i,j) es dir(0,0) + i*M + j 
   *(*(a+j)+k) es a[j][k]                                              */

for (j=0; j<NF; j++) {
  for (k=0; k<NC; k++) {
    a3[j][k] = a1[j][k] + a2[j][k];               /* subindices */
    *(*(a4+j)+k) = *(*(a1+j)+k) + *(*(a2+j)+k);   /* posicion */
    *(a5[j]+k) = *(a1[j]+k) + *(a2[j]+k);         /* desplazamiento */
    printf ("\n%d   %d    %d ", a3[j][k], *(*(a4+j)+k), *(a5[j]+k)); }
  printf ("\n"); }
}

