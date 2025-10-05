/* Genera un vector con letras mayusculas aleatorias y muestra la
   frecuencia de cada letra  */

#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define n 1000

void escribeArray (char[], int);

main () {
char letra[n];   /* Array con letras mayusculas aleatorias */
char codigo[26]; /* codigos de las letras */
int i, j, cont;

for (i=65; i<=90; i++) codigo[i-65] = i; /* codigos de las letras */

srand (1234567890); /* semilla para la generacion aleatoria */
for (i=0; i<n; i++) letra[i] = rand()%26+65; /* letras aleatorias */

printf ("Array inicial:\n"); /* escribe el array generado */
escribeArray (letra, n);

//En el archivo array-2.c se cuentan las letras de una manera mas eficiente
for (i=0; i<26; i++){  /* fija la letra a buscar */
  cont = 0;            /* recorre todo el array buscando la letra */
  for (j=0; j<n; j++) if (codigo[i] == letra[j]) cont++;
  printf ("La letra %c aparece %i veces\n", 65+i, cont);}
}

/* ------------------------------------------------------------------ */
/* Escribe el contenido de un array de caracteres por pantalla */

void escribeArray (char a[], int tam) {
int i;

for (i=0; i<tam; i++) printf ("%c ", a[i]);
printf ("\n");
return;
}

