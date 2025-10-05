/* Relacion entre caracteres y codigos ASCII */

#include <stdio.h>

main () {
  int i;
  char c;      /* tipo char ~ enteros en [0,127] */

  for (i=0; i<=127; i++) {c = i;     /* probar i<=1000 c=MOD(i,128) */
  printf ("Codigo ASCII: %d  caracter: %c", i, i);
  printf ("    Codigo ASCII: %d  caracter: %c\n", c, c);}
}
