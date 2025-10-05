#include <stdio.h>
#include <math.h>

// Prototipo
void biseccion_con_tabla(float a, float b, float tol, float ep, int maxiter, FILE* salida);

int main() {
    FILE *entrada, *salida;
    int maxiter;
    float a, b, tol, ep;

    // Abrimos archivo de entrada
    entrada = fopen("entrada.dat", "r");
    if (entrada == NULL) {
        printf("Error al abrir archivo de entrada.\n");
        return 1;
    }

    // Leemos datos: maxiter a b tol ep
    fscanf(entrada, "%d %f %f %f %f", &maxiter, &a, &b, &tol, &ep);
    fclose(entrada);

    // Abrimos archivo de salida
    salida = fopen("salida.txt", "w");
    if (salida == NULL) {
        printf("Error al crear archivo de salida.\n");
        return 1;
    }

    // Cabecera
    fprintf(salida, "Iter\t        a\t        b\t       fa\t       fb\t        m\n");
    fprintf(salida, "-----------------------------------------------------------------------\n");

    // Ejecutar bisección y guardar iteraciones
    biseccion_con_tabla(a, b, tol, ep, maxiter, salida);

    fclose(salida);
    printf("✅ Resultados guardados en 'salida.txt'\n");
    return 0;
}

void biseccion_con_tabla(float a, float b, float tol, float ep, int maxiter, FILE* salida) {
    float fa, fb, fm, m;
    float tola, epa;
    int i = 1;

    fa = cos(a) - a;
    fb = cos(b) - b;

    do {
        m = (a + b) / 2.0;
        fm = cos(m) - m;

        // Guardamos esta iteración en el fichero
        fprintf(salida, "%d\t%10.6f\t%10.6f\t%10.6f\t%10.6f\t%10.6f\n", i, a, b, fa, fb, m);

        tola = fabs(b - a);
        epa  = fabs(fm);

        if (fa * fm < 0) {
            b = m;
            fb = fm;
        } else {
            a = m;
            fa = fm;
        }
        i++;
    } while (tola > tol && epa > ep && i <= maxiter);
}
