
# 🧪 Scientific Programming 

## Guía Docente

### Datos Generales
- **Asignatura:** Programación Científica (Código: 608063)
- **Plan de Estudios:** Máster Universitario en Ingeniería Matemática (2010-11)
- **Carácter:** Complemento de Formación
- **ECTS:** 3.0
- **Semestre:** 1º

## 🎯 Objetivos
- Asimilar y practicar la programación en Fortran 95 y C.
- Utilizar librerías científicas para resolución de problemas numéricos.
- Implementar y analizar algoritmos numéricos complejos.
- Desarrollar habilidades para la detección y corrección de errores en código.

## 🧠 Competencias
- **Generales (CG5):** Resolver problemas matemáticos computacionalmente usando software adecuado.
- **Específicas (CE3 y CE6):** Conocimiento de Fortran y C, uso de librerías científicas, implementación de algoritmos y resolución de problemas numéricos.

### Dinámica de la Asignatura
- Clases teóricas (1/3 del tiempo presencial): Explicaciones y ejemplos de características de los lenguajes y librerías.
- Clases prácticas (2/3 del tiempo presencial): Desarrollo, pruebas, análisis y corrección de programas.
- Laboratorios: Uso libre para experimentación y aprendizaje.

---

## Prácticas del Curso 2025-26

| Nº Práctica | Nombre                       | Nombre2                                | Fecha límite              |
|-------------|------------------------------|----------------------------------------|---------------------------|
| 1           | Función directa inversa      | P1-FUNCION-DIRECTA-INVERSA.D1          | Jueves 11-septiembre-2025 |
| 2           | Submatriz centro esquinas    | P2-SUBMATRIZ-CENTRO-ESQUINAS.D1        | Jueves 11-septiembre-2025 |
| 3           | Siguiente combinación        | P3-SIGUIENTE-COMBINACION.D1            | Jueves 18-septiembre-2025 |
| 4           | Triángulo                    | P4-TRIANGULO.D1                         | Jueves 18-septiembre-2025 |
| 5           | Min n cotas                  | P5-MIN-n-cotas.D1                       | Jueves 2-octubre-2025     |
| 6           | Rachas                       | P6-RACHAS.D1                            | Jueves 2-octubre-2025     |
| 7           | Sistema no lineal            | P7-SISTEMA-NO-LINEAL.D1                | Jueves 25-septiembre-2025 |
| 8           | Integral                     | P8-INTEGRAL-1.D1                        | Jueves 25-septiembre-2025 |



- El valor conjunto de las prácticas 1 y 2 será a lo sumo 1.8 puntos. El valor máximo de cada
una es 1.0 puntos. Fecha límite de entrega: Jueves 11-septiembre-2025.

- El valor conjunto de las prácticas 3 y 4 será a lo sumo 2.4 puntos. El valor máximo de cada
una es 1.3 puntos. Fecha límite de entrega: Jueves 18-septiembre-2025.

- El valor conjunto de las prácticas 7 y 8 será a lo sumo 1.6 puntos. El valor máximo de cada
una es 0.9 puntos. Fecha límite de entrega: Jueves 25-septiembre-2025.

- El valor conjunto de las prácticas 5 y 6 será a lo sumo 3.2 puntos. El valor máximo de cada
una es 1.7 puntos. Fecha límite de entrega: Jueves 2-octubre-2025.

- El último día del curso, Viernes 12 Septiembre-2025, se realizarán en clase unos ejercicios
con valor máximo 1.0 puntos.

---

### Normas para la entrega y evaluación

- Cada práctica puede realizarse en **Fortran** o en **C**; en cada lenguaje se debe hacer al menos una práctica.
- Para evaluar, se deben enviar los siguientes archivos:
  - Código fuente: `Px.f90` o `Px.c` (donde X es el número de práctica)
  - Archivo de datos: `DatosX.dat`
  - Archivo de resultados: `SolucionX.sol`
- El archivo de enunciado correspondiente es `PX-Nombre_de_la_practica.D1`.
- Los archivos deben enviarse a:
  - **Fortran:** afelipe@ucm.es
  - **C:** crisande@ucm.es
- **Importante:** Las soluciones mostradas sólo por pantalla **no se valoran**.
- Las prácticas entregadas después de la fecha límite tendrán penalización en la nota.
- Una vez calificada una práctica, su valoración será definitiva.
- Las prácticas son de realización **individual**.
- Cualquier copia o plagio supondrá:
  - Cero puntos en la práctica afectada,
  - Probable suspenso en la asignatura,
  - Posible inicio de expediente disciplinario.

---

## 🗂️ Estructura del Repositorio

```plaintext
Scientific-Programming/
│
├── Practicas/
│ ├── Practica1/
│ │ ├── Practica1.f90 / Practica1.c
│ │ ├── Datos1.dat
│ │ ├── Solucion1.sol
│ │ └── P1-FUNCION-DIRECTA-INVERSA.D1
│ ├── Practica2/
│ │ └── ...
│ └── ... (Practica3 a Practica8)
│
├── Teoria/
│ └── Material_teorico.pdf (u otros recursos)
│
├── Examenes/
│ ├── Ejercicio1/
│ └── Ejercicio2/
│
└── README.md
```

---

## Uso y Compilación

### Requisitos previos
- Compilador Fortran 95 (ej. `gfortran`)
- Compilador C (ej. `gcc`)
- Librerías científicas utilizadas:
  - **Minpack** para la práctica 7
  - **Quadpack** para la práctica 8

### Cómo compilar

Para Fortran:

```bash
gfortran -o PracticaX PracticaX.f90 -lminpack    # Para práctica 7
gfortran -o PracticaX PracticaX.f90 -lquadpack  # Para práctica 8
gfortran -o PracticaX PracticaX.f90              # Para otras prácticas
