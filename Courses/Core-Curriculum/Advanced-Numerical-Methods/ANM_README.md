# 🧮 Advanced Numerical Methods

📁 This sub-folder is part of the `Core-Curriculum` inside the `Courses` directory of the Master's Degree in Mathematical Engineering (UCM). It corresponds to the **Advanced Numerical Methods** course and includes all relevant **assignments**, **objectives**, **competences**, and **submission guidelines**.

---

## 📑 Index

- [📘 Teaching Guide](#-teaching-guide)  
  - [📌 General Information](#-general-information)  
  - [🎯 Course Objectives](#-course-objectives)  
  - [🧠 Competences](#-competences)  
  - [🔄 Course Structure](#-course-structure)  
- [🧪 Assignments for the 2025-26 Course](#-assignments-for-the-2025-26-course)  
- [📊 Assignments Evaluation](#-assignments-evaluation)  
- [📦 Submission and Evaluation Guidelines](#-submission-and-evaluation-guidelines)  
- [🗂️ Structure of `Advanced-Numerical-Methods/`](#structure-of-advanced-numerical-methods)  
- [🖥️ Environment Used](#️-environment-used)

---

## 📘 Teaching Guide

### 📌 General Information

- **Course:** Advanced Numerical Methods (Code: TBD)  
- **Study Plan:** Master's Degree in Mathematical Engineering (2010–11)  
- **Type:** Core Curriculum  
- **ECTS:** 4.0  
- **Semester:** 1st  
- **Requirements:** Background in mathematics and basic MATLAB programming  
- **Tools:** MATLAB, Python, others

---

### 🎯 Course Objectives

This course aims to train students to:

1. Implement numerical methods for initial and boundary value problems (ODEs and PDEs).
2. Analyze the stability and convergence order of numerical methods.
3. Design finite difference schemes for various types of equations.
4. Derive variational formulations for elliptic problems.
5. Construct and use finite element spaces and basis functions.
6. Program numerical schemes using MATLAB or similar scientific environments.
7. Simulate and analyze models relevant to science and technology.

---

## 🧠 Competences

### 🔹 General

- Apply methods to solve initial and boundary value problems.
- Analyze the stability and convergence of numerical methods.
- Formulate finite difference and finite element schemes.
- Understand and implement variational approaches.
- Translate complex models into numerical simulations.

### 🔹 Specific

- Program and implement numerical solvers for real-world models.
- Apply and adapt finite difference, finite element, and finite volume methods.
- Use computational environments for simulation and analysis.
- Evaluate the effectiveness and accuracy of implemented methods.

---

## 🔄 Course Structure

### 📚 Theoretical-Practical Classes

- Each session includes a short theoretical introduction followed by hands-on programming and problem solving.
- Problems modeled from fields such as physics, biology, and engineering.
- Strong emphasis on practical implementation and experimentation.

---

## 🧪 Assignments for the 2025-26 Course

| Assignment/Project         | Description                                                                 | Folder / Files            | Weight in Final Grade |
|---------------------------|-----------------------------------------------------------------------------|----------------------------|------------------------|
| 1                         | ODE Solvers (Single/Multistep, Implicit/Explicit, Adaptive)                 | `Assignment1/`             | 25%                   |
| 2                         | Finite Difference Methods for PDEs (Elliptic & Heat Equations)              | `Assignment2/`             | 25%                   |
| 3                         | Finite Element Methods (Elliptic + Heat Equation with CN & Euler methods)   | `Assignment3/`             | 25%                   |
| 4                         | Finite Volume and Eikonal Equation Treatment                                | `Assignment4/`             | 25%                   |

> 📌 *Each assignment targets a specific class of methods and must be completed individually unless otherwise specified.*

---

## 📊 Assignments Evaluation

- Grading is based on the following distribution:

  - **ODE Methods:** 25%  
  - **Finite Differences (PDE):** 25%  
  - **Finite Element Methods:** 25%  
  - **Finite Volumes & Eikonal:** 25%

- **Evaluation Criteria:**
  - Correctness of implementation
  - Efficiency and numerical accuracy
  - Clarity of analysis and documentation
  - Quality and presentation of reports

---

## 📦 Submission and Evaluation Guidelines

✅ **Submission format:**

- Scripts: `.m`, `.py`, or `.ipynb` as appropriate  
- Input/Output files (if applicable)  
- Report: `.pdf` or `.md` explaining methods, results, and conclusions  
- Naming:  
  `AssignmentX_LastName_FirstName.zip`

📤 **Delivery:**

- Upload via the university's virtual campus or the platform indicated by the instructor.
- Strict deadlines apply; late submissions require instructor approval.

---

## 🗂️ Structure of `Advanced-Numerical-Methods/`

```plaintext
Advanced-Numerical-Methods/
├── ANM_README.md                       # This overview document
│
├── Exercises_Exams/
│   ├── ANM_EE_README.md
│   ├── Assignment1/                    # ODE Solvers
│   │   ├── scripts/
│   │   ├── results/
│   │   ├── report.pdf
│   │   └── README.md
│   ├── Assignment2/                    # Finite Differences (PDE)
│   ├── Assignment3/                    # Finite Element Methods
│   └── Assignment4/                    # Finite Volume & Eikonal
│
└── Theory_ANM/                         # Lecture slides and notes
    ├── Lecture1_ODE.pdf
    ├── Lecture2_PDE_FDM.pdf
    ├── Lecture3_FEM.pdf
    ├── Lecture4_FVM_Eikonal.pdf
    └── Bibliography.md

---

## 🖥️ Environment Used

The course relies on the following environment and tools:

- **OS:** Windows, macOS, or Linux

- **Languages:**  
  - MATLAB  
  - Python  

- **IDEs / Tools:**  
  - MATLAB  
  - Visual Studio Code  
  - Jupyter Notebook  

- **Libraries & Packages:**

  - **MATLAB:**  
    - Built-in numerical solvers  
    - Symbolic Math Toolbox  

  - **Python:**  
    - `numpy`  
    - `scipy`  
    - `matplotlib`  
    - `fenics` (for Finite Element Methods)  
    - `sympy`  


