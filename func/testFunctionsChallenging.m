classdef testFunctionsChallenging
    % TESTFUNCTIONSCHALLENGING A collection of challenging test functions
    % where continuous Newton method might outperform traditional Newton
    
    methods(Static)
        function [f, df, name, x0] = steepValley()
            % Function with very steep valley: f(x) = x^4 - 10x^2 + 9
            % Has roots at x = ±3, ±1
            % Traditional Newton often overshoots due to steep gradients
            f = @(x) x.^4 - 10*x.^2 + 9;
            df = @(x) 4*x.^3 - 20*x;
            name = '$f(x) = x^4 - 10x^2 + 9$';
            x0 = 0.1;  % Initial guess near unstable point
        end
        
        function [f, df, name, x0] = nearSingular()
            % Function with near-singular derivative: f(x) = x^(1/3)
            % Traditional Newton struggles due to infinite derivative at x=0
            f = @(x) nthroot(x, 3);
            df = @(x) 1./(3 * nthroot(x.^2, 3));
            name = '$f(x) = \sqrt[3]{x}$';
            x0 = 0.1;  % Close to singular point
        end
        
        function [f, df, name, x0] = highlyOscillatory1()
            % Basic oscillatory function with exponential decay
            % f(x) = x + sin(5x) * exp(-x^2)
            f = @(x) x + sin(5*x) .* exp(-x.^2);
            df = @(x) 1 + (5*cos(5*x) .* exp(-x.^2)) + ...
                     (sin(5*x) .* (-2*x) .* exp(-x.^2));
            name = '$f(x) = x + \sin(5x)e^{-x^2}$';
            x0 = 2;  % Start in oscillatory region
        end

        function [f, df, name, x0] = highlyOscillatory1mod()
            % Modified oscillatory function with exponential decay and amplitude modulation
            % f(x) = x + 2*sin(5x) * exp(-0.5*x^2) - 0.5
            % Adds amplitude scaling and modified decay rate compared to highlyOscillatory1
            f = @(x) x + 2*sin(5*x) .* exp(-0.5*x.^2) - 0.41;
            df = @(x) 1 + (10*cos(5*x) .* exp(-0.5*x.^2)) + ...
                     (2*sin(5*x) .* (-x) .* exp(-0.5*x.^2));
            name = '$f(x) = x + 2\sin(5x)e^{-0.5x^2} - 0.41$';
            x0 = 2;  % Start in oscillatory region
        end
        
        function [f, df, name, x0] = highlyOscillatory2()
            % Oscillatory function with increasing frequency
            % f(x) = x + sin(x^2)
            f = @(x) x + sin(x.^2);
            df = @(x) 1 + 2*x.*cos(x.^2);
            name = '$f(x) = x + \sin(x^2)$';
            x0 = 1.5;  % Start where oscillations begin to compress
        end
        
        function [f, df, name, x0] = highlyOscillatory3()
            % Damped oscillations with multiple frequencies
            % f(x) = x + 0.5*sin(10x) + 0.3*sin(20x)
            f = @(x) x + 0.5*sin(10*x) + 0.3*sin(20*x);
            df = @(x) 1 + 5*cos(10*x) + 6*cos(20*x);
            name = '$f(x) = x + 0.5\sin(10x) + 0.3\sin(20x)$';
            x0 = 0.5;  % Start in highly oscillatory region
        end
        
        function [f, df, name, x0] = highlyOscillatory4()
            % Oscillatory function with rational decay
            % f(x) = x + sin(8x)/(1 + x^2)
            f = @(x) x + sin(8*x)./(1 + x.^2);
            df = @(x) 1 + (8*cos(8*x).*(1 + x.^2) - 2*x.*sin(8*x))./((1 + x.^2).^2);
            name = '$f(x) = x + \frac{\sin(8x)}{1 + x^2}$';
            x0 = 3;  % Start where oscillations are smaller
        end
        
        function [f, df, name, x0] = highlyOscillatory5()
            % Product of oscillations
            % f(x) = x * (1 + sin(5x)) * (1 + 0.5*sin(10x))
            f = @(x) x .* (1 + sin(5*x)) .* (1 + 0.5*sin(10*x));
            df = @(x) (1 + sin(5*x)) .* (1 + 0.5*sin(10*x)) + ...
                     x .* (5*cos(5*x)) .* (1 + 0.5*sin(10*x)) + ...
                     x .* (1 + sin(5*x)) .* (5*cos(10*x));
            name = '$f(x) = x(1 + \sin(5x))(1 + 0.5\sin(10x))$';
            x0 = -0.66;  % Start in region with interacting oscillations
        end
        
        function [f, df, name, x0] = flatRegion()
            % Function with flat region: f(x) = x^3/(1 + x^4)
            % Traditional Newton struggles in flat regions
            f = @(x) x.^3./(1 + x.^4);
            df = @(x) (3*x.^2.*(1 + x.^4) - x.^3.*(4*x.^3)) ./ (1 + x.^4).^2;
            name = '$f(x) = \frac{x^3}{1 + x^4}$';
            x0 = 1.25;  % Start in flat region
        end
        
        function [f, df, name, x0] = multipleScales()
            % Function with multiple scales: f(x) = 0.01*x^3 + x - 1
            % Different terms dominate at different scales
            f = @(x) 0.01*x.^3 + x - 1;
            df = @(x) 0.03*x.^2 + 1;
            name = '$f(x) = 0.01x^3 + x - 1$';
            x0 = 10;  % Start where cubic term dominates
        end
    end
end 