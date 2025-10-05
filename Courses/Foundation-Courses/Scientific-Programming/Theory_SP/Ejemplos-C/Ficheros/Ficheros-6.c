/* Cuenta caracteres, palabras y lineas de un fichero */

#include <stdio.h>

void main (void) {
int car, enpalabra;
float numcar, numpal, numlin, mediapal;
char fichero[20];
FILE *fi;

printf ("\nNombre del fichero : ") ; scanf ("%s", fichero);
fi = fopen (fichero, "r");

numcar = numpal = numlin = 0;
enpalabra = 0;

while ((car = getc(fi)) != EOF) {
  if (car!=' ' && car!='\n' && car!='\t') ++numcar;
  if (car == '\n') ++numlin;
  if (car==' ' || car=='\n' || car=='\t') enpalabra=0;
  else if (enpalabra == 0)
    {enpalabra = 1 ; ++numpal;}
  }
mediapal = numcar / numpal;
printf ("Numero de caracteres no blancos        = %10.0f\n", numcar);
printf ("Numero de palabras                     = %10.0f\n", numpal);
printf ("Numero de lineas                       = %10.0f\n", numlin);
printf ("Numero medio de caracteres por palabra = %10.2f\n", mediapal);
}

