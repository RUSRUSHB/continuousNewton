# Continuous Newton Method with Adaptive Step Size

This MATLAB project implements and compares different versions of Newton's Method:
1. Traditional Newton Method
2. Continuous Newton Method
3. Continuous Newton Method with Momentum Method

## Project Structure

- `main.mlx`: Main script to plot results. It's recommended to read the project PDF.
- `continuousNewton.m`: Implementation of Newton Method with adaptive step size
- `test_convergence_path.m`: Test and plot the progress of different NR methods. To revise it, check the rows surrounded by SENTENCES OF CAPITAL LETTERS.
- `testFunctions.m`, `testFunctionsChallenging.m`: Collection of test functions for comparing the methods

## Usage

1. Open MATLAB
2. Navigate to the project code directory, add `func/`, `fig/` to path
3. Run `main.mlx` to see the plots. Note that the report contains all the plots.
4. To generate new plots, run `test_convergence_path.m`. You can also modify `testFunctions.m` to test on different functions.
