% Simple test script to compare Traditional and Continuous Newton methods

% Parameters
tol = 1e-10;
tau = 1e-1;  % TODO: Parameter for continuous Newton
max_iter = 100;

% Get all test functions
test_functions = {...
    @testFunctions.polynomial, ...
    % @testFunctions.trigonometric, ...
    % @testFunctions.exponential, ...
    % @testFunctions.illConditioned, ...
    % @testFunctions.multipleRoots
    };

% Run tests for each function
% Plot convergence of both methods for each function
for i = 1:length(test_functions)
    % Get current test function
    [f, df, name, x0] = test_functions{i}();
    
    fprintf('\n\nTesting function: %s\n', name);
    fprintf('Initial guess: x0 = %.2f\n', x0);
    
    % Run traditional Newton
    [root_trad, iter_trad, hist_trad] = traditionalNewton(f, df, x0, tol, max_iter);
    
    % Run continuous Newton with default tau
    [root_cont, iter_cont, hist_cont] = continuousNewton(f, df, x0, tau, tol, max_iter);
    
    % Print traditional Newton results
    fprintf('\nTraditional Newton Method:\n');
    fprintf('  Root found: %.10f\n', root_trad);
    fprintf('  Iterations: %d\n', iter_trad);
    fprintf('  Final error: %.2e\n', abs(f(root_trad)));
    
    % Print continuous Newton results
    fprintf('\nContinuous Newton Method:\n');
    fprintf('  Root found: %.10f\n', root_cont);
    fprintf('  Iterations: %d\n', iter_cont);
    fprintf('  Final error: %.2e\n', abs(f(root_cont)));
    
    % Create convergence plot for this function
    figure('Name', sprintf('Convergence History - %s', name));
    
    % Plot both methods' convergence
    semilogy(0:iter_trad, abs(f(hist_trad)), 'b.-', 'DisplayName', 'Traditional');
    hold on;
    semilogy(0:iter_cont, abs(f(hist_cont)), 'r.-', 'DisplayName', 'Continuous');
    
    xlabel('Iteration');
    ylabel('|f(x)|');
    title(sprintf('Convergence History - %s', name));
    grid on;
    legend('show');
end

