/* Realiza una copia de un fichero
   El uso desde linea de comando es ruta>Ficheros-3 origen destino */

#include <stdio.h>
#include <stdlib.h>

/*La funcion tiene argumentos*/
//argc: numero de argumentos que acompañan al ejecutable
//Se va a ejecutar desde la linea de comandos
//En este caso es 3: Ficheros-3.c, Prueba.txt, Salida.txt
void main(int argc, char *argv[]) {
int ch;
FILE *f1, *f2;

if (argc != 3)
  { printf ("El numero de argumentos no es correcto\n") ; exit(0); }
else {
  f1 = fopen (argv[1], "r");
  f2 = fopen (argv[2], "w");
  if (!f1) {
    printf ("El fichero %s no existe!!", argv[1]); exit(0); }
  else {
    while ((ch = getc(f1)) != EOF) putc (ch,f2);
    fclose (f1);
    fclose (f2); }
  }
}
