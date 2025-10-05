/* Funcion recursiva n! */

#include <stdio.h>

void main (void) {
int n;
double factorial (int);

printf ("Introducir n (<=170): ") ; scanf ("%d", &n);
printf ("\n%d! = %20.10g\n", n, factorial(n));
}

/* ------------------------------------------------------------------ */
double factorial (int n) {

if (n <= 1) return 1.0;
return (n*factorial(n-1));
}

