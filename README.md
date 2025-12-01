Programming Techniques for Scientific Simulations I (PTSS) - Study Notes
Institution: ETH Zürich

Semester: Fall 2025

Course: Programming Techniques for Scientific Simulations I

Format: LaTeX Notes & Scripts

📖 About This Repository
This repository serves as a personal collection of study notes, code scripts, and summaries for the Programming Techniques for Scientific Simulations I course.

The content herein is generated with the assistance of Large Language Models (LLMs). The primary source material for these generations are the official lecture slides provided by the course professors. The goal of this project is to expand upon the bullet points in the slides, generate working code examples from theoretical concepts, and provide a formatted clarification of the subject matter for self-study purposes.

⚠️ Disclaimer
Please read carefully:

Not Official Material: These notes are unofficial and are not endorsed by ETH Zürich or the course lecturers.

LLM Generated: As these documents were generated using AI, they may contain hallucinations, inaccuracies, or subtle errors in the code/math. They should be used as a supplementary tool for clarification, not as the sole source of truth. Always verify with the official lecture notes and textbooks.

Academic Integrity: These scripts are intended for understanding concepts. Do not submit this code as your own solution for graded assignments.

📂 Repository Structure
The repository is organized by week, corresponding to the course syllabus. Each folder contains the LaTeX source code, generated diagrams, and the compiled PDF.

Plaintext

├── week02/         # Introduction & Basics
├── week06/         # [Topic, e.g., C++ Templates]
├── week.../
├── week11/         # [Topic, e.g., Expression Templates]
│   ├── PTSS_week11.tex      # Main LaTeX source
│   ├── PTSS_week11.pdf      # Compiled notes
│   └── images/              # Generated diagrams/plots
├── .gitignore      # Build artifact exclusions
└── README.md       # This file
🛠 Usage & Compilation
The notes are written in LaTeX. To compile a PDF locally from the source .tex files, you can use your preferred LaTeX editor or the command line.

Prerequisites:

A TeX distribution (TeX Live, MacTeX, or MiKTeX)

Compiling via Terminal: Navigate to the specific week's folder and run:

Bash

cd week11
pdflatex PTSS_week11.tex
# You may need to run it twice to resolve cross-references/TOC
pdflatex PTSS_week11.tex
🤝 Contribution
If you find an error in the logic or the code (which is possible given the LLM generation), feel free to open an Issue or submit a Pull Request with the correction.

License & Rights
Course Concepts: Belong to the respective lecturers at ETH Zürich.

Generated Text/Code: Open for educational use.