/* Cambia mayusculas por minusculas de un fichero y escribe el texto
   cambiado al reves */
//Pasar como fichero de entrada un txt con el texto del quijote.
#include <stdio.h>

void main (void) {
int ch;
char texto[1001];        /* limite de caracteres del texto */
int i, j, dif;
char forigen[20], fdestino[20];
FILE *origen, *destino;

printf ("\nFichero origen: ") ; scanf ("%s", forigen);
origen = fopen (forigen, "r");
printf ("\nFichero destino: ") ; scanf ("%s", fdestino);
destino = fopen (fdestino, "w");

dif = 'a'-'A';   /* constante con valor 32 generalmente */

i=0;
while ((ch = getc(origen)) != EOF) {
  if ((ch>='a') && (ch<='z'))      /* es minuscula */
    ch -= dif;
  else if ((ch>='A') && (ch<='Z')) /* es mayuscula */
    ch += dif;
  texto[i++] = ch; }

for (j=i-1; j>=0; j--) putc (texto[j], destino);
printf ("\n");

}

