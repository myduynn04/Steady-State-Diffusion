# README for MATLAB Code: Laplace Equation Solver using SOR Method

## Overview
This MATLAB code solves the Laplace equation on a 2D grid using the Successive Over-Relaxation (SOR) method. It prompts the user to input grid sizes, boundary temperatures, and singular temperature points, then computes and displays the temperature distribution on the grid.

## Files
- `main8.m`: Main MATLAB script file containing the implementation of the Laplace equation solver.

## How to Use
1. **Run the Script**:
   - Open MATLAB.
   - Run the `main8.m` script.

2. **Input Grid Sizes**:
   - The script will prompt you to enter the grid size in the x-direction (`Lx`) and the y-direction (`Ly`).

3. **Input Boundary Temperatures**:
   - You will be asked to enter the temperatures for the left, right, top, and bottom boundaries. The script uses these inputs to set the boundary conditions of the grid.

4. **Input Singular Temperature Points**:
   - You can specify multiple singular temperature points within the grid. For each point, enter the x-coordinate, y-coordinate, and the temperature value.

5. **View Initial Temperature Grid**:
   - The script displays the initial temperature grid after setting the boundary conditions and singular points.

6. **Solve the Laplace Equation**:
   - The SOR method is used to solve the Laplace equation. The script will display the temperature grid periodically during the iterations.

7. **View and Save Results**:
   - The final temperature distribution is displayed as a contour plot, and the results are saved as an image file (`heat_solution_plot.png`).

## Functions
- `main`: The main function that orchestrates the entire process.
- `inputBoundaryTemperatures(T, Lx, Ly)`: Prompts the user to input boundary temperatures and applies them to the grid.
- `inputSingularTemperaturePoints(T, Lx, Ly)`: Prompts the user to input singular temperature points and applies them to the grid.
- `displayInitialGrid(T, Lx, Ly)`: Displays the initial temperature grid.
- `solveSOR(T, omega, tolerance, max_iter)`: Solves the Laplace equation using the SOR method.
- `displayResult(T, iter, Lx, Ly, singular_points)`: Displays and saves the final temperature distribution.

## Parameters
- `omega`: Relaxation factor (default is 1.9).
- `tolerance`: Convergence threshold (default is 1e-6).
- `max_iter`: Maximum number of iterations (default is 10000).

## Example
Here is an example of how to run the script and input data:

```
Enter the grid size in x-direction (Lx): 50
Enter the grid size in y-direction (Ly): 60
Enter boundary temperature values:
Left boundary (bottom): 100
Left boundary (top): 150
Right boundary (bottom): 100
Right boundary (top): 150
Bottom boundary (left): 75
Bottom boundary (right): 125
Top boundary (left): 75
Top boundary (right): 125
Enter the number of singular temperature points:
Number of points: 2
Enter coordinates and temperature value for singular point 1:
x-coordinate: 25
y-coordinate: 25
Temperature value: 200
Enter coordinates and temperature value for singular point 2:
x-coordinate: 30
y-coordinate: 30
Temperature value: 300
```

## Notes
- Ensure that the coordinates for singular temperature points are within the grid limits.
- The script saves the final contour plot as `heat_solution_plot.png` in the current directory.

## License
This project is licensed under the MIT License - see the