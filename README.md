# Continuous Newton Method with Adaptive Step Size

This MATLAB project implements and compares two versions of Newton's Method for finding roots of nonlinear equations:
1. Traditional Newton Method
2. Continuous Newton Method with adaptive step size

## Project Structure

- `main.m`: Main script to run experiments and generate comparisons
- `traditionalNewton.m`: Implementation of the classical Newton Method
- `continuousNewton.m`: Implementation of Newton Method with adaptive step size
- `testFunctions.m`: Collection of test functions for comparing the methods
- `plotResults.m`: Functions for visualizing the results

## Usage

1. Open MATLAB
2. Navigate to the project directory
3. Run `main.m` to execute the comparison

## Method Description

The adaptive step size modification introduces a variable step size that adjusts based on the Continuous Newton Analysis. This can potentially improve:
- Convergence stability
- Speed of convergence in certain cases
- Handling of poorly conditioned problems

The modification uses the following approach:
TODO

## Requirements

TODO