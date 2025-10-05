
/* Expansion de macros. Remplazo de argumentos. Operadores #, ## */

#include <stdio.h>
#define unestr(x,y) #x #y       /* #x genera "x"  las cadenas se unen */
#define une(x,y) x ## y         /* concantena los tokens x y; crea xy */
#define iescribe(i) printf (#i " = %i\n", i)
#define fescribe(f) printf (#f " = %f\n", f)
#define gescribe(g) printf (#g " = %g\n", g)

main () {
    int n1n2=7;
    float x1=1.1;

    printf ("%s\n",unestr(uno, dos)); /* el espacio solo separa argumentos*/
    printf ("%s\n",unestr(n1,n2));

    printf ("\n");
    n1n2 += une(n1,n2); /*preguntar que genera esto*/
    iescribe (n1n2);    /* printf ("n1n2" " = %i\n", n1n2);  */

    printf ("\n");
    x1 += une(x,1);
    fescribe (x1);
    gescribe (x1);
}

