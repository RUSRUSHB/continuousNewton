function [root, iterations, convergence_history] = continuousNewton(f, df, x0, tau, tol, max_iter, use_momentum)
% CONTINUOUSNEWTON Implementation of the Continuous Newton method with optional momentum
%   [root, iterations, convergence_history] = continuousNewton(f, df, x0, tau, tol, max_iter, use_momentum)2
%
% Inputs:
%   f - Function handle for the target function
%   df - Function handle for the derivative of f (Jacobian)
%   x0 - Initial guess
%   tau - Step tolerence factor CORE OF THE METHOD
%   tol - Tolerance for convergence
%   max_iter - Maximum number of iterations
%   use_momentum - Boolean flag to enable momentum (default: false)
%
% Outputs:
%   root - Approximated root
%   iterations - Number of iterations performed
%   convergence_history - Array of x values at each iteration

    %% Input validation
    if nargin < 7
        use_momentum = false;
    end
    if nargin < 6
        max_iter = 100;
    end
    if nargin < 5
        tol = 1e-6;
    end
    if nargin < 4
        tau = 1e-2;
    end
    
    %% Initialize variables
    x = x0;
    convergence_history = zeros(max_iter + 1, 1);
    convergence_history(1) = x;
    
    %% Momentum parameters
    beta = 0.9;          % Momentum coefficient
    v = 0;               % Velocity (momentum) term
    momentum_active = false;  % Whether momentum is currently active
    
    % Swinging detection parameters
    swing_window = 4;    % Number of points to check for swinging
    swing_history = zeros(swing_window, 1);  % Store recent steps for swing detection
    swing_threshold = 1e-4;  % Minimum magnitude to consider as significant movement
    direction_changes = 0;   % Count of direction changes within window [DON'T HAVE TO INITIAZE HERE]
    min_direction_changes = 2;  % Minimum direction changes to activate momentum
    
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
        
        %% Compute next iteration using continuous Newton formula
        fx = f(x);
        t = sqrt(2*tau/abs(fx/J));  % Time step size
        if t > 1
            t = 1;
        end
        
        % Compute the standard Newton step
        newton_step = -t * fx/J;
        
        if use_momentum
            % Update swing history
            if i >= swing_window
                % Shift history and add new step
                swing_history(1:end-1) = swing_history(2:end);
                swing_history(end) = newton_step;
                
                % Count direction changes in the window
                direction_changes = 0;
                for j = 2:swing_window
                    if abs(swing_history(j)) > swing_threshold && ...
                       abs(swing_history(j-1)) > swing_threshold && ...
                       sign(swing_history(j)) ~= sign(swing_history(j-1))
                        direction_changes = direction_changes + 1;
                    end
                end
                
                % Activate momentum if swinging detected
                if direction_changes >= min_direction_changes && ~momentum_active
                    momentum_active = true;
                    v = newton_step;  % Initialize velocity with current step
                    beta = 0.9;       % Reset momentum coefficient
                elseif direction_changes < min_direction_changes && momentum_active
                    momentum_active = false;  % Deactivate momentum if swinging stops
                    v = 0;            % Reset velocity
                end
            else
                % Fill history during initial iterations
                swing_history(i) = newton_step;
            end
            
            % Apply momentum if active
            if momentum_active
                v = beta * v + newton_step;
                x_new = x + v;
                
                % Gradually reduce momentum if it's helping
                if abs(f(x_new)) < abs(fx)
                    beta = max(0.5, beta - 0.05);  % Reduce momentum but keep some
                else
                    beta = min(0.98, beta + 0.05);  % Increase momentum if not helping
                end
            else
                x_new = x + newton_step;
            end
        else
            x_new = x + newton_step;
        end
        
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
end 