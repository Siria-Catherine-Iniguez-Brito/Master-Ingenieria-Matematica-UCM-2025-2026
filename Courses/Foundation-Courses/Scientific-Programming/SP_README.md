
# 🚀 Scientific Programming

📁 This sub-folder belongs to the `Foundation-Courses` folder, inside the `Courses` directory of the general repository for the Master's Degree in Mathematical Engineering (UCM). It corresponds to the Scientific Programming course of the Master's Degree in Mathematical Engineering (Complutense University of Madrid). Here, the **assignments**, **objectives**, **competences**, and **submission guidelines** for the course are collected.

## 📑 Index

- [📘 Teaching Guide](#-teaching-guide)  
  - [📌 General Information](#-general-information)  
  - [🎯 Course Objectives](#-course-objectives)  
  - [🧠 Competences](#-competences)  
  - [🔄 Course Structure](#-course-structure)  
- [🧪 Assignments for the 2025-26 Course](#assignments-for-the-2025-26-course)  
- [📊 Assignments Evaluation](#-assignments-evaluation)  
- [📦 Submission and Evaluation Guidelines](#-submission-and-evaluation-guidelines)  
- [🗂️ Structure of `Scientific-Programming/`](#structure-scientific-programming)
- [🖥️ Environment Used](#️-environment-used)

---

## 📘 Teaching Guide

### 📌 General Information
- **Course:** Scientific Programming (Code: 608063)  
- **Study Plan:** Master's Degree in Mathematical Engineering (2010-11)  
- **Type:** Complementary Training  
- **ECTS:** 3.0  
- **Semester:** 1st  

## 🎯 Course Objectives

- 🧮 Learn and practice programming in **Fortran 95** and **C**.  
- 🔧 Use **scientific libraries** for solving numerical problems.  
- 💻 Implement and analyze **complex numerical algorithms**.  
- 🛠️ Develop skills for **debugging and error correction** in code.

---

## 🧠 Competences

- **General (CG5):** Solve mathematical problems computationally using appropriate software.  
- **Specific (CE3 and CE6):**  
  - Knowledge of Fortran and C.  
  - Use of scientific libraries.  
  - Algorithm implementation.  
  - Numerical problem solving.

## 🔄 Course Structure

- 📚 **Theoretical classes** *(1/3 of face-to-face time)*  
  → Explanation of language features and libraries with examples.  

- 💻 **Practical classes** *(2/3 of face-to-face time)*  
  → Development, testing, and debugging of scientific programs.  

- 🧑‍💻 **Laboratories**  
  → Free time for experimentation, practice, and reinforcement of concepts.

---

## Assignments for the 2025-26 Course

| Assignment No. | Assignment                  | Statement Filename                      | Deadline                 |
|----------------|-----------------------------|---------------------------------------|--------------------------|
| 1              | Direct and Inverse Function | P1-FUNCION-DIRECTA-INVERSA.D1         | Thursday, Sept 11, 2025  |
| 2              | Center and Corner Submatrix | P2-SUBMATRIZ-CENTRO-ESQUINAS.D1       | Thursday, Sept 11, 2025  |
| 3              | Next Combination            | P3-SIGUIENTE-COMBINACION.D1            | Thursday, Sept 18, 2025  |
| 4              | Triangle                    | P4-TRIANGULO.D1                        | Thursday, Sept 18, 2025  |
| 5              | Minimum n Bounds            | P5-MIN-n-cotas.D1                      | Thursday, Oct 2, 2025    |
| 6              | Runs                        | P6-RACHAS.D1                          | Thursday, Oct 2, 2025    |
| 7              | Nonlinear System            | P7-SISTEMA-NO-LINEAL.D1                | Thursday, Sept 25, 2025  |
| 8              | Integral                    | P8-INTEGRAL-1.D1                      | Thursday, Sept 25, 2025  |

---

## 📊 Assignments Evaluation

- 🔹 The combined score for assignments 1 and 2 will be at most 1.8 points. The maximum for each is 1.0 points. Submission deadline: Thursday, Sept 11, 2025.

- 🔹 The combined score for assignments 3 and 4 will be at most 2.4 points. The maximum for each is 1.3 points. Submission deadline: Thursday, Sept 18, 2025.

- 🔹 The combined score for assignments 7 and 8 will be at most 1.6 points. The maximum for each is 0.9 points. Submission deadline: Thursday, Sept 25, 2025.

- 🔹 The combined score for assignments 5 and 6 will be at most 3.2 points. The maximum for each is 1.7 points. Submission deadline: Thursday, Oct 2, 2025.

- 🔹 On the last day of the course, Friday, Sept 12, 2025, in-class exercises will be held with a maximum score of 1.0 points.

---

## 📦 Submission and Evaluation Guidelines

✅ **Submission format:**

- Source code: `Px.f90` or `Px.c` *(depending on language and assignment number)*  
- Data file: `DatosX.dat`  
- Result file: `SolucionX.sol`  
- Statement: `PX-Assignment_name.D1`

📤 **Official submission:**

> 📌 **Note:** Assignments must be sent to the professor responsible for each language (Fortran or C) using the channels indicated in the virtual classroom or official teaching guide.

---

⚠️ **Important rules:**

- Solutions printed only on screen will **not** be graded.  
- Late submissions will incur **penalties**.  
- Once graded, the assignment grade is **final**.  
- Assignments must be done **individually**.

🚫 **Copying or plagiarism implies:**

- Zero points on the affected assignment.  
- Possible **course failure**.  
- Possible **disciplinary proceedings**.

---

<h2 id="structure-scientific-programming">🗂️ Structure of <code>Scientific-Programming/</code></h2>


```plaintext
Scientific-Programming/
├── SP_README.md
│
├── Exercises_Exams/
│   ├── SP_EE_README.md/
│   │
│   ├── Practica1/
│   │   ├── Practica1.f90 / Practica1.c
│   │   ├── Datos1.dat
│   │   ├── Solucion1.sol
│   │   └── P1-FUNCION-DIRECTA-INVERSA.D1
│   ├── Practica2/
│   │   └── ...
│   ├── Practica3/
│   │   └── ...
│   ├── Practica4/
│   │   └── ...
│   ├── Practica5/
│   │   └── ...
│   ├── Practica6/
│   │   └── ...
│   ├── Practica7/
│   │   └── ...
│   ├── Practica8/
│   │   ├── Practica8.f90 / Practica1.c
│   │   ├── Datos8.dat
│   │   ├── Solucion8.sol
│   │   └── P8-INTEGRAL-1.D1
│   ├── Examen1/
│   │   ├── Examen1.f90 
│   │   ├── DatosE1.dat
│   │   ├── SolucionE1.sol
│   │   └── E1-SUBMATRIZ-ABSMIN.D1
│   └── Examen2/
│       ├── Examen2.f90 
│       ├── DatosE2.dat
│       ├── SolucionE2.sol
│       └── E2-ECUACION.D1
│ 
└──Teoria/
    └── Material_teorico.pdf (y otros recursos)

```

📚 **Detailed documentation in Exercises_Exams**  
The file `SP_EE_README.md` (inside the `Exercises_Exams` folder) explains in depth:

- How to compile each assignment and exam.
- Description of the development environment used.
- Scientific libraries used and their configuration.
- Installation and setup process on my personal machine.
- Concrete examples of compilation and execution on my system.

This documentation complements the general information presented here, facilitating reproducibility and autonomous development for the student.
--

## 🖥️ Environment Used

For developing and compiling the assignments and exams of the course, the following environment has been used:

- Operating System: macOS
- Compiler: gfortran version 9.0 or higher
- Editor: Visual Studio Code, with extensions for Fortran and C, improving coding and debugging experience.


