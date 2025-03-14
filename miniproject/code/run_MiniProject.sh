#!/bin/bash

# Define directories
RESULTS_DIR="../results"
REPORT_FILE="report.tex"

echo "📂 Current Directory: $(pwd)"
echo "📊 Results Directory: $RESULTS_DIR"

# Ensure Jupyter is installed
if ! command -v jupyter &> /dev/null; then
    echo "❌ Jupyter is not installed. Install it with: pip install jupyter"
    exit 1
fi

# Run data preparation script
echo "📊 Running data preparation..."
jupyter nbconvert --to notebook --execute "Data_preparation_script.ipynb" --output "Data_preparation_script.ipynb"
if [ $? -ne 0 ]; then
    echo "❌ Data preparation failed!"
    exit 1
fi

# Run model fitting script
echo "📈 Running model fitting..."
jupyter nbconvert --to notebook --execute "Model_fitting_script.ipynb" --output "Model_fitting_script.ipynb"
if [ $? -ne 0 ]; then
    echo "❌ Model fitting failed!"
    exit 1
fi

# Run analysis script
echo "📊 Running analysis..."
jupyter nbconvert --to notebook --execute "Analysis_script.ipynb" --output "Analysis_script.ipynb"
if [ $? -ne 0 ]; then
    echo "❌ Analysis failed!"
    exit 1
fi

# Compile LaTeX report
echo "📝 Compiling report..."
if command -v pdflatex &> /dev/null; then
    pdflatex -interaction=nonstopmode -output-directory="../" "$REPORT_FILE"
    echo "✅ Report compiled successfully!"
else
    echo "❌ pdflatex not found. Please install LaTeX to compile the report."
fi

# Completion message
echo "🎉 MiniProject execution completed! Check results in: $RESULTS_DIR"
