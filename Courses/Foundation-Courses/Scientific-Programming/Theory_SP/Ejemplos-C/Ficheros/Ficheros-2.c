/* Realiza una copia de un fichero. Mejor codificacion */

#include <stdio.h>

void main() {
int ch;
char file1[20], file2[20];
FILE *f1, *f2;

printf ("Fichero original: ") ; scanf ("%s", &file1);
f1 = fopen (file1, "r");

if (f1) {
  printf ("Fichero copia: ") ; scanf ("%s", &file2);
  f2 = fopen (file2, "w");
  while ((ch = getc(f1)) != EOF) putc (ch,f2);
  fclose (f1);
  fclose (f2); }
else
  printf ("El fichero %s no existe\n", file1);
}

