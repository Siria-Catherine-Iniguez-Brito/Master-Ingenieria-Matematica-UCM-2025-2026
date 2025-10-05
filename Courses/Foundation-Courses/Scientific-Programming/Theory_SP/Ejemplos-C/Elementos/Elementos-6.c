/* Uniones */

#include <stdio.h>

main() {
union tipovariable {
  int i;
  float f;
  double d;
  char c;} tv;/* tv tendra tamaño suficiente para el mayor de los tipos */

tv.i = 3;
printf ("\nEntero = %d\n", tv.i);
tv.f = 3.45F;
printf ("\nReal = %f\n", tv.f);
tv.d = 3.67L;
printf ("\nDoble = %lf\n", tv.d);
tv.c = 'k';
printf ("\nCaracter = %c\n", tv.c);
}