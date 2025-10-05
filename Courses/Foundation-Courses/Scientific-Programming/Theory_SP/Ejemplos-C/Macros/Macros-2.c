/* Sustitucion de macros. Una macro no es una funcion */

#include <stdio.h>

#define POT2(x) x*x
#define POT6(x) (POT2(x)*POT2(x)*POT2(x))
#define CUADRADO(x) (x)*(x)

main () {
int m;
float a;

printf ("Numero entero m: ") ; scanf ("%d", &m);
printf ("m**2 = %d\n", POT2(m));
printf ("m**6 = %d\n", POT6(m));

printf ("\nNumero real a: ") ; scanf ("%f", &a);
printf ("a**2 = %f\n", POT2(a));
printf ("a**6 = %f\n", POT6(a));

/* Atencion a los parentesis */

printf ("\nAtencion a los parentesis:\n");
printf ("\nm+1*m+1 = %d\n",   POT2(m+1));
printf ("(m+1)*(m+1) = %d\n", POT2((m+1)));
printf ("(m+1)**2 = %d\n",    CUADRADO(m+1));

printf ("\na+1*a+1 = %f\n",   POT2(a+1));
printf ("(a+1)*(a+1) = %f\n", POT2((a+1)));
printf ("(a+1)**2 = %f\n",    CUADRADO(a+1));
}

