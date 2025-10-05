/* Direcciones, punteros */

#include <stdio.h>

main () {
int m=5;
int j, i1, i2, i3[5], *pi;
float f1, f2, f3[5], *pf;
double d1, d2, d3[5], *pd;
char c1, c2, c3[5], *pc;
void funcion (void), *pfun;

printf ("direccion de i1 = %d", &i1);
printf ("\ndireccion de i2 = %d", &i2);

// pi apunta a la direccion de memoria de i2, podre acceder al contenido y cambiar el contenido
//contenido fr pi = 17
pi = &i2; *pi = 17;   /* i2=17 */
printf ("\n\ni2= %d", i2);
printf ("\npi= %d", pi);
printf ("\n*pi= %d", *pi);

//Ahora pi apunta a la direccion de memoria de i1
// Y ahora modifico el contenido de i1 
pi = &i1; *pi = 88;  /* i1=88, sigue siendo i2=17 */
printf ("\n\ni1= %d", i1);
printf ("\npi= %d", pi);
printf ("\n*pi= %d", *pi);
printf ("\n\ni2= %d", i2);


/* el nombre de un vector es un puntero a la direccion de su primer elemento */
printf ("\n\ndireccion de i3 = %d\n", &i3);   /* escribe lo mismo &i3 que i3 */
for (j=0; j<m; j++) printf ("direccion de i3[%d] = %d\n", j, &i3[j]);

pi = i3;
printf ("\ndireccion de *pi   = %d\n", pi);
for (j=0; j<m; j++) printf ("direccion de pi+%d  = %d\n", j, pi+j);

for (j=0; j<m; j++) {
   i3[j] = j*j;
   printf ("valor de pi[%d] =   %d\n", j, pi[j]);
   printf ("valor de *(i3+%d) = %d\n", j, *(i3+j));}

*(pi+2) = 29;
printf ("\ni3[2]= %d", i3[2]);
printf ("\npi+2= %d", pi+2);
printf ("\n*(pi+2)= %d", *(pi+2));

printf ("\n\ndireccion de f1 = %d", &f1);
printf ("\ndireccion de f2 = %d", &f2);

printf ("\n\ndireccion de d1 = %d", &d1);
printf ("\ndireccion de d2 = %d", &d2);
printf ("\ndireccion de d3 = %d\n", &d3);
for (j=0; j<m; j++) printf ("direccion de d3[%d] = %d\n", j, &d3[j]);

printf ("\ndireccion de c1 = %d", &c1);
printf ("\ndireccion de c2 = %d", &c2);
printf ("\ndireccion de c3 = %d\n", &c3);
for (j=0; j<m; j++) printf ("direccion de c3[%d] = %d\n", j, &c3[j]);

printf ("\ndireccion de funcion = %d\n", &funcion);
}


