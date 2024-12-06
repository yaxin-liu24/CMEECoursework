Project name / title

    WEEK3 practicals with R

Brief description: 

    This project is designed to focuses on practicing Basic R Syntax to understand the fundamental syntax and programming conventions of R, starting from the ground up; data Processing and exploration: master the principles of data processing, exploration, and visualization using R to uncover insights from datasets.Enhance the efficiency of your R simulations by leveraging vectorization techniques.

Languages: 

    R version 4.3.3 

### PP_Regress.R

- **Description**:  
  This script generates multiple plots containing linear regressions of predator and prey masses grouped by predator lifestage and feeding type from the EcolArchives-E089-51-D1 dataset. It also calculates regression coefficients for each group and saves them to a CSV file.

  - **Functions**:
    - The script does not define reusable functions but performs the following tasks:
      - Creates a combined dataset with log-transformed predator and prey masses.
      - Identifies groups with insufficient data for regression.
      - Generates regression plots faceted by feeding interaction type.
      - Saves regression results to a CSV file.

  - **Arguments**:  
    This script does not require any arguments when running.

- **Dependencies**:  
  - `ggplot2`: For data visualization.
  - `dplyr`: For data manipulation.
  - `broom`: For organizing regression results.

- **Usage**:  
  1. To run the script, use the following command in a terminal:
     ```bash
     Rscript PP_Regress.R
     ```
  - The script will:
    - Load the dataset and preprocess it.
    - Generate a PDF file with regression plots (`PP_Regress_Updated_Fixed.pdf`).
    - Save a CSV file containing regression coefficients (`PP_Regress_Results.csv`).

### Florida.R

- **Description**:  
This report analyzes the annual mean temperature data for Key West to investigate the relationship between year and temperature. 

- **Dependencies**:
  - base (core R functions like cor and sample)
  - graphics (for plotting)

- **Usage**:
  - Run the script with:
  ```bash
  Rscript Florida.R
  ```

  - The script will:
    - Load the dataset KeyWestAnnualMeanTemperature.RData.
    - Compute the observed correlation coefficient.
    - Perform a permutation test with 5,000 iterations.
    - Save a histogram of correlation coefficients to ../results/Florida.pdf.

## FloridaLatexCode.tex

- **Description**:
This LaTeX document generates a report analyzing the correlation between annual mean temperatures in Key West.

- **Dependencies**:
  - LaTeX distribution: Ensure you have a LaTeX compiler such as pdflatex, xelatex, or lualatex installed.
  - Packages:
    - 'geometry':for setting page margins
    - 'setspace':for controlling line spacing
    - 'graphicx':for inserting images
    - 'amsmath' :for mathematical expressions

- **Usage**:
To compile the LaTeX file and generate a PDF
  - Input:
    - The script references the histogram plot Coefficients.pdf located in the ../results directory. Ensure this file exists (run "Florida.R" first) before compiling the LaTeX document.
  - Output:
    - If you want the output PDF to be saved in a specific directory (e.g., ../results), compile with the following command in terminal:
   ```bash
   pdflatex -output-directory=../results FloridaLatexCode.tex
   ```


Project structure and Usage: 

code/: Contains the practical exercises
data/: Contains the data that applyed in codes
results/: store the results of the codes
sandbox/: Contains some excierses and draft

Author name and contact
    Yaxin  yaxin.liu24@imperial.ac.uk
