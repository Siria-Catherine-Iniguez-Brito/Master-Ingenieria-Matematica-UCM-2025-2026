/* Expresion condicional simple ? */

#include <stdio.h>

main () {
  int n, m, a;

  /* m = max(n,0) */

  printf ("Introducir n: ") ; scanf ("%d", &n);
  m = (n>0)? n : 0;
  printf ("%s%d", "max(n,0) = ", m);

  /* m = 1(si n>0), -1(si n<0), 0(si n=0) */

  m = (n>0)? n>0 : -(n<0);
  printf ("\n%s%d", "1(si n>0), -1(si n<0), 0(si n=0): ", m);

  /*           / a/2    si a es par
       f(a) = <
               \ 3a + 1 si a es impar                    */

  printf ("\n\nIntroducir a: ") ; scanf ("%d", &a);
  a = a%2? 3*a+1 : a/2;
  printf ("%s%d\n", "a/2(si a par), 3a+1(si a impar): ", a);
}

