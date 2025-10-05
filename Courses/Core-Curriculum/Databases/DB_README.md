# 🗃️ Databases

📁 This sub-folder is part of the `Core-Curriculum` inside the `Courses` directory of the Master's Degree in Mathematical Engineering (UCM). It corresponds to the **Databases** course and includes all relevant **assignments**, **objectives**, **competences**, and **submission guidelines**.

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
- [🗂️ Structure of `Databases/`](#structure-databases)  
- [🖥️ Environment Used](#️-environment-used)

---

## 📘 Teaching Guide

### 📌 General Information

- **Course:** Databases (Code: 604329)  
- **Study Plan:** Master's Degree in Mathematical Engineering (2010–11)  
- **Type:** Core Curriculum  
- **ECTS:** 6.0  
- **Semester:** 1st  
- **Requirements:**  
  - Procedural programming (basic level)  
  - Algebra (intermediate level)  

---

### 🎯 Course Objectives

This course aims to provide students with:

1. Advanced knowledge of database systems, including relational and non-relational models.  
2. Skills to design, manage, and interact with databases using real-world tools.  
3. Experience working with commercial cloud-based environments.  
4. A practical foundation in SQL and NoSQL database systems.  
5. Competence in database modeling, normalization, and administration.  

---

## 🧠 Competences

### 🔹 General

- **CG2:** Formulate and justify hypotheses and plans.  
- **CG3:** Make informed judgments based on standards or reflection.  
- **CG7:** Abstract real-world problems into mathematical or computational models.

### 🔹 Transversal

- **CT1:** Apply knowledge professionally in problem-solving.  
- **CT2:** Gather and critically interpret scientific and technical data.

### 🔹 Specific

- **CE1:** Solid training in mathematical and computational techniques.  
- **CE3:** Use advanced computational tools for complex problems.  
- **CE5:** Solve real-world problems using modeling and computation.  
- **CE7:** Manage and analyze datasets using appropriate software tools.

---

## 🔄 Course Structure

### 📚 Theoretical Classes

- Presentation of fundamental database concepts.
- Application-oriented discussions using case studies.

### 💻 Practical Sessions

- Guided lab exercises.
- SQL programming.
- Cloud database systems.

### 🧾 Presentations

- Individual and group presentations of practical projects.

---

## 🧪 Assignments for the 2025-26 Course

| Assignment / Module                      | Description                                              | Folder / Files       | Weight |
|------------------------------------------|----------------------------------------------------------|----------------------|--------|
| 1. Practice Assignments                  | Series of required SQL & modeling tasks                  | `Practices/`         | 30%    |
| 2. Final Project                         | Design, build, and present a complete DB project         | `FinalProject/`      | 60%    |

> 📌 Note: *All components are mandatory. Non-delivered or failed modules may require recovery tasks or resits.*

---

## 📊 Assignments Evaluation

- **Final Project (60%)**  
  - Design quality, normalization, and use of SQL/NoSQL features.  
  - Clarity and depth of the oral or written presentation.  

- **Practice Assignments (30%)**  
  - Correctness and completeness.  
  - Timely submission via lab sessions.  

- **Participation (10%)**  
  - Attendance and contribution to class discussions.  

---

## 📦 Submission and Evaluation Guidelines

✅ **Submission Format:**

- Scripts: `.sql`, `.py`, or equivalent if required  
- Models: `.pdf`, `.png` or `.dbdiagram.io` exports  
- Final Report: `.pdf` or `.md` explaining methods and decisions  

📤 **Delivery:**

- Submit via the **university virtual classroom** or channels defined by the instructor.

---

## 🗂️ Structure of `Databases/` <a id="structure-databases"></a>

```plaintext
Databases/
├── DB_README.md                      # This overview document
│
├── Practices/                        # Required assignments and mini-projects
│   ├── Practice1_Modeling/
│   ├── Practice2_SQL/
│   └── README.md
│
├── FinalProject/                     # Final individual or group project
│   ├── models/                       # Conceptual & relational models
│   ├── scripts/                      # SQL or API scripts
│   ├── report.pdf                    # Project report
│   └── presentation.pptx
│
└── Theory_DB/                        # Lecture notes and references
    ├── Slides_Intro.pdf
    ├── Notes_SQL.pdf
    ├── Cloud_DB_Services.md
    └── Bibliography.md
```
---

## 🖥️ Environment Used

For developing and completing the coursework, the following environment and tools are used:

- **OS:** Windows, macOS, or Linux  
- **Languages:** SQL, Python (for automation or APIs)  
- **IDEs & Tools:** pgAdmin, MySQL Workbench, Visual Studio Code, DBeaver, Google Cloud/Azure/AWS DB tools, Jupyter Notebook (for Python integration)  
- **Databases:**  
  - *Relational:* PostgreSQL, MySQL  
  - *NoSQL:* MongoDB, Firebase  
- **Python Libraries (optional):** sqlalchemy, pymongo, psycopg2, pandas, dash, streamlit  
