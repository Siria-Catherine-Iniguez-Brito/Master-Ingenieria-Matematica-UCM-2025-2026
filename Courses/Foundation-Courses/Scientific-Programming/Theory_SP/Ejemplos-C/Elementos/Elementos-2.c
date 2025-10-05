/* Operadores */

#include <stdio.h>

main () {
  int i1=7, i2=5, i3;
  char c1='7', c2='5', c3;      /* tipo char ~ enteros en [0,127] */

/* Operadores aritmeticos */

  printf ("Operadores aritmeticos:\n");
  printf ("i1 = %d\ni2 = %d\n\n", i1, i2);
  i3 = i1 + i2 ; printf ("suma     = %d\n", i3);
  i3 = i1 - i2 ; printf ("resta    = %d\n", i3);
  i3 = i1 * i2 ; printf ("producto = %d\n", i3);
  i3 = i1 / i2 ; printf ("cociente = %d\n", i3);
  i3 = i1 % i2 ; printf ("resto    = %d\n", i3);
  i3 += i1     ; printf ("i3+i1    = %d\n", i3);     /* asignacion */
  i3 *= i1+i2  ; printf ("i3*(i1+i2) = %d\n", i3);

  printf ("\n'7' en base 10          = %d\n", c1);
  printf ("'7' en base octal       = %o\n", c1);
  printf ("'7' en base hexadecimal = %x\n", c1);

/* Operaciones con codigos ASCII */

  c3 = 65;
  printf ("\nCodigo ASCII: %d  caracter: %c\n", c3, c3);

  printf ("\nOperaciones con codigos ASCII:\n");
  c3 = c1 + c2 ; printf ("suma     = %d\n", c3);
  c3 = c1 - c2 ; printf ("resta    = %d\n", c3);
  c3 = c1 * c2 ; printf ("prod     = %d\n", c3); /* c3=MOD(55*53,128) */
  c3 = c1 / c2 ; printf ("cociente = %d\n", c3);
  c3 = c1 % c2 ; printf ("resto    = %d\n", c3);

/* Operadores incremento y decremento */

  printf ("\nIncrementos y decrementos:\n");
  printf ("i1++ = %d\n", i1++);           /* escribe 7, pone i1=8 */
  printf ("++i2 = %d\n", ++i2);           /* pone i2=6, escribe 6 */
  printf ("i1 + i2++ = %d\n", i1 + i2++); /* suma, despues i2=7 */
  printf ("i1 + ++i2 = %d\n", ++i1 + i2); /* pone i1=9, despues suma */

/* Operadores de relacion */

  printf ("\nOperadores relacionales:\n");
  printf ("i1 = %d\ni2 = %d\n\n", i1, i2);
  printf ("i1<i2     = %d\n", i1<i2);
  printf ("i1==i2+2  = %d\n", i1==i2+2);
  printf ("i1!=i2+i3 = %d\n", i1!=i2+i3);

/* Operadores logicos */

  printf ("\nOperadores logicos:\n");
  printf ("i1>i2 && i1*i2=63 = %d\n", i1>i2 && i1*i2==63);
  printf ("i1<i2 || i1%%2=0   = %d\n", i1<i2 || i1%2==0);

/* Otros operadores */

  printf ("\nOtros operadores:\n");
  printf ("bytes de tipo int    = %d\n", sizeof(int));   /* tamaño */
  printf ("bytes de tipo char   = %d\n", sizeof(char));
  printf ("bytes de tipo short  = %d\n", sizeof(short));
  printf ("bytes de tipo long   = %d\n", sizeof(long));
  printf ("bytes de tipo float  = %d\n", sizeof(float));
  printf ("bytes de tipo double = %d\n", sizeof(double));

  printf ("direccion de i1 = %d\n", &i1);               /* direccion */
  printf ("direccion de i2 = %d\n", &i2);

  i3 = (--i1, i2 + i1) ;  printf ("i3 = %d\n", i3);     /* coma */
  i3 = (i1--, i2 + i1) ;  printf ("i3 = %d\n", i3);
  printf ("ultimo valor = %d\n", ("primero", 3.5*3.7, "tercero", 99));
}

