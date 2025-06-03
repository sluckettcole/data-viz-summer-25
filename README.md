# Data Visualization

This repository holds course materials for the Data Visualization course offered as part of the Johns Hopkins Bloomberg School of Public Health Graduate Summer Institute of Epidemiology and Biostatistics.

## Repository Structure

```
├── lectures/          # Course lecture materials and slides
├── examples/          # Worked examples and code samples
└── README.md
```

## HTML to PDF Conversion of Quarto Markdown Presentations

Currently, the only utility is a script to convert the Quarto presentations used in some lectures in this course to PDF.

To use this script, create a Python virtual environment in the utils direct, activate it, install `playwright`:

```bash
cd utils
python3 -m venv venv
source venv/bin/activate
pip install pytest-playwright
playwright install
```

Then run the script with the path to the Quarto presentation rendered HTML as the first argument and its destination as a second:

```python

python quarto_to_pdf.py ../lectures/day_1/day_1.html ../lectures/day_1/day_1.pdf

```

Thank you to [Vince Vu](https://github.com/quarto-dev/quarto-cli/discussions/701) for this tip.
