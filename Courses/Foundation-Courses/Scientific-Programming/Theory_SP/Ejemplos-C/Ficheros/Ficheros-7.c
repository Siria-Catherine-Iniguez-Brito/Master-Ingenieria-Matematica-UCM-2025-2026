/* Simula el comando more para ver un fichero por pantallas */

#include<stdio.h>
#include<stdlib.h>

void main (void) {

char fichero[30];
FILE *fp;
char c[2]="", c2='a';
int li=0;
int linpan;  /* lineas por pantalla */

printf ("Nombre del fichero: ") ; scanf ("%s", fichero);
fp = fopen (fichero, "r");

printf ("Numero de lineas por pantalla =  ") ; scanf ("%d", &linpan);

for ( ; c2!=EOF ; ) {
  if (li == linpan)
    {
     printf ("more?") ; scanf ("%s", c);   /* elimina el Intro de c */
     if ((c[0] == 'Q') || (c[0] == 'q')) exit(1); /* termina el programa */
     else li = 0;         /* se imprimen linpan lineas mas */
    }
  c2 = fgetc (fp);        /* siguiente caracter del fichero */
  printf ("%c", c2);
  if (c2 == '\n') li++;
  }
}

