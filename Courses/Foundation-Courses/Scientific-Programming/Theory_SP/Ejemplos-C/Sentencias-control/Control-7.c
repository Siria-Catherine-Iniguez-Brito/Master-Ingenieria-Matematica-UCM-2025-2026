/* Este programa convierte mayusculas en minusculas y viceversa
   y escribe el texto cambiado al reves */

#include <stdio.h>

void main (void) {
  int ch;
  const int nmax=10;
  char texto[nmax];        /* limite de caracteres del texto */
  int i, j, dif;

  dif = 'a'-'A';           /* constante con valor 32 generalmente */

  printf ("Introduce un texto de no mas de %d caracteres.\n", nmax);
  printf ("Pulsa ^Z para finalizar:\n");

  i = 0;
  while ((ch = getchar()) != EOF) {
    if (i >= nmax) break;
    if ((ch>='a') && (ch<='z'))      /* es minuscula */
       ch -= dif;
    else if ((ch>='A') && (ch<='Z')) /* es mayuscula */
       ch += dif;
    texto[i++] = ch; }

  printf ("\ni = %d\n", i);

  for (j=i-1; j>=0; j--) printf ("%c", texto[j]);
  printf ("\n");
}

