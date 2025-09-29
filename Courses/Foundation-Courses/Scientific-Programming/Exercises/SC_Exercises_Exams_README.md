# 📁 Carpeta Exercises_Exams: Prácticas y Exámenes

Esta carpeta reúne tanto las **prácticas** (`PracticaX`) como los **exámenes** (`ExamenX`) correspondientes a la asignatura de **Programación Científica** del Máster en Ingeniería Matemática (UCM).

---

## 📂 Estructura de la carpeta

```plaintext
Exercises_Exams/
│
├── Practica1/
│   ├── Practica1.f90
│   ├── Datos1.dat
│   ├── Solucion1.sol
│   └── P1-FUNCION-DIRECTA-INVERSA.D1
├── ...
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

---

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

## 🛠️ Cómo compilar y ejecutar

### ✅ Prácticas 1 a 6

Se pueden ejecutar directamente con la extensión **Run Code** de Visual Studio Code, sin necesidad de comandos adicionales.

---

### ✅ Prácticas 7 y 8 (con librerías científicas)

#### ▶️ Práctica 7: Sistema no lineal (usa `minpack.f90`)

1. Abrir la terminal integrada de Visual Studio Code y situarse en la carpeta `Practica7/`.
2. Compilar con el siguiente comando:

```bash
gfortran -O2 Practica7.f90 minpack.f90 -o Practica7
```

3. Se generará un ejecutable llamado `Practica7`.
4. Desde la terminal del sistema (o desde VSCode si estás en la misma carpeta), ejecutar:

```bash
./Practica7
```

Esto generará el archivo de salida `Solucion7.sol`.

---

#### ▶️ Práctica 8: Integración numérica (usa `quadpack.f90`)

1. Abrir la terminal integrada de Visual Studio Code y situarse en la carpeta `Practica8/`.
2. Compilar con el siguiente comando:

```bash
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

## 🔬 ¿Qué son MINPACK y QUADPACK?

### 🧠 MINPACK – Resolución de sistemas no lineales

- **MINPACK** es una librería numérica escrita en Fortran especializada en la resolución de **sistemas de ecuaciones no lineales** y en **problemas de mínimos cuadrados no lineales**.
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

---

## 💻 Entorno utilizado

- **Sistema operativo:** macOS  
- **Compilador:** `gfortran` versión 9.0 o superior  
- **Editor:** Visual Studio Code  
  - Con extensiones para **Fortran** y **C** disponibles desde el Marketplace

---

## ⚙️ Instalación del entorno en macOS (mi ordenador personal)

1. **Instalar las herramientas de línea de comandos de Xcode:**
```bash
xcode-select --install
```

2. **Instalar Homebrew (gestor de paquetes):**
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

3. **Instalar GCC y GFortran:**
```bash
brew install gcc
```

4. **Descargar e instalar Visual Studio Code:**  
   [https://code.visualstudio.com/](https://code.visualstudio.com/)

5. **Instalar extensiones de Fortran y C** desde el Marketplace de VSCode.

---

## 📚 Documentación complementaria

- Cada práctica y examen incluye un enunciado `.D1` con los detalles del problema, entrada/salida esperada y objetivos de implementación.

- Las prácticas 7 y 8, al requerir uso de librerías científicas externas (`minpack` y `quadpack`), contienen **instrucciones adicionales** para su correcta compilación, enlazado y ejecución en entorno local.

- Esta documentación asegura la **reproducibilidad** de todos los resultados y facilita el trabajo autónomo del estudiante.
