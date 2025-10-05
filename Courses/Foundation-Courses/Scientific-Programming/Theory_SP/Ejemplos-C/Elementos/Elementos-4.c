/* Formatos */

#include <stdio.h>

void main (void) {
  int    x = 12;
  float  y = 34.567F;  /* por defecto 34.567 es doble */
  double z = 89.012L;
  char   w[] = "Letras-numeros";

/* Formato para enteros d, i, o, x */

  printf ("/12/ con formato %%d:   /%d/\n", x);
  printf ("/12/ con formato %%1i:  /%1i/\n", x);
  printf ("/12/ con formato %%10i: /%10i/\n", x);
  printf ("/12/ con formato %%-5d: /%-5d/\n", x);
  printf ("/12/ con formato %%o:   /%o/\n", x);
  printf ("/12/ con formato %%x:   /%x/\n", x);
  printf ("/12/ con formato %%X:   /%X/\n\n", x);

/* Formato para float f, e, g */

  printf ("/34.567/ con formato %%f:      /%f/\n", y);
  printf ("/34.567/ con formato %%.3f:    /%.3f/\n", y);
  printf ("/34.567/ con formato %%5.1f:   /%5.1f/\n", y);
  printf ("/34.567/ con formato %%-10.3f: /%-10.3f/\n", y);
  printf ("/34.567/ con formato %%5f:     /%5f/\n", y);
  printf ("/34.567/ con formato %%5e:     /%5e/\n", y);
  printf ("/1.e-12/ con formato %%10.4g:  /%10.4g/\n", 1.e-12);
  printf ("/1.e-03/ con formato %%10.4g:  /%10.4g/\n\n", 1.e-3);

/* Formato para double lf, e, g */

  printf ("/89.012/ con formato %%lf:      /%lf/\n", z);
  printf ("/89.012/ con formato %%.3lf:    /%.3lf/\n", z);
  printf ("/89.012/ con formato %%20.15lf: /%20.15lf/\n", z);
  printf ("/89.012/ con formato %%-10.3lf: /%-10.3lf/\n", z);
  printf ("/89.012/ con formato %%5lf:     /%5lf/\n", z);
  printf ("/89.012/ con formato %%5e:      /%5e/\n\n", z);

/* Formato para cadenas s */

  printf ("/Letras-numeros/ con formato %%s:       /%s/\n", w);
  printf ("/Letras-numeros/ con formato %%.7s:     /%.7s/\n", w);
  printf ("/Letras-numeros/ con formato %%-15.10s: /%-15.10s/\n", w);
  printf ("/Letras-numeros/ con formato %%20s:     /%20s/\n\n", w);

  printf ("%.*s\n",4,w);  /* el * se sustituye por 4 */
  printf ("%.*s\n",8,w);  /* el * se sustituye por 8 */
  printf ("%.*s\n",x,w);  /* el * se sustituye por el valor de x */
  printf ("%*.*f\n",x,6,y);  /* los * se sustituyen por el valor de x y por 6 */
}

