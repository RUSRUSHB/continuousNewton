# Continuous Newton Method

This MATLAB project implements and compares different versions of Newton's Method:
1. Vanilla Newton Method (NR)
2. Continuous Newton Method (CNR)
3. Continuous Newton Method with Momentum Method (CNR-M)

## Project Structure

- `main.mlx`: Main script to plot results. Before examine it, it's recommended to read the project report PDF underneath.
- `continuousNewton.m`: Implementation of Newton Method with adaptive step size
- `test_convergence_path.m`: Test and plot the progress of different NR methods. To revise it, check the rows surrounded by SENTENCES OF CAPITAL LETTERS.
- `testFunctions.m`, `testFunctionsChallenging.m`: Collection of test functions for comparing the methods

## Usage

0. Read the report underneath. TAKEAWAYS is the last section of the report.
1. Open MATLAB
2. Navigate to the project code directory, add `func/`, `fig/` to path
3. Run `main.mlx` to see the plots. Note that the PDF report contains all the plots.
4. To generate new plots, run `test_convergence_path.m`. You can also modify `testFunctions.m` to test on different functions.

![P1](report/Report_P1)
![P2](report/Report_P2)
![P3](report/Report_P3)
