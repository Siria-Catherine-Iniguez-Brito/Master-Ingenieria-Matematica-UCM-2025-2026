# Carpeta Exercises_Exams: Prácticas y Exámenes

Esta carpeta reúne tanto las **prácticas** (`Exercises`) como los **exámenes** (`Exams`) correspondientes a la asignatura de Programación Científica del Máster en Ingeniería Matemática (UCM).

---

## 📂 Estructura de la carpeta

```plaintext
Exercises_Exams/
├── Exercises/
│   ├── Practica1/
│   │   ├── Practica1.f90 / Practica1.c
│   │   ├── Datos1.dat
│   │   ├── Solucion1.sol
│   │   └── P1-FUNCION-DIRECTA-INVERSA.D1
│   ├── Practica2/
│   │   └── ...
│   ├── ...
│   └── Practica8/
│       ├── Practica8.f90 / Practica8.c
│       ├── Datos8.dat
│       ├── Solucion8.sol
│       └── P8-INTEGRAL-1.D1
│
├── Exams/
│   ├── Examen1/
│   │   ├── Examen1.f90
│   │   ├── DatosE1.dat
│   │   ├── SolucionE1.sol
│   │   └── E1-SUBMATRIZ-ABSMIN.D1
│   ├── Examen2/
│   │   └── ...

```
## 🛠️ Cómo compilar y ejecutar

### Prácticas (Exercises)

- **Prácticas 1 a 6:**  
  Se pueden ejecutar directamente con la extensión **Run Code** de Visual Studio Code, sin necesidad de comandos adicionales.

- **Prácticas 7 y 8:**  
  Utilizan librerías científicas específicas, por lo que requieren compilación manual mediante comandos especiales. En sus carpetas correspondientes encontrarás instrucciones detalladas para compilar y ejecutar.

### Exámenes (Exams)

- Todos los exámenes están preparados para ejecutarse directamente con la extensión **Run Code** de Visual Studio Code, sin comandos especiales ni librerías externas.

## 💻 Entorno utilizado

- **Sistema operativo:** macOS  
- **Compilador:** gfortran versión 9.0 o superior  
- **Editor:** Visual Studio Code con extensiones para Fortran y C  



## ⚙️ Instalación del entorno en macOS (mi ordenador personal)

1. Instalar las herramientas de línea de comandos de Xcode:

```bash
xcode-select --install

2. Instalar Homebrew (gestor de paquetes):

3. Instalar GCC y GFortran:

brew install gcc

4. Descargar e instalar Visual Studio Code:
https://code.visualstudio.com/
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

5. Instalar extensiones de Fortran y C en VSCode desde el Marketplace.


## 📚 Librerías científicas

Solo se utilizan en las prácticas 7 y 8.

La documentación específica para la instalación y uso de estas librerías se encuentra en las carpetas de estas prácticas.


## 📄 Documentación complementaria

Cada práctica y examen incluye un enunciado (.D1) con los detalles y objetivos.

Las prácticas 7 y 8 contienen instrucciones adicionales para la compilación y uso de librerías.

Esta documentación asegura la reproducibilidad y facilita el trabajo autónomo.
