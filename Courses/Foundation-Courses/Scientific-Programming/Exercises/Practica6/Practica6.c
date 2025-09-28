/*===============================================================================
  PRACTICA 6: ANALISIS DE RACHAS EN SECUENCIAS

  Objetivo:
    Analizar la estructura de rachas en una secuencia binaria x de longitud n.
    Una racha se define como un grupo de (0s o 1s) consecutivos iguales .

    Ejemplo: Para la secuencia
        x = 0011101011110011
    se extrae la siguiente información:
        • inicial  → primer valor de la secuencia (0 o 1)
        • numero0  → número total de ceros
        • numero1  → número total de unos
        • nrachas  → número total de rachas
        • lmayor0  → longitud de la mayor racha de ceros
        • lmayor1  → longitud de la mayor racha de unos
        • long[]   → longitudes de todas las rachas detectadas

  Entradas:
    - CASOS 1, 2 y 3:
        • Secuencias binarias dadas explícitamente como cadenas de caracteres.

    - CASO 4:
        • Secuencia generada con la fórmula:
            x[i] = floor(i * fmod(8*i, 7)/(1 + a*i) + tanh(2*i*fmod(i,5)/(4 + b*i)))
          donde:
            a = 6.66884
            b = 4.70067

  Salidas:
    - Archivo "Solucion6.sol": contiene, para cada caso:
        • inicial  = ...
        • numero0  = ...
        • numero1  = ...
        • nrachas  = ...
        • lmayor0  = ...
        • lmayor1  = ...
        • long[:]  = ...

  Resultado:
    - El fichero de salida incluye, por cada secuencia analizada:

        ====================================
        | CASO i. Secuencia de longitud N |
        ====================================
        inicial  = ...
        numero0  = ...
        numero1  = ...
        nrachas  = ...
        lmayor0  = ...
        lmayor1  = ...
        long[:]  = ...

  Método:
    1. Leer o generar la secuencia binaria.
    2. Recorrer la secuencia:
        - Contar el número de ceros y unos.
        - Detectar transiciones para identificar rachas.
        - Almacenar las longitudes de cada racha.
        - Determinar la mayor racha de 0s y de 1s.
    3. Escribir los resultados en el archivo de salida "Solucion6.sol".

===============================================================================*/

#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>
#include <math.h>

/*----------------------------------------------------------------------------
  Estructura para almacenar los resultados del análisis de rachas:
    - dim      : longitud total de la secuencia
    - inicial  : primer carácter ('0' o '1')
    - numero0  : cantidad total de ceros
    - numero1  : cantidad total de unos
    - nrachas  : número total de rachas en la secuencia
    - lmayor0  : longitud de la racha más larga de ceros
    - lmayor1  : longitud de la racha más larga de unos
    - lon      : vector dinámico con la longitud de cada racha detectada
 ---------------------------------------------------------------------------*/


 typedef struct {
    int dim;      //dimension del vector longitud 
    char inicial; 
    int numero0;
    int numero1; 
    int nrachas; 
    int lmayor0; 
    int lmayor1;
    int *lon; 
}Resultados;

// Prototipo de función que analiza una secuencia binaria y devuelve los resultados
Resultados calculos(const char *cadena, int);

int main(){
    char linea[256];
    int n ;

    Resultados resultado;

    FILE *fentrada = fopen("Datos6.dat", "r");
    FILE *fsalida = fopen("Solucion6.sol", "w");

    // Cabecera para el archivo de salida
    fprintf(fsalida, "|===========================================================|\n");
    fprintf(fsalida, "|   SOLUCION PRACTICA 6: ANALISIS-DE-RACHAS-EN-SECUENCIAS   |\n");
    fprintf(fsalida, "|===========================================================|\n\n");

    if (!fentrada || !fsalida) {
        printf("Error al abrir fichero.\n");
        return 1;
    }


    n = 0; // Longitud de la secuencia
    char *cadena = NULL; // Almacenará la secuencia
    int leyendo_cadena = 0; // Flag para saber si estamos leyendo la secuencia
    int pos = 0; // Posición en la cadena

    // Lectura línea a línea del archivo de entrada
    while (fgets(linea, sizeof(linea), fentrada) != NULL) {
        
        // Ignorar líneas vacías
        if (linea[0] == '\0'){
            fprintf(fsalida, "%s\n", linea);
            continue;
        }
        
        // Eliminar salto de línea final
        linea[strcspn(linea, "\n")] = '\0';
        
        // Detectar inicio de un nuevo caso
        if (strstr(linea, "CASO") && strstr(linea, "Secuencia de longitud")) {
            if (sscanf(linea, " CASO %*d. Secuencia de longitud %d", &n) == 1) {
                fprintf(fsalida, "%s\n", linea);
                cadena = malloc(n + 1); // // Reservar memoria para secuencia + '\0'
                if (!cadena) {
                    printf("Error de memoria.\n");
                    return 1;
                }
                pos = 0;
                leyendo_cadena = 1;
            }
            continue;
        }

        // Generar secuencia para el CASO 4 (x(i) = ...)
        if (strstr(linea, "x(i)")) {
            
            // Leer valores de a y b 
            double a=0, b=0;
            if (fgets(linea, sizeof(linea), fentrada) != NULL) {
            sscanf(linea, " a = %lf b = %lf", &a, &b);
            fprintf(fsalida, " %s\n", linea); // Escribir línea con a y b
            }

            // Generar secuencia usando la fórmula matemática
            for (int i=1; i<=n; i++) {
                double xi = floor(i * fmod(8*i,7)/(1+a*i) + tanh(2*i*fmod(i,5)/(4+b*i)));
                if ((int)xi % 2 == 0) cadena[i-1] = '0';
                else cadena[i-1] = '1';
            }
            cadena[n] = '\0'; // Finalizar cadena
            resultado = calculos(cadena, n); // Analizar secuencia
            free(cadena);
            leyendo_cadena = 0;

            fprintf(fsalida, "   x(i) = ...\n"); // opcional: línea de fórmula
            continue;
        }
        
        // Si estamos leyendo una secuencia binaria por líneas
        if (leyendo_cadena) {
            for (int i = 0; linea[i] != '\0' && pos < n; i++) {
                if (linea[i] == '0' || linea[i] == '1') {
                    cadena[pos++] = linea[i];
                }
            }
            if (pos >= n) {
                cadena[n] = '\0'; // terminar cadena
                leyendo_cadena = 0; // hemos leído toda la secuencia
                resultado = calculos(cadena,n); // hacemos todos los calculos 
                free(cadena);
            }

        }

        // Eliminar espacios en blanco al final
        int len = strlen(linea);
        while (len > 0 && (linea[len-1] == ' ' || linea[len-1] == '\t')) {
            linea[len-1] = '\0';
            len--;
        }

        // Detección de etiquetas en la plantilla del archivo y escritura del resultado
        if (strstr(linea,"inicial")!= NULL){
            fprintf(fsalida, "   inicial = %c\n", resultado.inicial);
        }
        else if (strstr(linea,"numero0")!= NULL){
            fprintf(fsalida, "   numero0 = %d\n",  resultado.numero0);
        }
        else if (strstr(linea,"numero1") != NULL){
            fprintf(fsalida, "   numero1 = %d\n", resultado.numero1);
        }
        else if (strstr(linea,"nrachas") != NULL){
            fprintf(fsalida, "   nrachas = %d\n", resultado.nrachas);
        }
        else if (strstr(linea,"lmayor0") != NULL){
            fprintf(fsalida, "   lmayor0 = %d\n", resultado.lmayor0);
        }
        else if (strstr(linea,"lmayor1") != NULL){
            fprintf(fsalida, "   lmayor1 = %d\n", resultado.lmayor1);
        }
        else if (strstr(linea,"long") != NULL){
            fprintf(fsalida, "   long(:) = ");
            for (int i = 0; i < resultado.nrachas; i++) {
                fprintf(fsalida, "%d", resultado.lon[i]);
            }
            fprintf(fsalida, "\n");
            
            free(resultado.lon); // Liberar memoria del vector de longitudes
        }
        else{
            // Imprimir cualquier otra línea tal como está
            fprintf(fsalida, "%s\n", linea);
        }
    }

    fclose(fentrada);
    fclose(fsalida);

}

/*----------------------------------------------------------------------------
  Función que analiza una secuencia binaria de longitud n y devuelve:
    - Número de rachas
    - Longitud de cada racha
    - Número total de 0s y 1s
    - Racha más larga de 0s y de 1s
 ---------------------------------------------------------------------------*/
Resultados calculos(const char *cadena, int n){
    
    int racha;
    int i; 


    Resultados result;
    result.dim = n;
    result.inicial = cadena[0];
    result.numero0 =(cadena[0] == '0') ? 1:0;
    result.numero1 =(cadena[0] == '1') ? 1:0;
    result.nrachas = 1; 
    result.lmayor0 = 0; 
    result.lmayor1 = 0;

    
    result.lon = malloc(n*sizeof(int)); // Asumimos como máximo n rachas

    racha = 1;

    for(i = 1; i < n; i++){
        // sigo en la misma racha 
        if(cadena[i] == cadena[i-1]){
            racha ++;
            if (cadena[i]=='0'){
               result.numero0++; 
            }else{
                result.numero1++;
            }
        }
        else{ 
            // Fin de una racha y cambio de valor 
            if(cadena[i]== '0'){
                if(racha>result.lmayor1){
                    result.lmayor1 = racha;
                }
                result.lon[result.nrachas-1] = racha;
                result.numero0++; 
            }else{
                if(racha>result.lmayor0){
                    result.lmayor0 = racha;
                }
                result.lon[result.nrachas-1] = racha;
                result.numero1++; 
            }
            result.nrachas++;
            racha = 1;
        }  
        // Si estamos en el último carácter
        if(i == n-1){
            result.lon[result.nrachas-1] = racha;
        }
    }
    return result;
}