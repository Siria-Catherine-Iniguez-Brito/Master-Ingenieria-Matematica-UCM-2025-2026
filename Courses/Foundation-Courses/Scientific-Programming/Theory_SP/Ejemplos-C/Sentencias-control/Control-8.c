/* Cambia mayusculas por minusculas mediante funciones de C y escribe
   el texto cambiado al reves */

#include <stdio.h>
#include <ctype.h>

void main (void) {
  int ch;
  const int nmax=10;
  char texto[nmax];        /* limite de caracteres del texto */
  int i, j;

  printf ("Introduce un texto de no mas de %d caracteres.\n", nmax);
  printf ("Pulsa ^Z para finalizar:\n");

  i = 0;
  while ((ch = getchar()) != EOF) {
    if (i >= nmax) break;
    if (islower(ch))      /* es minuscula */
      ch = toupper(ch);
    else if (isupper(ch)) /* es mayuscula */
      ch = tolower(ch);
    texto[i++] = ch; }

  printf ("\ni = %d\n", i);

  for (j=i-1; j>=0; j--) printf ("%c", texto[j]);
  printf ("\n");
}

