# 📁 Scientific Programming: Exercises_Exams

This directory contains all **assignments (PracticaX)** and **exams (ExamenX)** for the **Scientific Programming** course in the MSc in Mathematical Engineering (UCM, 2025–2026).

## 📑 Index

### 1. General Structure and Summary
- [📂 Folder Structure](#-folder-structure)  
- [📊 Summary of Practices and Exams](#-summary-of-practices-and-exams)  

### 2. Details by Folder
- [🗂️ Contents of Each Folder](#-contents-of-each-folder)  
  - [📦 Common Files per Practice](#-common-files-per-practice)  
  - [📦 Common Files per Exam](#-common-files-per-exam)  

### 3. Compilation and Execution
- [🛠️ How to Compile and Run](#️-how-to-compile-and-run)  
  - [✅ Practices 1 to 6](#-practices-1-to-6)  
  - [✅ Practices 7 and 8 (with scientific libraries)](#-practices-7-and-8-with-scientific-libraries)  
    - [▶️ Practice 7: Nonlinear system (uses `minpack.f90`)](#-practice-7-nonlinear-system-uses-minpackf90)  
    - [▶️ Practice 8: Numerical integration (uses `quadpack.f90`)](#-practice-8-numerical-integration-uses-quadpackf90)  
  - [✅ Exams](#-exams)  
  - [🧩 Scientific Libraries (only practices 7 and 8)](#-scientific-libraries-only-practices-7-and-8)  

### 4. Technical Information
- [🔬 What are MINPACK and QUADPACK?](#-what-are-minpack-and-quadpack)  
  - [🧠 MINPACK – Solving Nonlinear Systems](#-minpack--solving-nonlinear-systems)  
  - [∫ QUADPACK – Adaptive Numerical Integration](#-quadpack--adaptive-numerical-integration)  
- [📎 Useful Compilation Options](#-useful-compilation-options)  
- [💻 Environment Used](#-environment-used)  
- [⚙️ Environment Setup on macOS](#-environment-setup-on-macos)  
  - [⚖️ Legal Notice](#-legal-notice)  
  - [🚫 General Best Practices](#-general-best-practices)  
  - [🛠 Step-by-Step Installation](#-step-by-step-installation)  
    - [1. Visual Studio Code](#1-visual-studio-code)  
    - [2. Modern Fortran Extension](#2-modern-fortran-extension)  
    - [3. Manual Installation of gfortran (without Homebrew)](#3-manual-installation-of-gfortran-without-homebrew)  
    - [4. Installation Verification](#4-installation-verification)  

### 5. Others
- [▶️ Using gfortran in Visual Studio Code](#-using-gfortran-in-visual-studio-code)  
  - [1. Simple Programs (without external libraries)](#1-simple-programs-without-external-libraries)  
  - [2. Programs Using External Libraries (BLAS, LAPACK, Minpack)](#2-programs-using-external-libraries-blas-lapack-minpack)  
- [💡 Best Practices](#-best-practices)  
- [🔗 Useful Resources](#-useful-resources)  
- [📚 Additional Documentation](#-additional-documentation)  

---
## 1. General Structure and Summary

## 📂 Structure of `Exercises_Exams/`

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

| Folder | Language | Libraries | Main Topic | 📁 Direct Access |
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
## 2. Details by Folder

## 🗂️ Contents of Each Folder

Each practice or exam is located in an individual folder named `PracticaX` or `ExamenX`, where **X represents the corresponding number** (1 to 8 for practices, 1 and 2 for exams).

### 📦 Common Files per Practice

- `PracticaX.f90` / `PracticaX.c`: Source code in **Fortran** or **C**  
  *(Note: practice 6 is the only one done in C; the rest are in Fortran)*

- `DatosX.dat`: **Input** file containing the problem data.

- `SolucionX.sol`: **Output** file generated by the program with the solution.

- `PX-Nombre.D1`: Official full statement of the practice.

---

### 📦 Common Files per Exam

- `ExamenX.f90`: Source code of the exam (**all in Fortran**).

- `DatosEX.dat`: **Input** file containing the problem data.

- `SolucionEX.sol`: **Output** file generated by the program with the solution.

- `EX-Nombre.D1`: Official full statement of the exam.

---


## 3. Compilation and Execution

## 🛠️ How to Compile and Run

### ✅ Practices 1 to 6

These can be run directly with the [Code Runner](https://marketplace.visualstudio.com/items?itemName=formulahendry.code-runner) extension in Visual Studio Code (the ▶️ button), without needing to manually compile from the terminal.

---

### ✅ Practices 7 and 8 (with scientific libraries)

#### ▶️ Practice 7: Nonlinear system (uses `minpack.f90`)

1. Open the integrated terminal in Visual Studio Code and navigate to the `Practica7/` folder.
2. Compile with the following command:

```bash
# Compile practice 7 with MINPACK
gfortran -O2 Practica7.f90 minpack.f90 -o Practica7
```

3. An executable named Practica7 will be generated.
4. From the system terminal (or from VSCode if you are in the same folder), run:

```bash
./Practica7
```

This will generate the output file `Solucion7.sol`.

---

### Practice 8: Numerical integration (uses `quadpack.f90`) <a name="practica8"></a>


1. Open the integrated terminal in Visual Studio Code and navigate to the `Practica8/` folder.
2. Compile with the following command:

```bash
# Compile practice 8 with QUADPACK
gfortran -O2 Practica8.f90 quadpack.f90 -o Practica8
```

3. An executable named `Practica8` will be generated.

4. From the system terminal (or from VSCode if you are in the same folder), run:.

```bash
./Practica8
```

This will generate the output file `Solucion8.sol`.

---

### ✅ Exámenes (Exams)

All exams are prepared to be run directly with the Run Code extension in Visual Studio Code, without special commands or external libraries.

---

### 🧩 Librerías científicas (solo prácticas 7 y 8)

- `minpack.f90`: Used in practice 7 to solve nonlinear systems..
- `quadpack.f90`: Used in practice 8 for numerical integration.

Each of these practices includes detailed instructions for compilation and execution.

---
## 4. Technical Information
## 🔬 What are MINPACK and QUADPACK?

### 🧠 MINPACK – Solving Nonlinear Systems

- **MINPACK** is a numerical library written in Fortran specialized in solving systems of nonlinear equations. Official documentation available at [Netlib](https://www.netlib.org/minpack/).
- It implements efficient and robust algorithms based on methods such as **Levenberg-Marquardt**.
- In this project, MINPACK is used in **Practice 7**, whose goal is to solve a nonlinear system posed in the assignment.
- The library facilitates the implementation of the method without having to develop complex routines from scratch for computing Jacobians, iterations, tolerances, etc.

### ∫ QUADPACK – Adaptive Numerical Integration

- **QUADPACK** is a library written in Fortran that provides algorithms for **one-dimensional numerical integration**.
- It is designed to handle difficult integrands, including functions with peaks, discontinuities, or infinite domains.
- In this project, QUADPACK is used in **Practice 8**, which involves calculating **definite integrals** of complicated functions with high precision.
- Thanks to this library, methods like **adaptive quadrature** can be used to obtain more accurate and efficient results than basic methods such as Simpson’s rule.

---

Both libraries are used only in practices 7 and 8 due to the **more complex nature of the problems posed** in those exercises:

- In **Practice 7**, a nonlinear system requiring advanced optimization techniques is solved.
- In **Practice 8**, numerical integration is performed on functions that are difficult to handle analytically.

These professional tools allow tackling problems with already validated algorithms, which **reduces errors, improves accuracy**, and **speeds up code development**.

---

## 💻 Environment Used

- **Operating System:** macOS  
- **Compiler:** `gfortran` version 9.0 or higher  
- **Editor:** Visual Studio Code  
- With extensions for **Fortran** and **C** available from the Marketplace

| Tool                | Recommended Version | Download Link                               |
|---------------------|---------------------|--------------------------------------------|
| Visual Studio Code   | Latest              | https://code.visualstudio.com/              |
| Modern Fortran Ext.  | 3.x or higher       | https://marketplace.visualstudio.com/items?itemName=fortran-lang.fortran |
| gfortran (macOS)     | 9.0 or higher       | https://github.com/fxcoudert/gfortran-for-macOS/releases |

---


## ⚙️ Environment Setup on macOS

Guide for installing and using Fortran (gfortran) on macOS with Visual Studio Code — without using Homebrew

This guide explains how to install and use **gfortran** on macOS using **Visual Studio Code** and the **Modern Fortran** extension, without the need for Homebrew. It is designed so that any user can set up their development environment and compile Fortran programs easily.

---

### ⚖️ Legal Notice

gfortran and GCC are free-to-use compilers for Fortran 95/2003/2008/2018 and other languages such as C and C++.  
They can be downloaded from:

- [GFortran Binaries](http://gcc.gnu.org/wiki/GFortranBinaries)

The BLAS, LAPACK, and Minpack libraries are free to use and can be obtained from:

- [Example Programs and Libraries](https://people.sc.fsu.edu/~jburkardt/f_src/f_src.html)

---

### 🚫 General Best Practices

- Avoid using **spaces** in folder and file names.
- Do not use the desktop or "Documents" folders with spaces for compiling programs.
- Avoid using USB drives to compile and run programs.
- Use simple file names like `program.f90`.

---


### 🛠 Step-by-Step Installation

#### 1. Visual Studio Code

If you don't have it installed yet, download it from [VS Code](https://code.visualstudio.com/) and install it on your Mac.

---

#### 2. Modern Fortran Extension

1. Open VS Code.  
2. Go to the **Extensions** tab (square icon).  
3. Search for **Modern Fortran** and click **Install**.

This will provide you with:

- Syntax highlighting.  
- Basic autocomplete.  
- Recognition of `.f90`, `.f95`, `.f03` files, etc.  
- Support for compiling from the integrated terminal.

---

#### 3. Manual Installation of gfortran (without Homebrew)

1. Go to [GFortran for macOS Releases](https://github.com/fxcoudert/gfortran-for-macOS/releases)  
2. Download the installer matching your processor:  
   - **ARM (M1/M2/M3)** → ARM `.dmg` file.  
   - **Intel** → Intel `.dmg` file.  
3. Open the `.dmg` and follow the installation steps.  
4. This will install `gfortran` in `/usr/local/bin` by default.

---

#### 4. Installation Verification

Open Terminal and run:

```bash
gfortran --version
```

Deberías ver algo como:

```
GNU Fortran (GCC) X.X.X
```

---
## 5. Others

## ▶️ Using gfortran in Visual Studio Code

### 1. Simple Programs (without external libraries)

1. Create a `.f90` or `.f95` file in VS Code.  
2. Use the **Run ▶️** button to compile and run directly.  
3. Ideal for programs that do not require external libraries.

---

### 2. Programs Using External Libraries (BLAS, LAPACK, Minpack)

1. Open the **Integrated Terminal** in VS Code.  
2. Compile your program including the necessary libraries:

```bash
gfortran program.f90 -o program -L/path/to/libraries -llapack -lminpack

```

3. Run the program::

```bash
./program
```

> ⚠️ Replace /path/to/libraries with the actual path where your libraries are located.

---

## 💡 Best Practices

- Always use **IMPLICIT NONE** to avoid implicit type errors.  
- Keep projects organized in folders dedicated to Fortran.  
- Familiarize yourself with the libraries you use (BLAS, LAPACK, Minpack) and their versions.

---

## 🔗 Useful Resources

- [Modern Fortran VS Code Extension](https://marketplace.visualstudio.com/items?itemName=fortran-lang.fortran)  
- [Fortran Libraries (BLAS, LAPACK, Minpack)](https://people.sc.fsu.edu/~jburkardt/f_src/f_src.html)  
- [GFortran for macOS Releases](https://github.com/fxcoudert/gfortran-for-macOS/releases)

---

## 📚 Additional Documentation

- Each practice and exam includes a `.D1` statement file with problem details, expected input/output, and implementation objectives.

- Practices 7 and 8, requiring the use of external scientific libraries (`minpack` and `quadpack`), contain **additional instructions** for proper compilation, linking, and execution in the local environment.

- This documentation ensures the **reproducibility** of all results and facilitates the student's independent work.

🔙 [Back to Scientific-Programming](../..)
