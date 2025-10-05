/* Cambia mayusculas por minusculas de un fichero con funciones de C 
   y escribe el texto cambiado al reves */

#include <stdio.h>
#include <ctype.h>

void main (void) {
int ch;
char texto[1001];        /* limite de caracteres del texto */
int i, j;
char forigen[20], fdestino[20];
FILE *origen, *destino;

printf ("\nFichero origen: ") ; scanf ("%s", forigen);
origen = fopen (forigen, "r");
printf ("\nFichero destino: ") ; scanf ("%s", fdestino);
destino = fopen (fdestino, "w");

i=0;
while ((ch = getc(origen)) != EOF) {
  if (islower(ch))      /* es minuscula */
    ch = toupper(ch);
  else if (isupper(ch)) /* es mayuscula */
    ch = tolower(ch);
  texto[i++] = ch; }

for (j=i-1; j>=0; j--) putc (texto[j], destino);
printf ("\n");
}

