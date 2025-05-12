# Miniproject Feedback and Assessment

## Report

**"Guidelines" below refers to the MQB report [MQB Miniproject report guidelines](https://mulquabio.github.io/MQB/notebooks/Appendix-MiniProj.html#the-report) [here](https://mulquabio.github.io/MQB/notebooks/Appendix-MiniProj.html) (which were provided to the students in advance).**


**Title:** “Polynomial Regression Models Outperform Logistic and Gompertz Models for Quantifying Microbial Growth Dynamics”

- **Introduction (15%)**  
  - **Score:** 11/15  
  - Contrasts mechanistic vs. polynomial but no crisp question. [MQB Miniproject report guidelines](https://mulquabio.github.io/MQB/notebooks/Appendix-MiniProj.html#the-report) encourage a succinct statement of aims/hypothesis.

- **Methods (15%)**  
  - **Score:** 10/15  
  - Mentions piecewise polynomial, NLLS, but minimal detail on how piecewise segments or iteration is done. The [MQB Miniproject report guidelines](https://mulquabio.github.io/MQB/notebooks/Appendix-MiniProj.html#the-report) call for thorough replicability detail.

- **Results (20%)**  
  - **Score:** 13/20  
  - Concludes cubic/piecewise polynomial best match the data. Lacks numeric quantification of model “wins” or tables summarizing performance.

- **Tables/Figures (10%)**  
  - **Score:** 5/10  
  - No explicit, well-labeled figure references. The [MQB Miniproject report guidelines](https://mulquabio.github.io/MQB/notebooks/Appendix-MiniProj.html#the-report) stress referencing each figure/table thoroughly in text.

- **Discussion (20%)**  
  - **Score:** 14/20  
  - Compares strong empirical fits for polynomials vs. interpretability of logistic/Gompertz. Could expand on overfitting or extrapolation issues.

- **Style/Structure (20%)**  
  - **Score:** 14/20  
  - Logical structure, references are somewhat general. More explicit discussion of how results relate to the introduction is recommended.

**Summary:** Polynomials out-fitting mechanistic models in raw data is the main takeaway, but not a reliable result due ti lack of fitting optimization. Greater numeric detail, referencing, and deeper limitation discussion would have improved clarity.

**Report Score:** 64  

---

## Computing

### Project Structure & Workflow

**Strengths**

   The `run_MiniProject.sh` script in `code/` orchestrates execution of the three notebooks in sequence, ensuring a reproducible pipeline.
* Using Jupyter Notebooks for data preparation, model fitting, and analysis embeds code, outputs, and explanatory text in one place, which can aid understanding (but several problems with this - see below).

**Suggestions**

1. Relying exclusively on notebooks can obscure dependencies between steps. Consider refactoring core logic into standalone Python modules (e.g. `prep.py`, `fit.py`, `evaluate.py`) that the notebooks import, so the same code can be tested and versioned independently of the notebook interface.
2. Document and lock Python dependencies via `requirements.txt` or `Pipfile.lock`. In the shell driver, activate a virtual environment before running notebooks to ensure consistent package versions.
3. Rather than calling `jupyter nbconvert --execute` on each notebook, consider using **papermill** with explicit parameter injection and execution metadata, improving reproducibility and enabling parameter sweeps.

---

### README File

**Strengths**

* Clearly outlines project purpose, file roles, and high-level instructions for running the pipeline .
* Lists required software (Python, Jupyter, LaTeX) and core Python packages (`lmfit`, `pandas`, `numpy`, etc.).

**Suggestions**

1. Add explicit steps to create and activate a Python virtual environment, and install packages via `pip install -r requirements.txt`.
2. Clarify that notebooks require a clean kernel and specify kernel metadata (e.g. Python 3.11). Note any necessary Jupyter extensions.
3. The shell driver is named `run_MiniProject.sh` in code; ensure README matches filename exactly (case and underscore).
4. Expand the `results/` section to list key output files produced by each notebook (e.g. cleaned CSV, fit summary tables, AIC/BIC comparison plots).

---

## Code

####  Data Preparation Notebook (`Data_preparation_script.ipynb`)

* **Strengths**: Interactive data inspection with inline visualizations; stepwise filtering and transformation are clearly annotated.
* **Improvements**:

  * **Cell dependency**: Hidden state can lead to non-linear execution order. Include a clear “Run All” workflow or convert key functions into a module to ensure that rerunning from top always works.
  * **Reusability**: Wrap repeated filtering and feature-engineering code into Python functions or class methods, then call them from notebook cells. This reduces duplication and eases unit testing.

####  Model Fitting Notebook (`Model_fitting_script.ipynb`)

* **Strengths**: Demonstrates fitting multiple models with `lmfit`, including diagnostics and parameter summaries.
* **Improvements**:

  * **Parameter management**: Define a dictionary of model configurations (formula, parameter bounds) at the top of the notebook, then loop programmatically instead of copying fitting code for each model.
  * **Result aggregation**: Collect fit statistics (`AIC`, `BIC`, `R²`) into a single `pandas.DataFrame` rather than separate variables, enabling tidy downstream analysis.
  * **Error handling**: Use `try`/`except` around each fit to capture and log failures without interrupting the notebook execution flow.

#### Analysis Notebook (`Analysis_script.ipynb`)

* **Strengths**: Provides side-by-side comparison of model metrics and visualizes model selection criteria.

* **Improvements**:

  * **Modular analysis**: Instead of embedding raw SQL-like `pandas` queries in cells, encapsulate metric calculations into functions (e.g. `compare_models(df, metric)`), improving readability and reuse.
  * **Parameterization**: Use a cell at the top to specify which metrics or subsets to analyze, making it easy to rerun comparisons across different conditions.

---

## Code Structure & Python Best Practices

**Suggestions**

1. Ensure notebooks use consistent naming conventions (`snake_case`) and import ordering. Consider running **flake8** on `.py` scripts extracted from notebooks.
2. Move core logic out of cells into Python `.py` files under `code/` (e.g. `code/data_prep.py`, `code/model_fit.py`), and import them into notebooks. This enables unit testing with **pytest**.
3. Replace `print()` statements with the `logging` module set to INFO/DEBUG levels, so that long runs produce structured logs rather than fragmented notebook output.
4. Use `pydantic` or custom validators to check incoming DataFrame schemas before fitting, failing early if required columns are missing.
5. Notebook diffs can be noisy. Use **nbdime** for more meaningful diffing, or commit auto-generated Python scripts instead of raw `.ipynb` files.

---

## NLLS Fitting Approach

**Strengths**

* Uses **lmfit** to define models with parameter bounds and custom initial guesses, which is more flexible than `scipy.optimize.curve_fit`.
* Reports AIC and BIC directly from `lmfit` results, facilitating model comparison.

**Suggestions**

1. Implement multi-start sampling (e.g. Latin hypercube) using `lmfit.Minimizer` features or replicate fits with randomized initial guesses to avoid local minima.
2. Tighten bounds based on data-driven heuristics (e.g. `r_max >= 0`, `K >= max(population)`) and flag fits hitting bounds as potential issues.
3. Introduce time-series cross-validation (walk-forward validation) by iteratively withholding final time points to assess predictive performance beyond in-sample criteria.
4. Plot residuals vs. time and parameter correlation heatmaps (via `lmfit.report_fit()`) to detect misspecification or identifiability issues.
5. Compute Akaike weights across models to quantify relative support, and visualize weight distributions rather than just raw AIC/BIC differences.

---

## Critique of your use of Jupyter Notebooks for Production Code

  * **Hidden state**: Execution order can diverge from linear reading order, leading to reproducibility issues.
  * **Version control noise**: JSON metadata and output cells clutter diffs, making code review harder.
  * **Testing limitations**: Difficult to integrate notebooks into CI pipelines; unit tests require extraction of code into modules.
  * **Scalability**: Notebooks are less suitable for long-running jobs or parameter sweeps compared to standalone scripts or CLI tools.

**Recommendation**: Retain notebooks for interactive exploration, but extract stable, reusable code into `.py` modules. Or leverage tools like **papermill** for parameterized notebook execution in a production pipeline.

---

## Summary

The Jupyter-based workflow provided an accessible, narrative-focused exploration of the modeling pipeline, but was not reroducible as such. To transition from exploratory analysis to a robust, maintainable pipeline:

* Extract core logic into Python modules, import into notebooks, and write unit tests.
* Enforce environment reproducibility with `requirements.txt` and virtual environments.
* Adopt multi-start optimization and cross-validation for NLLS fits.
* Use structured logging and parameter validation to support long-running or headless executions.

### **Score: 62**

---

## Overall Score: 64 + 62 = 63