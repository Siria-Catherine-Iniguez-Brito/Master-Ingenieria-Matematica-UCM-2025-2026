/* Macro para sustitucion de constantes simbolicas*/

#include <stdio.h>
#define n1 10
#define n2 100

main () {
  int suma, i;
  suma = 0;
  for (i=n1; i<=n2; ++i) suma+=i;
  printf ("suma = %d\n", suma);
}

