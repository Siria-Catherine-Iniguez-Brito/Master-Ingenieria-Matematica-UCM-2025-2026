/* Lectura y escritura en pantalla. Expresiones */

#include <stdio.h>

main () {
  float altura, base;
  double area;

  printf ("Base del triangulo = ") ; scanf ("%f", &base);
  printf ("Altura del triangulo = ") ; scanf ("%f", &altura);

  area = 0.5 * altura * base;
  printf ("Area = %28.14lf\n", area);

/* Una asignacion es una expresion cuyo valor es el del lado izquierdo
   despues de realizarse la asignacion */

  printf ("Area = %28.14lf\n", area = 0.5 * altura * base);
}

