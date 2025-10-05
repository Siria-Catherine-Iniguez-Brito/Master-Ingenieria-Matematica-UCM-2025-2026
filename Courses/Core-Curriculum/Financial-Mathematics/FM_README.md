# 📈 Financial Mathematics

📁 This sub-folder is part of the `Core-Curriculum` inside the `Courses` directory of the Master's Degree in Mathematical Engineering (UCM). It corresponds to the **Fundamentals of Financial Mathematics** course and includes all relevant **assignments**, **objectives**, **competences**, and **submission guidelines**.

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
- [🗂️ Structure of `Financial-Mathematics/`](#structure-financial-mathematics)
- [🖥️ Environment Used](#-environment-used)

---

## 📘 Teaching Guide

### 📌 General Information

- **Course:** Fundamentals of Financial Mathematics (Code: 604334)  
- **Study Plan:** Master's Degree in Mathematical Engineering (2010–11)  
- **Type:** Core Curriculum  
- **ECTS:** 6.0  
- **Semester:** 2nd  
- **Prerequisites:** Basic knowledge of Linear Algebra, Probability, and Multivariable Calculus.  
- **Tools:** Matlab, Excel (Visual Basic), R, Python

---

### 🎯 Course Objectives

This course aims to provide students with:

1. Understanding of basic financial instruments.  
2. Use of mathematical tools to describe and analyze financial markets.  
3. Mastery of fundamental concepts of investment, risk, hedging, and valuation.

---

## 🧠 Competences

### 🔹 General

- Ability to understand and apply the language and fundamental principles of financial markets, portfolio management, and instrument valuation.

### 🔹 Specific

- Analyze investments and portfolio management in deterministic and elementary stochastic contexts.  
- Implement price evolution models, understand basic financial instruments, and their valuation.

---

## 🔄 Course Structure

### 📚 Theoretical Classes

- Introduction to interest theory: interest and principal, present value, internal rate of return.  
- Fixed income assets: bonds, valuation, yield.  
- Term structure of interest rates: forward rates.  
- Derivatives: forwards, futures, swaps.  
- Asset evolution models: binomial, additive, multiplicative models; lognormal variables; random walk; Wiener process; Ito’s lemma.  
- Basic option theory: concepts, put-call parity.  
- Black-Scholes equation.  
- Markowitz portfolio theory: mean-variance optimization, CAPM, Sharpe ratio.  
- Additional option topics: trinomial trees, Monte Carlo methods, finite difference methods for European, Barrier, and American options.  
- Stochastic differential equations: parameter estimation, simulation and modeling of financial series.

### 💻 Practical Sessions

- Problem-solving sessions using Matlab, Excel (Visual Basic), R, or Python.  
- Emphasis on implementation and discussion.

---

## 🧪 Assignments for the 2025-26 Course

| Assignment/Project | Description                               | Folder / Files                 | Weight in Final Grade |
|--------------------|-------------------------------------------|-------------------------------|-----------------------|
| 1                  | Problem sets on Financial Instruments     | `Assignment1/`                | 80-90%                |
| 2                  | Class participation and exercises         | N/A                          | 10-20%                |

> 📌 Note: *Students must submit written problem sets and actively participate in class.*

---

## 📊 Assignments Evaluation

- Written assignments: **80-90%** of the final grade.  
- Attendance and active participation: **10-20%**.  
- Evaluation based on correctness, clarity, and completeness of solutions.

---

## 📦 Submission and Evaluation Guidelines

✅ **Submission format:**

- Solutions submitted as `.pdf` or `.docx` files.  
- Include all supporting code/scripts where applicable (Matlab `.m`, Excel `.xlsm`, R `.R`, Python `.py`).  

📤 **Delivery:**

- Submit via the university virtual classroom or as instructed by the professor.

---

## 🗂️ Structure of `Financial-Mathematics/` <a id="structure-financial-mathematics"></a>

```plaintext
Financial-Mathematics/
├── FM_README.md                          # This overview document
│
├── Assignments/
│   ├── Assignment1/                     # Problem sets on financial instruments
│   │   ├── code/                        # Matlab, R, Python, Excel scripts
│   │   ├── data/                        # Input datasets if any
│   │   ├── solutions.pdf                # Solutions document
│   │   └── README.md
│
└── Lectures/                            # Lecture notes and slides
    ├── Lecture1_InterestTheory.pdf
    ├── Lecture2_Derivatives.pdf
    ├── Lecture3_PortfolioTheory.pdf
    ├── ...
    └── Bibliography.md
```
---
## 🖥️ Environment Used

For the development and execution of course activities, the following environment and tools are recommended:

- **OS:** Windows, macOS, or Linux
- **Languages & Tools:** Matlab, Excel (with Visual Basic), R, Python
- **IDEs:** Matlab IDE, Visual Studio Code (optional)
- **Libraries:**
  - Matlab Financial Toolbox
  - Excel Solver
  - R packages: quantmod, TTR, PerformanceAnalytics
  - Python packages: numpy, pandas, scipy, matplotlib, statsmodels

