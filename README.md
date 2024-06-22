# Linear Regression App

## Description
The Linear Regression App allows you to input your data points and make predictions based on linear regression. The app utilizes advanced mathematical computations derived from linear algebra to provide accurate and reliable predictions.

## Features
1. **Input Data Points**: Users can input their own data points directly into the app.
2. **Graphing Interface**: Visualize your data points and the resulting regression line.
3. **Background Customization**: Customize the background of your graph with either a color or an image.
4. **AI Model Creation**: Create and save your AI models for future predictions.

## Math Calculator
The core of the app's functionality lies in the `MathCalculator` class, which uses various linear algebra techniques to compute the slope and intercept of the regression line.
Certainly! Let's redo the explanation with the specified change.

### Step-by-Step Solution:

1. **Data Points:**
   - Given data points: \((0,0)\), \((1,0)\), \((1,2)\).

2. **Constructing Matrix \( A \):**
   - The matrix \( A \) and vector \( b \) come from the equation \( y = mx + b \). For the given points, this can be expressed as:
     \[
     \begin{bmatrix} 0 \\ 0 \\ 2 \end{bmatrix} = \begin{bmatrix} 0 & 1 \\ 1 & 1 \\ 1 & 1 \end{bmatrix} \begin{bmatrix} m \\ b \end{bmatrix}
     \]
   - Construct the matrix \( A \) from the x-coordinates, making sure the columns are switched:
     \[
     A = \begin{bmatrix} 0 & 1 \\ 1 & 1 \\ 1 & 1 \end{bmatrix}
     \]

3. **Constructing Vector \( b \):**
   - Construct the vector \( b \) from the y-coordinates:
     \[
     b = \begin{bmatrix} 0 \\ 0 \\ 2 \end{bmatrix}
     \]

4. **Gram-Schmidt Process to find \( Q \):**

   - **Step 1:** Compute \( u_1 \) (first column of \( Q \)):
     - Take the first column of \( A \):
       \[
       u_1 = \begin{bmatrix} 0 \\ 1 \\ 1 \end{bmatrix}
       \]
     - Normalize \( u_1 \) to get \( q_1 \):
       \[
       q_1 = \frac{u_1}{\|u_1\|} = \frac{1}{\sqrt{2}} \begin{bmatrix} 0 \\ 1 \\ 1 \end{bmatrix}
       \]
       This gives:
       \[
       q_1 = \begin{bmatrix} 0 \\ \frac{1}{\sqrt{2}} \\ \frac{1}{\sqrt{2}} \end{bmatrix}
       \]

   - **Step 2:** Compute \( u_2 \) (second column of \( Q \)):
     - Take the second column of \( A \):
       \[
       a_2 = \begin{bmatrix} 1 \\ 1 \\ 1 \end{bmatrix}
       \]
     - Compute the projection of \( a_2 \) onto \( q_1 \):
       \[
       \text{proj}_{q_1} a_2 = \left( q_1 \cdot a_2 \right) q_1 = \left( \begin{bmatrix} 0 \\ \frac{1}{\sqrt{2}} \\ \frac{1}{\sqrt{2}} \end{bmatrix} \cdot \begin{bmatrix} 1 \\ 1 \\ 1 \end{bmatrix} \right) \begin{bmatrix} 0 \\ \frac{1}{\sqrt{2}} \\ \frac{1}{\sqrt{2}} \end{bmatrix} = \left( 0 + \frac{1}{\sqrt{2}} \cdot 1 + \frac{1}{\sqrt{2}} \cdot 1 \right) \begin{bmatrix} 0 \\ \frac{1}{\sqrt{2}} \\ \frac{1}{\sqrt{2}} \end{bmatrix}
       \]
       \[
       = \left( \frac{1}{\sqrt{2}} + \frac{1}{\sqrt{2}} \right) \begin{bmatrix} 0 \\ \frac{1}{\sqrt{2}} \\ \frac{1}{\sqrt{2}} \end{bmatrix} = \sqrt{2} \cdot \begin{bmatrix} 0 \\ \frac{1}{\sqrt{2}} \\ \frac{1}{\sqrt{2}} \end{bmatrix} = \begin{bmatrix} 0 \\ 1 \\ 1 \end{bmatrix}
       \]
     - Subtract the projection from \( a_2 \) to get \( u_2 \):
       \[
       u_2 = a_2 - \text{proj}_{q_1} a_2 = \begin{bmatrix} 1 \\ 1 \\ 1 \end{bmatrix} - \begin{bmatrix} 0 \\ 1 \\ 1 \end{bmatrix} = \begin{bmatrix} 1 \\ 0 \\ 0 \end{bmatrix}
       \]
     - Normalize \( u_2 \) to get \( q_2 \):
       \[
       q_2 = \frac{u_2}{\|u_2\|} = \begin{bmatrix} 1 \\ 0 \\ 0 \end{bmatrix}
       \]

   - **Step 3:** Form the orthonormal matrix \( Q \):
     \[
     Q = \begin{bmatrix} 0 & 1 \\ \frac{1}{\sqrt{2}} & 0 \\ \frac{1}{\sqrt{2}} & 0 \end{bmatrix}
     \]

5. **Compute \( R \):**
   - \( R = Q^T A \):
     \[
     R = \begin{bmatrix} 0 & \frac{1}{\sqrt{2}} & \frac{1}{\sqrt{2}} \\ 1 & 0 & 0 \end{bmatrix} \begin{bmatrix} 0 & 1 \\ 1 & 1 \\ 1 & 1 \end{bmatrix} = \begin{bmatrix} \sqrt{2} & \sqrt{2} \\ 0 & 1 \end{bmatrix}
     \]

6. **Solve for \( x \):**
   - Use the equation \( Rx = Q^T b \):
     \[
     Q^T b = \begin{bmatrix} 0 & \frac{1}{\sqrt{2}} & \frac{1}{\sqrt{2}} \\ 1 & 0 & 0 \end{bmatrix} \begin{bmatrix} 0 \\ 0 \\ 2 \end{bmatrix} = \begin{bmatrix} \frac{2}{\sqrt{2}} \\ 0 \end{bmatrix} = \begin{bmatrix} \sqrt{2} \\ 0 \end{bmatrix}
     \]
     \[
     R x = \begin{bmatrix} \sqrt{2} & \sqrt{2} \\ 0 & 1 \end{bmatrix} x = \begin{bmatrix} \sqrt{2} \\ 0 \end{bmatrix}
     \]
     Solve the system to get:
     \[
     x = \begin{bmatrix} 1 \\ 0 \end{bmatrix}
     \]

7. **Line of Best Fit:**
   - The coefficients \( m \) and \( b \) are derived from the solution vector \( x \):
     \[
     \begin{bmatrix} m \\ b \end{bmatrix} = \begin{bmatrix} 1 \\ 0 \end{bmatrix}
     \]
     Thus, the line of best fit is:
     \[
     y = x
     \]

This confirms that the line of best fit through the points \((0,0)\), \((1,0)\), and \((1,2)\) is indeed \( y = x \). The matrix \( A \) and vector \( b \) are constructed from the linear equation \( y = mx + b \), where \( A \cdot \begin{bmatrix} m \\ b \end{bmatrix} = b \) represents the system of equations for the given points.
