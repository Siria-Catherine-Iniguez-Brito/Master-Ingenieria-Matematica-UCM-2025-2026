/* Frecuencia de cada letra. Un unico recorrido del vector */

#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define n 10000

main () {
char letra[n];     /* Array con letras mayusculas aleatorias */
int contador[26];  /* contadores de las letras */
int i, j;

srand (time(NULL)); /* semilla para la generacion aleatoria */
for (i=0; i<n; i++) letra[i] = rand()%26+65; /* letras aleatorias */

/* escribe el array generado; consume mucho tiempo de ejecucion */

printf ("Array inicial:\n");
for (i=0; i<n; i++) printf ("%c ",letra[i]);
printf ("\n");

/* recorre una sola vez el array */

for (i=65; i<=90; i++) contador[i-65] = 0;

for (j=0; j<n; j++) contador[letra[j]-65]++;
for (i=65; i<=90; i++) printf ("La letra %c aparece %d veces\n",
                       i, contador[i-65]);
}

