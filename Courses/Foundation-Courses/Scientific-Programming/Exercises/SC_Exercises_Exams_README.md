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
├── Practica2/
│   └── ...
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

## 🛠️ Cómo compilar y ejecutar

### ✅ Prácticas (Exercises)

- **Prácticas 1 a 6:**  
  Se pueden ejecutar directamente con la extensión **Run Code** de Visual Studio Code, sin necesidad de comandos adicionales.

- **Prácticas 7 y 8:**  
  Utilizan **librerías científicas específicas**, por lo que requieren compilación manual mediante comandos especiales.  
  En sus carpetas correspondientes (`Practica7/` y `Practica8/`) encontrarás instrucciones detalladas para compilar y ejecutar los programas correctamente en tu entorno local.

---

### ✅ Exámenes (Exams)

Todos los exámenes están preparados para ejecutarse directamente con la extensión **Run Code** de Visual Studio Code, sin comandos especiales ni librerías externas.

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

### 🧩 Librerías científicas (solo prácticas 7 y 8)

- `minpack.f90`: Utilizada en la **práctica 7** para resolver **sistemas no lineales**.

- `quadpack.f90`: Utilizada en la **práctica 8** para realizar **integración numérica**.

Cada una de estas prácticas incluye documentación específica sobre el uso e integración de estas librerías, así como los **comandos exactos de compilación** utilizados en mi entorno local.

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
