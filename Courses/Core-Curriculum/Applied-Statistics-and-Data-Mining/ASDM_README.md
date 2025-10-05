# 📊 Applied Statistics & Data Mining

📁 This sub-folder belongs to the `Core-Curriculum` inside the `Courses` directory of the general repository for the Master's Degree in Mathematical Engineering (UCM). It corresponds to the **Applied Statistics & Data Mining** course of the Master's Degree in Mathematical Engineering (Complutense University of Madrid). Here, the **assignments**, **objectives**, **competences**, and **submission guidelines** for the course are collected.

---

## 📑 Index

- [📘 Teaching Guide](#-teaching-guide)  
  - [📌 General Information](#-general-information)  
  - [🎯 Course Objectives](#-course-objectives)  
  - [🧠 Competences](#-competences)  
  - [🔄 Course Structure](#-course-structure)  
- [🧪 Assignments and Projects](#assignments-and-projects)  
- [📊 Assignments Evaluation](#-assignments-evaluation)  
- [📦 Submission and Evaluation Guidelines](#-submission-and-evaluation-guidelines)  
- [🗂️ Structure of `Applied-Statistics-Data-Mining/`](#structure-of-applied-statistics-data-mining)  
- [🖥️ Environment Used](#️-environment-used)

---

## 📘 Teaching Guide

### 📌 General Information

- **Course:** Applied Statistics & Data Mining (Code: 604330)  
- **Study Plan:** Master's Degree in Mathematical Engineering (2010–11)  
- **Type:** Core Curriculum  
- **ECTS:** 9  
- **Semester:** 1st  
- **Requirements:** Basic knowledge of Probability and Statistics  
- **Tools:** R / Python

---

### 🎯 Course Objectives

The course aims to provide students with:

1. Theoretical and practical knowledge to **apply statistical tools** effectively.
2. Skills for **time series modeling**, **dimensionality reduction**, and **data clustering**.
3. Understanding of **relationships among variables** and their interpretation.
4. Ability to build predictive models for **classification and regression**.
5. Experience using programming languages (**R**, **Python**) for real-world applications.
6. Solid foundation to tackle **data-driven decision-making** problems in science, industry, or society.

---

## 🧠 Competences

### 🔹 General

- **CG1:** Apply acquired knowledge to new or multidisciplinary contexts.  
- **CG2:** Formulate and justify hypotheses, arguments, and work plans.  
- **CG3:** Make judgments based on standards, reflection, or external norms.  
- **CG4:** Communicate results clearly to both expert and non-expert audiences.  
- **CG7:** Abstract real-world problems into mathematical/statistical models.

### 🔹 Transversal

- **CT1:** Professionally apply knowledge in case studies and problem-solving.  
- **CT2:** Gather and interpret scientific and technical data with critical thinking.

### 🔹 Specific

- **CE1:** Solid training in statistics, stochastic models, and decision-making.  
- **CE2:** Ability to plan solutions considering resources and constraints.  
- **CE3:** Use of advanced computational tools for complex problems.  
- **CE4:** Develop autonomous learning in statistics and mathematics.  
- **CE5:** Solve real-world statistical-computational problems.  
- **CE7:** Manage and analyze large datasets using bibliographic resources.

---

## 🔄 Course Structure

### 📚 Theoretical Classes

- Expository presentation of statistical and data mining concepts.  
- Topics: probability, inference, regression, clustering, classification, etc.

### 💻 Practical Sessions

- Case studies and exercises using **R**, **Python**, or **SAS**.  
- Focus on interpretation and application of techniques.

### 🧪 Practices and Projects

- Real-world datasets analyzed through individual or group work.  
- Emphasis on **coding**, **report writing**, and **insight communication**.

---

## 🧪 Assignments for the 2025-26 Course

| Assignment/Project | Description                                | Folder / Files                    | Weight in Final Grade |
|--------------------|--------------------------------------------|----------------------------------|------------------------|
| 1                  | Time Series Analysis (TEMA 2)              | `Assignment1/`                   | 30%                   |
| 2                  | Unsupervised Learning (TEMA 4)             | `Assignment2/`                   | 30%                   |
| 3                  | Supervised Learning (TEMA 5)               | `Assignment3/`                   | 30%                   |

> 📌 *Students must pass each main component (1, 2, 3) independently to pass the course. Failing any requires completion in the extraordinary call.*

---

## 📊 Assignments Evaluation

- Each major assignment represents **30%** of the final grade.  
- Attendance and participation contribute an additional **10%**.  
- **All assignments are mandatory** and must be passed individually.  
- Evaluation criteria:
  - Correctness and efficiency of the solution.
  - Code quality and documentation.
  - Analytical insight and result interpretation.
  - Report clarity and presentation.

---

## 📦 Submission and Evaluation Guidelines

✅ **Submission format:**

- Scripts: `.R`, `.py`, or `.sas` depending on assignment.  
- Dataset(s) used (e.g., `.csv`, `.txt`)  
- Report: `.pdf` or `.md` summarizing methods and results  
- Submission: Compressed folder named as  
  `AssignmentX_LastName_FirstName.zip`

📤 **Delivery:**

- Submit via the **university virtual classroom** or channels defined by the instructor.

---

## 🗂️ Structure of `Applied-Statistics-Data-Mining/`

```plaintext
Applied-Statistics-Data-Mining/
├── ASDM_README.md                      # This overview document
│
├── Exercises_Exams/                    # Assignments and exams
│   ├── Assignment1/                    # Time Series
│   │   ├── scripts/                    # R / Python / SAS
│   │   ├── data/                       # Input datasets
│   │   ├── report.pdf
│   │   └── README.md
│   ├── Assignment2/                    # Unsupervised Learning
│   ├── Assignment3/                    # Supervised Learning
│   └── Final_Project/ (optional)
│
└── Theory_SP/                          # Lecture notes and slides
    ├── Lecture1_Intro.pdf
    ├── Lecture2_TimeSeries.pdf
    ├── Lecture3_Modeling.pdf
    ├── ...
    └── Bibliography.md
```

---

## 🖥️ Environment Used

For developing and running the assignments and projects of the course, the following environment has been used:

- **Operating System:** Windows 10 / macOS / Linux (varies by user)  
- **Programming Languages:** R (version 4.x), Python (version 3.x), SAS (version may vary)  
- **Editors / IDEs:** RStudio, Jupyter Notebooks, Visual Studio Code, SAS Studio (or local SAS installation)  
- **Main Libraries and Tools:**  
  - *R:* `tidyverse`, `caret`, `data.table`, `ggplot2`  
  - *Python:* `pandas`, `scikit-learn`, `matplotlib`, `seaborn`, `numpy`  
  - *SAS:* Base procedures and `SAS/STAT` for statistical modeling  

> Installation and setup instructions are provided in each assignment’s `README.md`.

---
### 📥 Installation & Setup

Detailed setup instructions, including package installation and environment configuration, are provided in the `README.md` file of each assignment folder.

> 💡 *Students are encouraged to set up virtual environments or use tools like `conda`, `renv` (R), or Docker if needed to isolate dependencies.*


