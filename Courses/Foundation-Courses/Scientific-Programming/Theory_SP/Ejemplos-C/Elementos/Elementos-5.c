/* Estructuras */

#include <stdio.h>
#include <math.h>

main() {
struct centro {
  float m, n;};
struct circulo {
  struct centro cen;
  float radio;};

struct circulo c;
const float pi=3.1415926F;
float lon, area;

/* los dos puntos indican la forma requerida para separar los datos en lectura */

printf ("Centro (x:y) = ") ; scanf ("%f:%f", &c.cen.m ,&c.cen.n);
printf ("Radio = ") ; scanf ("%f", &c.radio);

lon = 2.0*pi*c.radio;
area = pi*pow(c.radio,2);
printf ("\nLongitud de la circunferencia = %8.2f\n", lon);
printf ("\nArea del circulo = %8.2f\n", area);
printf ("\nEcuacion de la circunferencia x**2 + y**2 + ax + by + c = 0");
printf ("\na = %8.2f", -2*c.cen.m);
printf ("\nb = %8.2f", -2*c.cen.n);
printf ("\nc = %8.2f\n", pow(c.cen.m,2)+pow(c.cen.n,2)-pow(c.radio,2));
}