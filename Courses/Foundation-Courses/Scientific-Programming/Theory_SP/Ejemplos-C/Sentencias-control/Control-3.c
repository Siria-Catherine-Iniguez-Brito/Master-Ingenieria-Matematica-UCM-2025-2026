/* Bucle for */

#include <stdio.h>

main () {
  int i;
  float c;

  for (i=0; i<=300; i+=20) {
    c = (5./9) * (i-32);        /* 5/9 es 0 */
    printf ("%3d grados Farenheit son %8.4f grados Celsius\n", i, c); }
}

