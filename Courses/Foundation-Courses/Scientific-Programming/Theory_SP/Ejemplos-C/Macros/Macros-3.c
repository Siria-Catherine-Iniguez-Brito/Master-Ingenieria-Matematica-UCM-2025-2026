/* Expansion de macros */

#include <stdio.h>

#define cambio(x, y, temp) temp = x ; x = y ; y = temp;
     /* error si se pone espacio antes del parentesis: cambio (...*/

main () {
int n1, n2, n3;
float x1, x2, x3;

printf ("Primer numero entero  = ") ; scanf ("%d", &n1);
printf ("Segundo numero entero = ") ; scanf ("%d", &n2);
cambio (n1, n2, n3);
printf ("\nSe han intercambiado los valores:");
printf ("\nPrimer numero  = %d", n1);
printf ("\nSegundo numero = %d", n2);

printf ("\n\nPrimer numero real  = ") ; scanf ("%f", &x1);
printf ("Segundo numero real = ") ; scanf ("%f", &x2);
cambio (x1, x2, x3);
printf ("\nSe han intercambiado los valores:");
printf ("\nPrimer numero  = %f", x1);
printf ("\nSegundo numero = %f\n", x2);
}

