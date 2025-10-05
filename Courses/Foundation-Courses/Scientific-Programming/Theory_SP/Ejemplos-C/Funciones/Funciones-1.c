/* Funciones. Paso de argumentos por valor y por referencia */

#include <stdio.h>

main () {
int n1, n2;
void cambio_valor (int, int);
void cambio_referencia (int*, int*);

printf ("Primer numero  = ") ; scanf ("%d", &n1);
printf ("Segundo numero = ") ; scanf ("%d", &n2);

/* paso por valor */

printf ("\nPaso por valor:\n");
cambio_valor (n1, n2);
printf ("\nNo se han intercambiado los valores:");
printf ("\nPrimer numero  = %d", n1);
printf ("\nSegundo numero = %d", n2);

/* paso por referencia */

printf ("\n\nPaso por referencia:\n");
cambio_referencia (&n1, &n2);
printf ("\nSi se han intercambiado los valores:");
printf ("\nPrimer numero  = %d", n1);
printf ("\nSegundo numero = %d", n2);
printf ("\n");
}

/* ------------------------------------------------------------------ */
/* Paso por valor (copias de los argumentos) */

void cambio_valor (int m, int n) {
int aux;

printf ("\nValor del primer numero  = %d", m);
printf ("\nValor del segundo numero = %d", n);

aux = m ; m = n ; n = aux;
}

/* ------------------------------------------------------------------ */
/* Paso por referencia (direcciones de los argumentos) */

void cambio_referencia (int *m, int *n) {
int aux;

printf ("\nPrimer numero  = %d", *m);
printf ("\nSegundo numero = %d", *n);

printf ("\nDireccion del primer argumento  = %d", m);
printf ("\nDireccion del segundo argumento = %d", n);

aux = *m ; *m = *n ; *n = aux;
}

