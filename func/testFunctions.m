classdef testFunctions
    % TESTFUNCTIONS A collection of test functions for comparing Newton methods
    
    methods(Static)
        function [f, df, name, x0] = polynomial()
            % Simple polynomial: x^3 - x - 2
            % Root: 1.5214
            f = @(x) x.^3 - x - 2;
            df = @(x) 3*x.^2 - 1;
            name = '$f(x) = x^3 - x - 2$';
            x0 = 2;  % Initial guess
        end
        
        function [f, df, name, x0] = trigonometric()
            % Trigonometric: cos(x) - x
            f = @(x) cos(x) - x;
            df = @(x) -sin(x) - 1;
            name = '$f(x) = \cos(x) - x$';
            x0 = 1;  % Initial guess
        end
        
        function [f, df, name, x0] = exponential()
            % Exponential: e^x - 3x
            f = @(x) exp(x) - 3*x;
            df = @(x) exp(x) - 3;
            name = '$f(x) = e^x - 3x$';
            x0 = 0;  % Initial guess
        end
        
        function [f, df, name, x0] = illConditioned()
            % Ill-conditioned function: (x-1)^3
            % Ill: slight move results to solvability
            f = @(x) (x-1).^3;
            df = @(x) 3*(x-1).^2;
            name = '$f(x) = (x-1)^3$';
            x0 = 2;  % Initial guess
        end
        
        function [f, df, name, x0] = multipleRoots()
            % Function with multiple roots: x^3 - 6x^2 + 11x - 6
            % Roots: 1, 2, 3
            f = @(x) x.^3 - 6*x.^2 + 11*x - 6;
            df = @(x) 3*x.^2 - 12*x + 11;
            name = '$f(x) = x^3 - 6x^2 + 11x - 6$';
            x0 = 0;  % Initial guess
        end
    end
end 