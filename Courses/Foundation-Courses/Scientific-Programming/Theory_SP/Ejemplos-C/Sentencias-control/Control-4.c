/* Bucle for. Condicion de realizacion con variables no enteras */

#include <stdio.h>

main () {
  float x, xx;
  int iter;

/* Probar las siguientes condiciones de realizacion del bucle for:

  x<=3, x!=3, x<=2, x!=2

  y observar lo que ocurre */

  iter = 0;
  for (x=0.1; x<=3; x+=0.1) {
    iter += 1;
    xx = x*x;
    printf ("%s%5.1f%s%8.2f\n", "x = ", x, "   x**2 = ", xx); }
  printf ("\n%s%d\n", "iter = ", iter);
}

