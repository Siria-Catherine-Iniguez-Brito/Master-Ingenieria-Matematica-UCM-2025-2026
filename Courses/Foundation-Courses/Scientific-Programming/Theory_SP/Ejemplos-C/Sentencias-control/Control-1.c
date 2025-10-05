/* Resolucion de la ecuacion de segundo grado. Bloques if */

#include <stdio.h>
#include <math.h>

void main (void) {
  double a, b, c;
  double discr, x1, x2, xr, xi;

  printf ("Escribe los valores de los coeficientes a, b y c: ");
  scanf ("%lf%lf%lf", &a, &b, &c);

  discr = b*b - 4.0*a*c;
  if (discr > 0.0) {
    x1 = (-b+sqrt(discr))/(2.0*a);
    x2 = (-b-sqrt(discr))/(2.0*a);
    printf ("\nLas dos raices reales son: %12.6e y %12.6e\n", x1, x2); }
  else if (discr < 0.0) {
    xr = -b/(2.0*a);
    xi = sqrt(-discr)/(2.0*a);
    printf ("\nRaices complejas:\n");
    printf ("(%12.6e, %12.6e) y (%12.6e, %12.6e)\n", xr, xi, xr, -xi); }
  else {
    x1 = -b/(2.0*a);
    printf ("\nLas dos raices son iguales y valen: %12.6e\n", x1); }
}

