/* Constantes simbolicas, enumeradas y declaradas */

#define radio 0.5       /* simbolos; radio no es una variable */

#include <stdio.h>

main() {

const double pi=3.141592653589793L;   /* declaraciones */

/* enumeraciones */

enum dias {lunes, martes, miercoles, jueves, viernes, sabado, domingo};
enum dias dd;

enum estudios {matematicas=1, fisica, biologia=7, geologia, medicina=19};
enum estudios ff;

/* ------------------------------------------------------------------ */

printf ("%s%15.14f\n", "numero pi = ", pi);
printf ("%s%10.5f\n", "longitud = ", 2*pi*radio);

dd = lunes; printf ("%s%d\n", "dia ", dd);               /* 0 */
dd = sabado; printf ("%s%d\n", "dia ", dd);              /* 5 */

ff = matematicas ; printf ("%s%d\n", "facultad ", ff);   /* 1 */
ff = fisica ; printf ("%s%d\n", "facultad ", ff);        /* 2 */
ff = geologia ; printf ("%s%d\n", "facultad ", ff);      /* 8 */
}