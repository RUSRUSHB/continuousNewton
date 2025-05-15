function [root, iterations, convergence_history] = traditionalNewton(f, df, x0, tol, max_iter)
% TRADITIONALNEWTON Implementation of the classical Newton method
%   [root, iterations, convergence_history] = traditionalNewton(f, df, x0, tol, max_iter)
%
% Inputs:
%   f - Function handle for the target function
%   df - Function handle for the derivative of f
%   x0 - Initial guess
%   tol - Tolerance for convergence
%   max_iter - Maximum number of iterations
%
% Outputs:
%   root - Approximated root
%   iterations - Number of iterations performed
%   convergence_history - Array of x values at each iteration

    %% Input validation
    if nargin < 5
        max_iter = 100;
    end
    if nargin < 4
        tol = 1e-6;
    end
    
    %% Initialize variables
    x = x0;
    convergence_history = zeros(max_iter + 1, 1);
    convergence_history(1) = x;
    
    %% Main iteration loop
    for i = 1:max_iter
        %% Compute Jacobian
        J = df(x);
        
        %% Check if Jacobian is too close to zero
        if abs(J) < eps
            warning('Jacobian too close to zero. Method may not converge.');
            root = x;
            iterations = i-1;
            convergence_history = convergence_history(1:i);
            return;
        end
        
        %% Compute next iteration
        x_new = x - f(x)/J;
        
        %% Store in history
        convergence_history(i+1) = x_new;
        
        %% Check for convergence
        if abs(x_new - x) < tol  % Converged
            root = x_new;
            iterations = i;
            convergence_history = convergence_history(1:i+1);
            return;
        end
        
        x = x_new;
    end
    
    %% If we reach here, we didn't converge
    warning('Maximum iterations reached without convergence.');
    root = x;
    iterations = max_iter;
    % convergence_history = convergence_history;
end 