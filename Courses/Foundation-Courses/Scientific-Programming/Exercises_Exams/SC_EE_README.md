# 📁 Scientific Programming: Exercises_Exams

This directory contains all **assignments (PracticaX)** and **exams (ExamenX)** for the **Scientific Programming** course in the MSc in Mathematical Engineering (UCM, 2025–2026).

## 📑 Índice

1. **Estructura general y resumen**
   - [📂 Estructura de la carpeta](#-estructura-de-la-carpeta)
   - [📊 Resumen de prácticas y exámenes](#-resumen-de-prácticas-y-exámenes)

2. **Detalles por carpeta**
   - [🗂️ Contenido de cada carpeta](#-contenido-de-cada-carpeta)
     - [📦 Archivos comunes por práctica](#-archivos-comunes-por-práctica)
     - [📦 Archivos comunes por examen](#-archivos-comunes-por-examen)

3. **Compilación y ejecución**
   - [🛠️ Cómo compilar y ejecutar](#-cómo-compilar-y-ejecutar)
     - [✅ Prácticas 1 a 6](#-prácticas-1-a-6)
     - [✅ Prácticas 7 y 8 (con librerías científicas)](#-prácticas-7-y-8-con-librerías-científicas)
       - [▶️ Práctica 7: Sistema no lineal (usa `minpack.f90`)](#️-práctica-7-sistema-no-lineal-usa-minpackf90)
       - [▶️ Práctica 8: Integración numérica (usa `quadpack.f90`)](#practica8)
     - [✅ Exámenes (Exams)](#-exámenes-exams)
     - [🧩 Librerías científicas (solo prácticas 7 y 8)](#-librerías-científicas-solo-prácticas-7-y-8)

4. **Información técnica**
   - [🔬 ¿Qué son MINPACK y QUADPACK?](#-qué-son-minpack-y-quadpack)
      - [🧠 MINPACK – Resolución de sistemas no lineales](#-minpack--resolución-de-sistemas-no-lineales)
      - [∫ QUADPACK – Integración numérica adaptativa](#-quadpack--integración-numérica-adaptativa)
   - [📎 Opciones útiles de compilación](#-opciones-útiles-de-compilación)
   - [💻 Entorno utilizado](#-entorno-utilizado)
   - [⚙️ Instalación del entorno en macOS](#️-instalación-del-entorno-en-macos)
     - [⚖️ Aviso legal](#️-aviso-legal)
     - [🚫 Buenas prácticas generales](#-buenas-prácticas-generales)
     - [🛠 Instalación paso a paso](#-instalación-paso-a-paso)
         - [1. Visual Studio Code](#1-visual-studio-code)
         - [2. Extensión Modern Fortran](#2-extensión-modern-fortran)
         - [3. Instalación manual de gfortran (sin Homebrew)](#3-instalación-manual-de-gfortran-sin-homebrew)
         - [4. Verificación de la instalación](#4-verificación-de-la-instalación)

5. **Otros**
   - [▶️ Uso de gfortran en Visual Studio Code](#️-uso-de-gfortran-en-visual-studio-code)
      - [1. Programas simples (sin librerías externas)](#1-programas-simples-sin-librerías-externas)
      - [2. Programas que usan librerías externas (BLAS, LAPACK, Minpack)](#2-programas-que-usan-librerías-externas-blas-lapack-minpack)
   - [💡 Buenas prácticas](#-buenas-prácticas)
   - [🔗 Recursos útiles](#-recursos-útiles)
   - [📚 Documentación complementaria](#-documentación-complementaria)

---
## 1. Estructura general y resumen

## 📂 Estructura de la carpeta

```plaintext
Exercises_Exams/
│
├── Practica1/
│   ├── Practica1.f90
│   ├── Datos1.dat
│   ├── Solucion1.sol
│   └── P1-FUNCION-DIRECTA-INVERSA.D1
├── Practica2/
│   ├── Practica2.f90
│   ├── Datos2.dat
│   ├── Solucion2.sol
│   └── P2-SUBMATRIZ-CENTRO-ESQUINAS.D1
├── Practica3/
│   ├── Practica3.f90
│   ├── Datos3.dat
│   ├── Solucion3.sol
│   └── P3-SIGUIENTE-COMBINACION.D1
├── Practica4/
│   ├── Practica4.f90
│   ├── Datos4.dat
│   ├── Solucion4.sol
│   └── P4-TRIANGULO.D1
├── Practica5/
│   ├── Practica5.f90
│   ├── Datos5.dat
│   ├── Solucion5.sol
│   └── P5-MIN-n-cotas.D1
├── Practica6/
│   ├── Practica6.c
│   ├── Datos6.dat
│   ├── Solucion6.sol
│   └── P6-RACHAS.D1
├── Practica7/
│   ├── Practica7.f90
│   ├── Datos7.dat
│   ├── Solucion7.sol
│   ├── P7-SISTEMA-NO-LINEAL.D1
│   └── minpack.f90
├── Practica8/
│   ├── Practica8.f90
│   ├── Datos8.dat
│   ├── Solucion8.sol
│   ├── P8-INTEGRAL-1.D1
│   └── quadpack.f90
│
├── Examen1/
│   ├── Examen1.f90
│   ├── DatosE1.dat
│   ├── SolucionE1.sol
│   └── E1-SUBMATRIZ-ABSMIN.D1
├── Examen2/
│   ├── Examen2.f90
│   ├── DatosE2.dat
│   ├── SolucionE2.sol
│   └── E2-ECUACION.D1
│
└── SC_Exercises_Exams_README
```

## 📊 Resumen de prácticas y exámenes

| Carpeta      | Lenguaje | Librerías  | Tema principal                  | 📁 Acceso directo             |
|--------------|----------|------------|---------------------------------|-------------------------------|
| Practica1    | Fortran  | –          | Función directa/inversa         | [📂 Practica1](Practica1/)    |
| Practica2    | Fortran  | –          | Center and Corner Submatrix     | [📂 Practica2](Practica2/)    |
| Practica3    | Fortran  | –          | Next Combination                | [📂 Practica3](Practica3/)    |
| Practica4    | Fortran  | –          | Triangle                        | [📂 Practica4](Practica4/)    |
| Practica5    | Fortran  | –          | Minimum n Bounds                | [📂 Practica5](Practica5/)    |
| Practica6    | C        | –          | Rachas                          | [📂 Practica6](Practica6/)    |
| Practica7    | Fortran  | MINPACK    | Sistema no lineal               | [📂 Practica7](Practica7/)    |
| Practica8    | Fortran  | QUADPACK   | Integración numérica            | [📂 Practica8](Practica8/)    |
| Examen1      | Fortran  | –          | Submatriz mínimo absoluto       | [📂 Examen1](Examen1/)        |
| Examen2      | Fortran  | –          | Ecuación                        | [📂 Examen2](Examen2/)        |



---
## 2. Detalles por carpeta

## 🗂️ Contenido de cada carpeta

Cada práctica o examen se encuentra en una carpeta individual con nombre `PracticaX` o `ExamenX`, donde **X representa el número correspondiente** (1 a 8 para prácticas, 1 y 2 para exámenes).

### 📦 Archivos comunes por práctica

- `PracticaX.f90` / `PracticaX.c`: Código fuente en **Fortran** o **C**  
  *(Nota: la práctica 6 es la única realizada en C; el resto están en Fortran)*

- `DatosX.dat`: Archivo de **entrada** con los datos del problema.

- `SolucionX.sol`: Archivo de **salida** generado por el programa con la solución.

- `PX-Nombre.D1`: Enunciado oficial completo de la práctica.

---

### 📦 Archivos comunes por examen

- `ExamenX.f90`: Código fuente del examen (**todos en Fortran**).

- `DatosEX.dat`: Archivo de **entrada** con los datos del problema.

- `SolucionEX.sol`: Archivo de **salida** generado por el programa con la solución.

- `EX-Nombre.D1`: Enunciado oficial completo del examen.

---

## 3.Compilación y ejecución

## 🛠️ Cómo compilar y ejecutar

### ✅ Prácticas 1 a 6

Se pueden ejecutar directamente con la extensión [Code Runner](https://marketplace.visualstudio.com/items?itemName=formulahendry.code-runner) de Visual Studio Code (el botón ▶️), sin necesidad de compilar manualmente desde la terminal.

---

### ✅ Prácticas 7 y 8 (con librerías científicas)

#### ▶️ Práctica 7: Sistema no lineal (usa `minpack.f90`)

1. Abrir la terminal integrada de Visual Studio Code y situarse en la carpeta `Practica7/`.
2. Compilar con el siguiente comando:

```bash
# Compilación de la práctica 7 con MINPACK
gfortran -O2 Practica7.f90 minpack.f90 -o Practica7
```

3. Se generará un ejecutable llamado `Practica7`.
4. Desde la terminal del sistema (o desde VSCode si estás en la misma carpeta), ejecutar:

```bash
./Practica7
```

Esto generará el archivo de salida `Solucion7.sol`.

---

### Práctica 8: Integración numérica (usa `quadpack.f90`) <a name="practica8"></a>


1. Abrir la terminal integrada de Visual Studio Code y situarse en la carpeta `Practica8/`.
2. Compilar con el siguiente comando:

```bash
# Compilación de la práctica 8 con QUADPACK
gfortran -O2 Practica8.f90 quadpack.f90 -o Practica8
```

3. Se generará un ejecutable llamado `Practica8`.
4. Desde la terminal del sistema (o desde VSCode si estás en la misma carpeta), ejecutar:

```bash
./Practica8
```

Esto generará el archivo de salida `Solucion8.sol`.

---

### ✅ Exámenes (Exams)

Todos los exámenes están preparados para ejecutarse directamente con la extensión **Run Code** de Visual Studio Code, sin comandos especiales ni librerías externas.

---

### 🧩 Librerías científicas (solo prácticas 7 y 8)

- `minpack.f90`: Utilizada en la **práctica 7** para resolver **sistemas no lineales**.
- `quadpack.f90`: Utilizada en la **práctica 8** para realizar **integración numérica**.

Cada una de estas prácticas incluye instrucciones detalladas para su compilación y ejecución.

---
## 4. Información técnica
## 🔬 ¿Qué son MINPACK y QUADPACK?

### 🧠 MINPACK – Resolución de sistemas no lineales

- **MINPACK** es una librería numérica escrita en Fortran especializada en la resolución de sistemas de ecuaciones no lineales. Documentación oficial en [Netlib](https://www.netlib.org/minpack/).
- Implementa algoritmos eficientes y robustos basados en métodos como el de **Levenberg-Marquardt**.
- En este proyecto, MINPACK se utiliza en la **Práctica 7**, cuyo objetivo es resolver un sistema no lineal planteado en el enunciado.
- La librería facilita la implementación del método sin tener que desarrollar desde cero rutinas complejas para el cálculo de Jacobianos, iteraciones, tolerancias, etc.

### ∫ QUADPACK – Integración numérica adaptativa

- **QUADPACK** es una librería escrita en Fortran que proporciona algoritmos de **integración numérica unidimensional**.
- Está diseñada para manejar integrandos difíciles, incluyendo funciones con picos, discontinuidades, o dominios infinitos.
- En este proyecto, QUADPACK se utiliza en la **Práctica 8**, que consiste en calcular **integrales definidas** de funciones complicadas con alta precisión.
- Gracias a esta librería se pueden usar métodos como la **cuadratura adaptativa** para obtener resultados más precisos y eficientes que con métodos básicos como el de Simpson.

---

Ambas librerías son utilizadas únicamente en las prácticas 7 y 8 debido a la **naturaleza más compleja de los problemas planteados** en esos ejercicios:

- En la **Práctica 7** se resuelve un sistema no lineal que requiere técnicas avanzadas de optimización.
- En la **Práctica 8** se realiza una integración numérica que involucra funciones difíciles de tratar analíticamente.

Estas herramientas profesionales permiten abordar los problemas con algoritmos ya validados, lo cual **reduce errores, mejora la precisión** y **acelera el desarrollo** del código.


---

## 💻 Entorno utilizado

- **Sistema operativo:** macOS  
- **Compilador:** `gfortran` versión 9.0 o superior  
- **Editor:** Visual Studio Code  
- Con extensiones para **Fortran** y **C** disponibles desde el Marketplace

| Herramienta         | Versión recomendada | Enlace de descarga                          |
|---------------------|---------------------|---------------------------------------------|
| Visual Studio Code  | Última              | https://code.visualstudio.com/              |
| Modern Fortran Ext. | 3.x o superior      | https://marketplace.visualstudio.com/items?itemName=fortran-lang.fortran |
| gfortran (macOS)    | 9.0 o superior      | https://github.com/fxcoudert/gfortran-for-macOS/releases |

---

## ⚙️ Instalación del entorno en macOS

 Guía de instalación y uso de Fortran (gfortran) en macOS con Visual Studio Code — sin utilizar Homebrew

Esta guía explica cómo instalar y utilizar **gfortran** en macOS usando **Visual Studio Code** y la extensión **Modern Fortran**, sin necesidad de Homebrew. Está diseñada para que cualquier usuario pueda configurar su entorno de desarrollo y compilar programas Fortran de manera sencilla.

---

### ⚖️ Aviso legal

gfortran y GCC son compiladores de uso libre para Fortran 95/2003/2008/2018 y otros lenguajes como C y C++.
Pueden descargarse desde:

- [GFortran Binaries](http://gcc.gnu.org/wiki/GFortranBinaries)

Las librerías BLAS, LAPACK y Minpack son de uso libre y pueden obtenerse desde:

- [Programas de ejemplo y librerías](https://people.sc.fsu.edu/~jburkardt/f_src/f_src.html)

---

### 🚫 Buenas prácticas generales

- Evita usar **espacios en blanco** en nombres de carpetas y archivos.
- No utilices el escritorio ni "Documentos" con espacios para compilar programas.
- Evita usar pendrives para compilar y ejecutar programas.
- Usa nombres de archivo simples como `programa.f90`.

---

### 🛠 Instalación paso a paso

#### 1. Visual Studio Code

Si aún no lo tienes instalado, descárgalo desde [VS Code](https://code.visualstudio.com/) e instálalo en tu Mac.

---

#### 2. Extensión Modern Fortran

1. Abre VS Code.
2. Ve a la pestaña **Extensiones** (icono de cuadraditos).
3. Busca **Modern Fortran** y haz clic en **Instalar**.

Esto te proporcionará:

- Resaltado de sintaxis.
- Autocompletado básico.
- Reconocimiento de archivos `.f90`, `.f95`, `.f03`, etc.
- Soporte para compilar desde la terminal integrada.

---

#### 3. Instalación manual de gfortran (sin Homebrew)

1. Ve a [GFortran for macOS Releases](https://github.com/fxcoudert/gfortran-for-macOS/releases)
2. Descarga el instalador correspondiente a tu procesador:
- **ARM (M1/M2/M3)** → archivo `.dmg` ARM.
- **Intel** → archivo `.dmg` Intel.
3. Abre el `.dmg` y sigue los pasos de instalación.
4. Esto instalará `gfortran` en `/usr/local/bin` por defecto.

---

#### 4. Verificación de la instalación

Abre Terminal y ejecuta:

```bash
gfortran --version
```

Deberías ver algo como:

```
GNU Fortran (GCC) X.X.X
```

---
## 5. Otros

## ▶️ Uso de gfortran en Visual Studio Code

### 1. Programas simples (sin librerías externas)

1. Crea un archivo `.f90` o `.f95` en VS Code.
2. Usa el botón **Run ▶️** para compilar y ejecutar directamente.
3. Ideal para programas que no requieren librerías externas.

---

### 2. Programas que usan librerías externas (BLAS, LAPACK, Minpack)

1. Abre la **Terminal integrada** en VS Code.
2. Compila tu programa incluyendo las librerías necesarias:

```bash
gfortran programa.f90 -o programa -L/ruta/a/librerias -llapack -lminpack
```

3. Ejecuta el programa:

```bash
./programa
```

> ⚠️ Sustituye `/ruta/a/librerias` por la ruta real donde tengas las librerías.


---

## 💡 Buenas prácticas

- Usa siempre **IMPLICIT NONE** para evitar errores de tipos implícitos.
- Mantén los proyectos organizados en carpetas dedicadas a Fortran.
- Familiarízate con las librerías que uses (BLAS, LAPACK, Minpack) y sus versiones.

---

## 🔗 Recursos útiles

- [Modern Fortran VS Code Extension](https://marketplace.visualstudio.com/items?itemName=fortran-lang.fortran)
- [Librerías Fortran (BLAS, LAPACK, Minpack)](https://people.sc.fsu.edu/~jburkardt/f_src/f_src.html)
- [GFortran for macOS Releases](https://github.com/fxcoudert/gfortran-for-macOS/releases)


---

## 📚 Documentación complementaria

- Cada práctica y examen incluye un enunciado `.D1` con los detalles del problema, entrada/salida esperada y objetivos de implementación.

- Las prácticas 7 y 8, al requerir uso de librerías científicas externas (`minpack` y `quadpack`), contienen **instrucciones adicionales** para su correcta compilación, enlazado y ejecución en entorno local.

- Esta documentación asegura la **reproducibilidad** de todos los resultados y facilita el trabajo autónomo del estudiante.


🔙 [Volver a Scientific-Programming](../..)

