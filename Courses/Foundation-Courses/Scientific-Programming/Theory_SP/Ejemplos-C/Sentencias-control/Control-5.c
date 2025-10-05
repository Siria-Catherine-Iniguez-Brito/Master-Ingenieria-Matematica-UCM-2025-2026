/* Suma de 1+...+5. while, do while, for */

#include <stdio.h>

void main (void) {
  int suma=0, i=1;

  while (i<=5) {      /* se ejecuta el bloque mientras i<=5 */
    suma += i; ++i; }
  printf ("suma while = %d\n", suma);

  suma = 0 ; i = 1;
  while (1)           /* bucle infinito; se sale con break */
    {if (i>5) break;
     suma += i; ++i;}
  printf ("suma while(1) = %d\n", suma);

  suma = 0 ; i = 1;
  do {
    suma += i; ++i; } while (i<=5);
  printf ("suma do-while = %d\n", suma);

  suma = 0 ; i = 1;
  for ( ; i<=5; ) {                       /* primera forma */
    suma += i; ++i; }
  printf ("suma 1 = %d\n", suma);

  suma = 0;                               /* segunda forma */
  for (i=1; i<=5; ++i) suma+=i;
  printf ("suma 2 = %d\n", suma);

  /* En la tercera forma se evalua i y suma, como primero esta i 
  se evalua primero i y despues suma, es decir i = 1 suma 0; i = 2 suma= 0 + 2*/
  for (i=1, suma=0; i<=5; ++i, suma+=i);  /* tercera forma (mal) */
  printf ("suma 3 = %d\n", suma);         /* 2+3+4+5+6 */

  for (i=1, suma=0; i<=5; suma+=i, ++i);  /* cuarta forma */
  printf ("suma 4 = %d\n", suma);
}

