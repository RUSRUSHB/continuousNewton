% Test script to visualize convergence paths on function plot

% Control flags
show_traditional = 1;     % Set to false to hide Traditional Newton method
show_continuous = 1;      % Set to false to hide Continuous Newton method
show_momentum = 0;        % Set to false to hide Continuous Newton with momentum

% Parameters
tol = 1e-10;
max_iter = 1000;
tau = 1e-1;  % Time step parameter for continuous Newton

% CHANGE THE FUNCTION HERE
% Get the test function
% [f, df, name, x0] = testFunctionsChallenging.flatRegion();
[f, df, name, x0] = testFunctionsChallenging.highlyOscillatory2();
% [f, df, name, x0] = testFunctions.flatRegion();

% Create x values for plotting the function
x_plot = linspace(-2, 4, 1000);
y_plot = f(x_plot);

% Run methods
if show_continuous
    [root_cont, iter_cont, hist_cont] = continuousNewton(f, df, x0, tau, tol, max_iter, false);
end
if show_momentum
    [root_mom, iter_mom, hist_mom] = continuousNewton(f, df, x0, tau, tol, max_iter, true);
end
if show_traditional
    [root_trad, iter_trad, hist_trad] = traditionalNewton(f, df, x0, tol, max_iter);
end

% Create figure
figure('Name', 'Convergence Path Visualization', 'Position', [100, 100, 1200, 600]);

% Plot the function
plot(x_plot, y_plot, 'k-', 'DisplayName', 'f(x)', 'LineWidth', 1);
hold on;
plot(x_plot, zeros(size(x_plot)), 'k--', 'HandleVisibility', 'off');  % x-axis, hide from legend
grid on;

% Plot convergence paths and arrows for Traditional Newton if enabled
if show_traditional
    h_trad = plot(hist_trad, f(hist_trad), 'bo-', 'DisplayName', 'Traditional Newton', ...
        'MarkerSize', 8, 'LineWidth', 1.5);
    % Add arrows
    for i = 1:length(hist_trad)-1
        arrow_x = (hist_trad(i) + hist_trad(i+1))/2;
        arrow_y = (f(hist_trad(i)) + f(hist_trad(i+1)))/2;
        dx = hist_trad(i+1) - hist_trad(i);
        dy = f(hist_trad(i+1)) - f(hist_trad(i));
        mag = sqrt(dx^2 + dy^2);
        dx = dx/mag * 0.2;
        dy = dy/mag * 0.2;
        quiver(arrow_x, arrow_y, dx, dy, 0, 'b', 'MaxHeadSize', 0.5, 'HandleVisibility', 'off');
    end
end

% Plot convergence paths and arrows for Continuous Newton if enabled
if show_continuous
    h_cont = plot(hist_cont, f(hist_cont), 'ro-', 'DisplayName', 'Continuous Newton', ...
        'MarkerSize', 8, 'LineWidth', 1.5);
    % Add arrows
    for i = 1:length(hist_cont)-1
        arrow_x = (hist_cont(i) + hist_cont(i+1))/2;
        arrow_y = (f(hist_cont(i)) + f(hist_cont(i+1)))/2;
        dx = hist_cont(i+1) - hist_cont(i);
        dy = f(hist_cont(i+1)) - f(hist_cont(i));
        mag = sqrt(dx^2 + dy^2);
        dx = dx/mag * 0.2;
        dy = dy/mag * 0.2;
        quiver(arrow_x, arrow_y, dx, dy, 0, 'r', 'MaxHeadSize', 0.5, 'HandleVisibility', 'off');
    end
end

% Plot convergence paths and arrows for Continuous Newton with Momentum if enabled
if show_momentum
    h_mom = plot(hist_mom, f(hist_mom), 'mo-', 'DisplayName', 'Continuous Newton + Momentum', ...
        'MarkerSize', 8, 'LineWidth', 1.5);
    % Add arrows
    for i = 1:length(hist_mom)-1
        arrow_x = (hist_mom(i) + hist_mom(i+1))/2;
        arrow_y = (f(hist_mom(i)) + f(hist_mom(i+1)))/2;
        dx = hist_mom(i+1) - hist_mom(i);
        dy = f(hist_mom(i+1)) - f(hist_mom(i));
        mag = sqrt(dx^2 + dy^2);
        dx = dx/mag * 0.2;
        dy = dy/mag * 0.2;
        quiver(arrow_x, arrow_y, dx, dy, 0, 'm', 'MaxHeadSize', 0.5, 'HandleVisibility', 'off');
    end
end

% Mark starting point
plot(x0, f(x0), 'k*', 'DisplayName', 'Starting point', ...
    'MarkerSize', 15, 'LineWidth', 2);

% Mark roots (hide from legend since paths already show method colors)
if show_traditional
    plot(root_trad, f(root_trad), 'bs', 'HandleVisibility', 'off', ...
        'MarkerSize', 12, 'LineWidth', 2);
end
if show_continuous
    plot(root_cont, f(root_cont), 'rs', 'HandleVisibility', 'off', ...
        'MarkerSize', 12, 'LineWidth', 2);
end
if show_momentum
    plot(root_mom, f(root_mom), 'ms', 'HandleVisibility', 'off', ...
        'MarkerSize', 12, 'LineWidth', 2);
end

% Customize plot
xlabel('x', 'Interpreter', 'latex', 'FontSize', 12);
ylabel('f(x)', 'Interpreter', 'latex', 'FontSize', 12);
title(['Convergence Paths for ', name], ...
    'Interpreter', 'latex', ...
    'FontSize', 14);
legend('Location', 'best', 'Interpreter', 'latex');

% Add iteration counts to plot
text_str = '';
if show_traditional
    text_str = sprintf('Traditional Newton iterations: %d\n', iter_trad);
end
if show_continuous
    text_str = [text_str sprintf('Continuous Newton iterations: %d\n', iter_cont)];
end
if show_momentum
    text_str = [text_str sprintf('Continuous Newton + Momentum iterations: %d', iter_mom)];
end
if ~isempty(text_str)
    text(0.02, 0.98, text_str, ...
        'Units', 'normalized', ...
        'VerticalAlignment', 'top', ...
        'BackgroundColor', 'white', ...
        'Interpreter', 'latex');
end

% Adjust view to show important parts
xlim([min(x_plot), max(x_plot)]);

% Calculate y-limits based on visible methods
y_min = inf;
y_max = -inf;
if show_traditional
    y_min = min(y_min, min(f(hist_trad)));
    y_max = max(y_max, max(f(hist_trad)));
end
if show_continuous
    y_min = min(y_min, min(f(hist_cont)));
    y_max = max(y_max, max(f(hist_cont)));
end
if show_momentum
    y_min = min(y_min, min(f(hist_mom)));
    y_max = max(y_max, max(f(hist_mom)));
end
if isinf(y_min) || isinf(y_max)  % If no methods shown, use function range
    y_min = min(y_plot);
    y_max = max(y_plot);
end
ylim([y_min - 0.5, y_max + 0.5]); 