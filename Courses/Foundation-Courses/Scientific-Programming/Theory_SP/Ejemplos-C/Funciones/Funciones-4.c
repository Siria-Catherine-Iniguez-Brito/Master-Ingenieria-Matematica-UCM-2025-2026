/* Funciones matematicas */

#include <math.h>
#include <stdio.h>

main () {
double x, y, ip;
int n, ne;

printf ("%s", "Funciones de un argumento double cualquiera: ");
printf ("\n%s", "Argumento x = ") ; scanf ("%lf", &x);
printf ("\n%s%f", "x = ", x);
printf ("\n%s%f", "fabs(x)  = ", fabs(x));
printf ("\n%s%f", "ceil(x)  = ", ceil(x));
printf ("\n%s%f", "floor(x) = ", floor(x));
printf ("\n%s%f", "exp(x)   = ", exp(x));
printf ("\n%s%f", "sin(x)   = ", sin(x));
printf ("\n%s%f", "cos(x)   = ", cos(x));
printf ("\n%s%f", "tan(x)   = ", tan(x));
printf ("\n%s%f", "atan(x)  = ", atan(x));
printf ("\n%s%f", "sinh(x)  = ", sinh(x));
printf ("\n%s%f", "cosh(x)  = ", cosh(x));
printf ("\n%s%f", "tanh(x)  = ", tanh(x));

printf ("\n\n%s", "Funciones log, log10, sqrt");
printf ("\n%s", "Argumento x = ") ; scanf ("%lf", &x);
printf ("\n%s%f", "x = ", x);
printf ("\n%s%f", "log(x)   = ", log(x));
printf ("\n%s%f", "log10(x) = ", log10(x));
printf ("\n%s%f", "sqrt(x)  = ", sqrt(x));

printf ("\n\n%s", "Funciones modf, frexp");
printf ("\n%s", "Argumento x = ") ; scanf ("%lf", &x);
printf ("\n%s%f", "x = ", x);
printf ("\n%s%f", "modf(x,&ip)  = ", modf(x,&ip));  /* pt. fraccional */
printf (" %s%f", "ip = ", ip);                      /* pt. entera */
printf ("\n%s%f", "frexp(x,&ne) = ", frexp(x,&ne)); /* x = frexp*2**ne  */
printf (" %s%d", "ne = ", ne);                      /* frexp en [0.5,1) */

printf ("\n\n%s", "Funciones asin, acos");
printf ("\n%s", "Argumento x = ") ; scanf ("%lf", &x);
printf ("\n%s%f", "x = ", x);
printf ("\n%s%f", "asin(x)  = ", asin(x));
printf ("\n%s%f", "acos(x)  = ", acos(x));

printf ("\n\n%s", "Funciones pow, fmod, atan2");
printf ("\n%s", "Argumentos x, y = ") ; scanf ("%lf%lf", &x, &y);
printf ("\n%s%f%s%f", "x = ", x, " y = ", y);
printf ("\n%s%f", "pow(x,y)   = ", pow(x,y));   /* x**y */
printf ("\n%s%f", "fmod(x,y)  = ", fmod(x,y));  /* MOD(x,y) con signo de x */
printf ("\n%s%f", "atan2(y,x) = ", atan2(y,x));

printf ("\n\n%s", "Funcion ldexp, argumentos (double, int): ");
printf ("\n%s", "Argumentos x, n = ") ; scanf ("%lf%d", &x, &n);
printf ("\n%s%f%s%d", "x = ", x, " n = ", n);
printf ("\n%s%f", "ldexp(x,n) = ", ldexp(x,n)); /* x*2**n */
printf ("\n");
}

