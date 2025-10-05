/* Realiza una copia de un fichero de texto*/

#include <stdio.h>

void main() {
int ch;
char file1[20], file2[20];
FILE *f1, *f2;

printf ("Fichero original: ") ; scanf ("%s", &file1);
printf ("Fichero copia: ") ; scanf ("%s", &file2);

f1 = fopen (file1, "r");  /* f1 sera >0 si fopen se ejecuta sin error */
f2 = fopen (file2, "w");
if (!f1)
  { printf ("El fichero %s no existe\n", file1); return; }
else
  while ((ch = getc(f1)) != EOF) putc (ch,f2);

fclose (f1);
fclose (f2);
}

