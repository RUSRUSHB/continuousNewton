% Test script for challenging functions where continuous Newton might outperform traditional Newton

% Parameters
tol = 1e-10;
max_iter = 100;
tau = 1e-3;  % Time step parameter for continuous Newton

% Get all challenging test functions
test_functions = {...
    % @testFunctionsChallenging.steepValley, ...
    % @testFunctionsChallenging.nearSingular, ...
    @testFunctionsChallenging.highlyOscillatory5, ...
    % @testFunctionsChallenging.flatRegion, ...
    % @testFunctionsChallenging.multipleScales
    };

% Results storage
n_tests = length(test_functions);
traditional_success = zeros(n_tests, 1);
continuous_success = zeros(n_tests, 1);
traditional_iterations = zeros(n_tests, 1);
continuous_iterations = zeros(n_tests, 1);

% Run tests for each function
for i = 1:length(test_functions)
    % Get current test function
    [f, df, name, x0] = test_functions{i}();
    
    fprintf('\n\nTesting function: %s\n', name);
    fprintf('Initial guess: x0 = %.2f\n', x0);
    
    % Initialize histories as empty
    hist_trad = [];
    hist_cont = [];
    iter_trad = 0;
    iter_cont = 0;
    
    % Run traditional Newton
    try
        [root_trad, iter_trad, hist_trad] = traditionalNewton(f, df, x0, tol, max_iter);
        traditional_success(i) = abs(f(root_trad)) < tol;
        traditional_iterations(i) = iter_trad;
        trad_status = 'succeeded';
    catch ME
        traditional_success(i) = 0;
        traditional_iterations(i) = max_iter;
        trad_status = sprintf('failed (%s)', ME.message);
    end
    
    % Run continuous Newton
    try
        [root_cont, iter_cont, hist_cont] = continuousNewton(f, df, x0, tau, tol, max_iter);
        continuous_success(i) = abs(f(root_cont)) < tol;
        continuous_iterations(i) = iter_cont;
        cont_status = 'succeeded';
    catch ME
        continuous_success(i) = 0;
        continuous_iterations(i) = max_iter;
        cont_status = sprintf('failed (%s)', ME.message);
    end
    
    % Print results
    fprintf('\nResults:\n');
    fprintf('Traditional Newton %s in %d iterations\n', trad_status, traditional_iterations(i));
    if traditional_success(i)
        fprintf('  Root found: %.10f\n', root_trad);
        fprintf('  Error is: %.2e\n', abs(f(root_trad)));
    end
    
    fprintf('\nContinuous Newton %s in %d iterations\n', cont_status, continuous_iterations(i));
    if continuous_success(i)
        fprintf('  Root found: %.10f\n', root_cont);
        fprintf('  Error is: %.2e\n', abs(f(root_cont)));
    end
    
    % Plot convergence history (even if methods failed)
    figure('Name', sprintf('Convergence History - %s', name));
    
    % Function values
    subplot(2,1,1);
    if ~isempty(hist_trad)
        semilogy(0:iter_trad, abs(f(hist_trad)), 'b.-', 'DisplayName', 'Traditional');
        hold on;
    end
    if ~isempty(hist_cont)
        semilogy(0:iter_cont, abs(f(hist_cont)), 'r.-', 'DisplayName', 'Continuous');
    end
    xlabel('Iteration');
    ylabel('|f(x)|');
    title('Function Value History');
    legend('show');
    grid on;
    
    % Iterates
    subplot(2,1,2);
    if ~isempty(hist_trad)
        plot(0:iter_trad, hist_trad, 'b.-', 'DisplayName', 'Traditional');
        hold on;
    end
    if ~isempty(hist_cont)
        plot(0:iter_cont, hist_cont, 'r.-', 'DisplayName', 'Continuous');
    end
    xlabel('Iteration');
    ylabel('x');
    title('Iterate History');
    legend('show');
    grid on;
end

% Print summary
fprintf('\n=== Overall Summary ===\n');
fprintf('Traditional Newton succeeded on %d/%d tests\n', sum(traditional_success), n_tests);
fprintf('Continuous Newton succeeded on %d/%d tests\n', sum(continuous_success), n_tests);
fprintf('\nAverage iterations (when successful):\n');
trad_avg = mean(traditional_iterations(traditional_success == 1));
cont_avg = mean(continuous_iterations(continuous_success == 1));
fprintf('Traditional Newton: %.2f\n', trad_avg);
fprintf('Continuous Newton: %.2f\n', cont_avg); 