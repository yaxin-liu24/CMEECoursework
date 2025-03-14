# MiniProject: Model Comparison and Analysis

## Overview
This project focuses on analyzing and comparing different statistical models using AIC and BIC values. The workflow involves data preparation, model fitting, and statistical analysis, with results documented in a final report.

## Files and Their Purpose
- **code/**: Contains all Jupyter Notebook scripts for data preparation, model fitting, and analysis.
  - `Data_preparation_script.ipynb`: Cleans and preprocesses the dataset.
  - `Model_fitting_script.ipynb`: Fits various statistical models to the data.
  - `Analysis_script.ipynb`: Performs model evaluation and comparison.
  - `references.bib`: Stores references for citations in the report.
  - `report.tex`: LaTeX file documenting the methodology, results, and conclusions.

- **data/**: Stores raw datasets used for modeling.
  - `LogisticGrowthData.csv`: Contains experimental growth data.
  - `LogisticGrowthMetaData.csv`: Provides additional metadata for the dataset.

- **results/**: Directory for storing output files such as model comparisons and visualizations.
  - `.gitkeep`: Ensures the directory is tracked in Git repositories.

- **sandbox/**: A workspace for temporary or experimental scripts and data processing.
  - `.gitkeep`: Ensures the folder remains in version control.

## How to Run the Project

# Go to “code” directory
cd ~/miniproject/code

# Give script execution permission (only do it once)
chmod +x run_MiniProject.sh

# run
./run_MiniProject.sh

# The script requires:
- Jupyter Notebook for executing .ipynb files
- LaTeX (pdflatex) for compiling the report
If not installed, install them using:
pip install jupyter
sudo apt install texlive-latex-base  # For Ubuntu
brew install mactex # For macOS

## Dependencies
- Python 3.11.5
- Jupyter Notebook
- LaTeX (for compiling `report.tex`)

## Packages
- hashlib: Provides secure hash functions (e.g., MD5, SHA-256) for generating unique identifiers or checksums.
- lmfit: A library for non-linear least-squares fitting, allowing flexible model fitting with parameter constraints.
- NumPy: A fundamental package for numerical computing in Python, offering support for arrays, linear algebra, and mathematical functions.
- Pandas: A data manipulation and analysis library, providing data structures like DataFrames for handling structured datasets.
- Matplotlib: A visualization library used for creating static, animated, and interactive plots in Python.
- SciPy: A scientific computing library that extends NumPy, providing advanced mathematical functions, optimization, and statistical tools.
- os: A built-in module for interacting with the operating system, such as file handling and directory management.
- seaborn: A statistical data visualization library based on Matplotlib, designed for creating attractive and informative graphs.

## Contact
For questions or contributions, please reach out to the project maintainers Yaxin Liu（yaxin.liu24@imperial.ac.uk）

