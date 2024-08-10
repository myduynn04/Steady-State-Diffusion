function main()
    % Prompt the user to input grid sizes
    Lx = input('Enter the grid size in x-direction (Lx): ');
    Ly = input('Enter the grid size in y-direction (Ly): ');

    % Parameters
    omega = 1.5; % Relaxation factor
    tolerance = 1e-6; % Convergence threshold
    max_iter = 10000; % Maximum number of iterations

    % Initialize temperature grid with zeros
    T = zeros(Lx, Ly);

    % Input boundary temperature values from the user
    T = inputBoundaryTemperatures(T, Lx, Ly);

    % Input multiple singular temperature points from the user
    [T, singular_points] = inputSingularTemperaturePoints(T, Lx, Ly);

    % Display initial temperature grid
    displayInitialGrid(T, Lx, Ly);

    % Solve the Laplace equation using SOR method
    [T, iter] = solveSOR(T, omega, tolerance, max_iter);

    % Display and save the results
    displayResult(T, iter, Lx, Ly, singular_points);
end

function T = inputBoundaryTemperatures(T, Lx, Ly)
    disp('Enter boundary temperature values:');
    T_left_bottom = input('Left boundary (bottom): ');
    T_left_top = input('Left boundary (top): ');
    T_right_bottom = input('Right boundary (bottom): ');
    T_right_top = input('Right boundary (top): ');
    T_bottom_left = input('Bottom boundary (left): ');
    T_bottom_right = input('Bottom boundary (right): ');
    T_top_left = input('Top boundary (left): ');
    T_top_right = input('Top boundary (right): ');
    
    T(:, 1) = linspace(T_left_bottom, T_left_top, Lx)'; % Left boundary
    T(:, end) = linspace(T_right_bottom, T_right_top, Lx)'; % Right boundary
    T(1, :) = linspace(T_bottom_left, T_bottom_right, Ly); % Bottom boundary
    T(end, :) = linspace(T_top_left, T_top_right, Ly); % Top boundary

    % Display the temperature grid after applying boundary conditions
    disp('Temperature grid after applying boundary conditions:');
    disp(T);
end

function [T, singular_points] = inputSingularTemperaturePoints(T, Lx, Ly)
    singular_points = [];
    disp('Enter the number of singular temperature points:');
    num_temp_points = input('Number of points: ');
    for k = 1:num_temp_points
        disp(['Enter coordinates and temperature value for singular point ', num2str(k), ':']);
        x_temp = input('x-coordinate: ');
        y_temp = input('y-coordinate: ');
        temp = input('Temperature value: ');
        if x_temp >= 1 && x_temp <= Lx && y_temp >= 1 && y_temp <= Ly
            T(y_temp, x_temp) = temp; % Correct the order of indexing
            singular_points = [singular_points; x_temp, y_temp, temp];
        else
            disp('Error: Invalid temperature coordinates.');
        end
    end
end

function displayInitialGrid(T, Lx, Ly)
    figure;
    contourf(T, 20, 'LineColor', 'none'); % Increase contour levels for better visualization
    colormap jet; % Use jet colormap for a visually appealing color scheme
    colorbar;
    title('Initial Temperature Grid');
    xlabel('x');
    ylabel('y');
    axis equal; % Ensure equal scaling of x and y axes
end

function [T, iter] = solveSOR(T, omega, tolerance, max_iter)
    for iter = 1:max_iter
        T_old = T; % Save old temperature values to check convergence

        % Update temperature using SOR method
        for i = 2:size(T, 1)-1
            for j = 2:size(T, 2)-1
                if ~isnan(T(i, j)) % Skip holes
                    T(i, j) = (1-omega) * T(i, j) + omega/4 * (T(i+1, j) + T(i-1, j) + T(i, j+1) + T(i, j-1));
                end
            end
        end

        % Display updated temperature grid every 100 iterations for checking
        if mod(iter, 100) == 0
            disp(['Temperature grid after ', num2str(iter), ' iterations:']);
            disp(T);
        end

        % Check convergence
        if max(max(abs(T - T_old))) < tolerance
            disp(['Converged after ', num2str(iter), ' iterations.']);
            break;
        end
    end
    if iter == max_iter
        disp(['Did not converge after ', num2str(max_iter), ' iterations.']);
    end
end

function displayResult(T, iter, Lx, Ly, singular_points)
    % Display the results
    figure;
    % Temperature contour plot
    contourf(T, 20, 'LineColor', 'none'); % Increase contour levels for better visualization
    colormap jet; % Use jet colormap for a visually appealing color scheme
    colorbar;
    title(['Temperature Contour Plot: Converged after ', num2str(iter), ' iterations']);
    xlabel('x');
    ylabel('y');
    axis equal; % Ensure equal scaling of x and y axes

    % Highlight singular temperature points
    hold on;
    scatter(singular_points(:, 1), singular_points(:, 2), 30, 'k', 'filled'); % Smaller black circles
    for i = 1:size(singular_points, 1)
        text(singular_points(i, 1), singular_points(i, 2), sprintf(' %.1f', singular_points(i, 3)), ...
            'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right', 'Color', 'black');
    end
    hold off;

    % Save the plot as an image
    saveas(gcf, 'heat_solution_plot.png');
end

% Call the main function
main();
