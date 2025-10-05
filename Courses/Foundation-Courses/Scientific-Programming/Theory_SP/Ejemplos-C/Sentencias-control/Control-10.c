/* Estructura de control switch sin break */

#include <stdio.h>
main () {
  int indice, resultado;

  printf ("Introducir un numero de orden = ") ; scanf ("%d", &indice);

  switch (indice) {
    case 1:
      printf ("Has puesto el numero 1\n");
      resultado = 1000;
    case 2:
      printf ("Has puesto el numero 2\n");
      resultado = 2000;
    case 3:
      printf ("Has puesto el numero 3\n");
      resultado = 3000;
  }
  printf ("\nEl resultado es %d\n", resultado);
}

