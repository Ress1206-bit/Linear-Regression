# Linear Regression App

## Description
The Linear Regression App allows you to input your data points and make predictions based on linear regression. The app utilizes advanced mathematical computations derived from linear algebra to provide accurate and reliable predictions.

## Features
1. **Input Data Points**: Users can input their own data points directly into the app.
2. **Graphing Interface**: Visualize your data points and the resulting regression line.
3. **Background Customization**: Customize the background of your graph with either a color or an image.
4. **AI Model Creation**: Create and save your AI models for future predictions.


## How to Find the Line of Best Fit

### 1. Gather the Points
Start with the points you want to find the line of best fit for. Example points: $`(0,0)`$, $`(1,0)`$, $`(1,2)`$.

### 2. Convert the Slope-Intercept Equation to a System of Linear Equations
Create matrix $`A`$ and vector $`\vec{b}`$ from the points with this equation: where $`m`$ is the slope and $`b`$ is the y-intercept. Don't confuse variable $`b`$ with vector $`\vec{b}`$
```math
y = mx + b
```
#### Plug in the x and y values from the points into each equation. 

Note: written next to b in the slope-intercept equation is (1) just to show a coefficient of 1, as b(1) just equals b, but it helps with visualizing where A comes from.

**For the point $`(0,0)`$:**
- Equation: $`(0) = m(0) + b(1)`$

**For the point $`(1,0)`$:**
- Equation: $`(0) = m(1) + b(1)`$

**For the point $`(1,2)`$:**
- Equation: $`(2) = m(1) + b(1)`$

Matrix $`A`$ is made from the coefficients next to $`m`$ and $`b`$:
```math
A = \begin{bmatrix} 0 & 1 \\ 1 & 1 \\ 1 & 1 \end{bmatrix}
```

Vector $`\vec{b}`$ is made from the y-values:
```math
b = \begin{bmatrix} 0 \\ 0 \\ 2 \end{bmatrix}
```

We represent $`[m, b]`$ as vector $`\vec{x}`$. Thus, the matrix equation is:
```math
A\vec{x} = \vec{b} \quad \text{or} \quad \begin{bmatrix} 0 & 1 \\ 1 & 1 \\ 1 & 1 \end{bmatrix} \begin{bmatrix} m \\ b \end{bmatrix} = \begin{bmatrix} 0 \\ 0 \\ 2 \end{bmatrix}
```

### 3. Objective: Find the Best Fit
To find the line of best fit, we need to determine the values of vector $`x`$ that make $`A`$ most closely approximate $`b`$. To do this we first need to use QR factorization.

### 4. QR Factorization
We use QR factorization to convert matrix $`A`$ into two factors, $`Q`$ and $`R`$:
```math
A = QR
```

Understand that you can look at the set of columns of the matrix as a set of vectors, as a vector is really just a single column matrix
- #### $`Q`$ is an orthonormal matrix:
  - What makes an orthonormal matrix?
    - The set of columns (vectors) are orthogonal (point in directions perpendicular to each other). Look up pictures of orthogonal vectors if confused.
    - The set of columns (vectors) are normalized (unit length / length of 1). 
  - Example of an orthonormal matrix: This is the identity matrix and is made up of ones on the diagonal. It is also orthonormal. In other words, the columns are both unit vectors and perpendicular to each other.
```math
\begin{bmatrix} 1 & 0 \\ 0 & 1 \end{bmatrix}
```
  - Property of an orthonormal matrix: $`Q^T = Q^{-1}`$.
    - Q Transpose = Q Inverse
        - A transpose of a matrix is basically just flipping it in a certain way that makes it so all the columns become the rows and the rows become the columns.
    - Don't forget this property of orthonormal matrices we will use it later.

- **R** is an upper triangular matrix:
  - Non-zero entries are above or on the main diagonal.
  - Example of an upper triangular matrix:
```math
\begin{bmatrix} 1 & 2 \\ 0 & 3 \end{bmatrix}
```
### 5. Understanding projection of vectors

We will need to understand how vector projection works in order to continue, so let's project vector $` \mathbf{a} = [1,1] `$ onto vector $` \mathbf{b} = [2,0] `$.

To find the projection, you can visualize it or use the projection equation:
```math
\text{proj}_{\mathbf{b}} \mathbf{a} = \frac{\mathbf{a} \cdot \mathbf{b}}{\mathbf{b} \cdot \mathbf{b}} \mathbf{b}
```

- **Dot Product Calculation**:
```math
\mathbf{a} \cdot \mathbf{b} = 1 \cdot 2 + 1 \cdot 0 = 2
```
```math
\mathbf{b} \cdot \mathbf{b} = 2 \cdot 2 + 0 \cdot 0 = 4
```

- **Projection Calculation**:
```math
\text{proj}_{\mathbf{b}} \mathbf{a} = \frac{2}{4} \mathbf{b} = \frac{1}{2} [2,0] = [1,0]
```

To understand this visually, imagine the two vectors were real rods, and you shined a light directly above them. The shadow of the $`[1,1]`$ blue rod (vector $`\mathbf{a}`$) on the $`[2,0]`$ red rod (vector $`\mathbf{b}`$) would be like $`[1,0]`$ green vector.
![Diagram of Vectors](images/projection.png)

Now, the reason we use projection in the Gram-Schmidt process to get orthogonal vectors is because if you take a vector and subtract its projection onto another vector, you are left with the perpendicular part of the vector. 

For example, with the vectors $`[1,1]`$ and $`[2,0]`$:
- Subtracting $`[1,1]`$ by its projection $`[1,0]`$ leaves you with $`[0,1]`$.
- The vectors $`[0,1]`$ and $`[2,0]`$ are perpendicular.


### 6. Finding Matrix $`Q`$ using Gram-Schmidt Process
The Gram-Schmidt process converts the columns of $`A`$ into an orthogonal set of vectors $`[u_1, u_2]`$.

- Start with matrix $`A`$:
```math
A = \begin{bmatrix} 0 & 1 \\ 1 & 1 \\ 1 & 1 \end{bmatrix}
```
  Original vectors from A's columns: $`\mathbf{v}_1 = \begin{bmatrix} 0 \\ 1 \\ 1 \end{bmatrix}`$ and $`\mathbf{v}_2 = \begin{bmatrix} 1 \\ 1 \\ 1 \end{bmatrix}`$.

- **Finding $`\mathbf{u}_1`$**: The first vector just equals the first original vector
```math
\mathbf{u}_1 = \mathbf{v}_1 = \begin{bmatrix} 0 \\ 1 \\ 1 \end{bmatrix}
```

- **Finding $`\mathbf{u}_2`$**: Now we subtract the projection of $`v_2`$, so we are just left with the perpendicular part.
```math
\mathbf{u}_2 = \mathbf{v}_2 - \text{proj}_{\mathbf{u}_1} \mathbf{v}_2
```

Now that we have an orthogonal (perpendicular) set of vectors, we need to normalize them to make their length equal to 1. This will make the vectors both orthogonal and normalized, or orthonormal. Fortunately, $`u_2`$ is already a length of 1, so we just need to normalize $`u_1`$

- **Normalize** $`\mathbf{u}_1`$:
```math
\mathbf{u}_1 = \begin{bmatrix} 0 \\ \frac{1}{\sqrt{2}} \\ \frac{1}{\sqrt{2}} \end{bmatrix}
```

Put $`u_1`$ and $`u_2`$ together to make the orthonormal matrix $`Q`$
- **Matrix $`Q`$**:
```math
Q = \begin{bmatrix} 0 & 1 \\ \frac{1}{\sqrt{2}} & 0 \\ \frac{1}{\sqrt{2}} & 0 \end{bmatrix}
```

### 7. Finding the Upper Triangular Matrix $`R`$
This part is much easier once you know Q.
Since $`A = QR`$:
1. Multiply both sides by $`Q^{-1}`$:
```math
Q^{-1} A = R
```
2. Use the property of orthonormal matrices ($`Q^T = Q^{-1}`$):
```math
R = Q^T A
```

Given:
```math
Q^T = \begin{bmatrix} 0 & \frac{1}{\sqrt{2}} & \frac{1}{\sqrt{2}} \\ 1 & 0 & 0 \end{bmatrix}
```
```math
A = \begin{bmatrix} 0 & 1 \\ 1 & 1 \\ 1 & 1 \end{bmatrix}
```

Compute $`R`$:
```math
R = \begin{bmatrix} 0 & \frac{1}{\sqrt{2}} & \frac{1}{\sqrt{2}} \\ 1 & 0 & 0 \end{bmatrix} \begin{bmatrix} 0 & 1 \\ 1 & 1 \\ 1 & 1 \end{bmatrix} = \begin{bmatrix} \sqrt{2} & \sqrt{2} \\ 0 & 1 \end{bmatrix}
```

### 8. Solving for $`x = [m, b]`$
So go back to the equation from the beginning $`Ax = b`$. Lets now finally plugin the QR factorization for $`A`$ where $`A = QR`$, which gives us a new equation
```math
QRx = b
```
#### Simplify this equation:
1. Multiply both sides by $`Q^T`$:
```math
Q^T QRx = Q^T b \implies Rx = Q^T b
```
2. Multiply by $`R^{-1}`$:
```math
x = R^{-1} Q^T b
```

Given:
```math
Q^T b = \begin{bmatrix} 0 & \frac{1}{\sqrt{2}} & \frac{1}{\sqrt{2}} \\ 1 & 0 & 0 \end{bmatrix} \begin{bmatrix} 0 \\ 0 \\ 2 \end{bmatrix} = \begin{bmatrix} \sqrt{2} \\ 0 \end{bmatrix}
```

Find $`R^{-1}`$:
```math
R^{-1} = \begin{bmatrix} \frac{1}{\sqrt{2}} & 0 \\ -1 & 1 \end{bmatrix}
```

Compute $`x`$:
```math
x = \begin{bmatrix} \frac{1}{\sqrt{2}} & 0 \\ -1 & 1 \end{

bmatrix} \begin{bmatrix} \sqrt{2} \\ 0 \end{bmatrix} = \begin{bmatrix} 1 \\ 0 \end{bmatrix}
```


### 9. Final Matrix Multiplication Step
Find $`x`$:
```math
x = R^{-1} Q^T b = \begin{bmatrix} 1 \\ 0 \end{bmatrix}
```

### 10. Assign the Values of $`x`$ to Slope (m) and Intercept (b)
```math
x = [m, b] = [1, 0]
```

The line of best fit is:
```math
y = mx + b \implies y = 1x + 0 \implies y = x
```

The final answer is $`y = x`$. This is how you use QR factorization to find the line of best fit.
```

### Step-by-Step Solution:




# Line of Best Fit using QR Factorization and Gram-Schmidt Process

## Data Points
First, we define our data points:
```swift
var points: [[Double]] = [[0, 0], [1, 0], [1, 2]]
```
These points are $`(0,0)`$, $`(1,0)`$, and $`(1,2)`$.

## Constructing Matrix $`A`$
The `getAMatrix` function constructs the matrix $`A`$:
```swift
func getAMatrix() -> Matrix {
    var values:[[Double]] = []
    for i in 0..<points.count {
        values.append([Double(points[i][0]), 1])
    }
    return Matrix(value: values)
}
```
- **Explanation:**
  - This function creates a matrix $`A`$ where each row represents a point's x-coordinate and an additional 1 to account for the intercept $`b`$.
  - For points $`(0,0)`$, $`(1,0)`$, and $`(1,2)`$, the matrix $`A`$ is:
    
    ![equation](https://latex.codecogs.com/svg.image?%5Cinline%20%7B%5Ccolor%7Bwhite%7DA=%5Cbegin%7Bbmatrix%7D0&1%5C%5C1&1%5C%5C1&1%5Cend%7Bbmatrix%7D%7D)
    

## Constructing Vector $`b`$
The `getBMatrix` function constructs the vector $`b`$:
```swift
func getBMatrix() -> Matrix {
    var values:[[Double]] = []
    for i in 0..<points.count {
        values.append([Double(points[i][1])])
    }
    return Matrix(value: values)
}
```
- **Explanation:**
  - This function creates a vector $`b`$ where each element is a point's y-coordinate.
  - For points $`(0,0)`$, $`(1,0)`$, and $`(1,2)`$, the vector $`b`$ is:
    ![equation](https://latex.codecogs.com/svg.image?\inline&space;\large&space;\bg{black}{\color{white}b=\begin{bmatrix}0\\0\\2\end{bmatrix}})

## Projection Function
The `proj` function calculates the projection of one vector onto another:
```swift
func proj(ontoVector: Vector, projectVector: Vector) -> Vector {
    // Check if the vectors are the same size
    if ontoVector.getSize() != projectVector.getSize() {
        print("Error: vectors must be the same size!")
        return Vector(value: [-1])
    }

    var newVectorValue:[Double] = []
    var topValue:Double = 0
    var bottomValue:Double = 0

    // Calculate the dot product of projectVector and ontoVector
    for i in 0..<projectVector.getSize() {
        topValue += projectVector.value[i] * ontoVector.value[i]
    }

    // Calculate the dot product of ontoVector with itself
    for i in 0..<projectVector.getSize() {
        bottomValue += ontoVector.value[i] * ontoVector.value[i]
    }

    // Calculate the projection scalar
    let valueToProject: Double = topValue / bottomValue

    // Compute the projection vector
    for i in 0..<projectVector.getSize() {
        newVectorValue.append(valueToProject * ontoVector.value[i])
    }

    return Vector(value: newVectorValue)
}
```
- **Explanation:**
  - This function computes the projection of `projectVector` onto `ontoVector` using the formula:
    ![equation](https://latex.codecogs.com/svg.image?%5Ctext%7Bproj%7D_%7B%5Cmathbf%7Bb%7D%7D%5Cmathbf%7Ba%7D=%5Cfrac%7B%5Cmathbf%7Ba%7D%5Ccdot%5Cmathbf%7Bb%7D%7D%7B%5Cmathbf%7Bb%7D%5Ccdot%5Cmathbf%7Bb%7D%7D%5Cmathbf%7Bb%7D)
  - **Check if the Vectors are the Same Size:**
    ```swift
    if ontoVector.getSize() != projectVector.getSize() {
        print("Error: vectors must be the same size!")
        return Vector(value: [-1])
    }
    ```
    - This ensures that the vectors are of the same size, which is necessary for projection.
  - **Calculate the Dot Product of the Vectors:**
    ```swift
    var topValue:Double = 0
    var bottomValue:Double = 0

    for i in 0..<projectVector.getSize() {
        topValue += projectVector.value[i] * ontoVector.value[i]
    }

    for i in 0..<projectVector.getSize() {
        bottomValue += ontoVector.value[i] * ontoVector.value[i]
    }
    ```
    - The dot product of `projectVector` and `ontoVector` is stored in `topValue`.
    - The dot product of `ontoVector` with itself is stored in `bottomValue`.
  - **Calculate the Projection Scalar:**
    ```swift
    let valueToProject: Double = topValue / bottomValue
    ```
    - The scalar value used to scale the `ontoVector` to get the projection.
  - **Compute the Projection Vector:**
    ```swift
    for i in 0..<projectVector.getSize() {
        newVectorValue.append(valueToProject * ontoVector.value[i])
    }
    ```
    - This multiplies each component of `ontoVector` by the scalar to get the projection vector.

## Orthonormal Basis using Gram-Schmidt Process
The `orthonormalBasisAsMatrix` function applies the Gram-Schmidt process to create an orthonormal basis:
```swift
func orthonormalBasisAsMatrix(_ matrix: Matrix) -> Matrix {
    var vectors: [Vector] = []
    var newValue: [[Double]] = []

    // Convert matrix columns into vectors
    for i in 0..<matrix.getColumnsAmount() {
        var vectorValue: [Double] = []
        for j in 0..<matrix.getRowsAmount(){
            vectorValue.append(matrix.value[j][i])
        }
        vectors.append(Vector(value: vectorValue))
    }

    // Apply Gram-Schmidt process
    for i in 0..<vectors.count {
        var newVector = vectors[i]
        for j in 0..<i {
            for k in 0..<newVector.value.count {
                newVector.value[k] -= proj(ontoVector: vectors[j], projectVector: vectors[i]).value[k]
            }
        }

        // Normalize the vector
        let lengthOfVector = newVector.getLength()
        for k in 0..<newVector.value.count {
            newVector.value[k] /= lengthOfVector
        }
        vectors[i] = newVector
    }

    // Convert vectors back into a matrix
    for i in 0..<matrix.getRowsAmount() {
        var rowValue: [Double] = []
        for j in 0..<matrix.getColumnsAmount() {
            rowValue.append(vectors[j].value[i])
        }
        newValue.append(rowValue)
    }

    return Matrix(value: newValue)
}
```
- **Explanation:**
  - This function takes the columns of matrix $`A`$ and applies the Gram-Schmidt process to produce an orthonormal basis, stored in matrix $`Q`$.
  - Steps involved:
    1. **Convert Matrix Columns into Vectors:**
       ```swift
       for i in 0..<matrix.getColumnsAmount() {
           var vectorValue: [Double] = []
           for j in 0..<matrix.getRowsAmount(){
               vectorValue.append(matrix.value[j][i])
           }
           vectors.append(Vector(value: vectorValue))
       }
       ```
       - Converts each column of the matrix into a vector.
    2. **Apply Gram-Schmidt Process:**
       ```swift
       for i in 0..<vectors.count {
           var newVector = vectors[i]
           for j in 0..<i {
               for k in 0..<newVector.value.count {
                   newVector.value[k] -= proj(ontoVector: vectors[j], projectVector: vectors[i]).value[k]
               }
           }
           // Normalize the vector
           let lengthOfVector = newVector.getLength()
           for k in 0..<newVector.value.count {
               newVector.value[k] /= lengthOfVector
           }
           vectors[i] = newVector
       }
       ```
       - For each vector, subtract the projection of that vector onto all previously computed orthonormal vectors.
       - Normalize the resulting vector to get an orthonormal vector.
    3. **Convert Vectors Back into a Matrix:**
       ```swift
       for i in 0..<matrix.getRowsAmount() {
           var rowValue: [Double] = []
           for j in 0..<matrix.getColumnsAmount() {
               rowValue.append(vectors[j].value[i])
           }
           newValue.append(rowValue)
       }
       ```
       - Converts the set of orthonormal vectors back into a matrix $`Q`$.

## Compute Matrix $`R`$
The `getRMatrix` function computes matrix $`R`$:
```swift
func getRMatrix() -> Matrix {
    let matrixA = getAMatrix()
    let matrixQ = orthonormalBasisAsMatrix(matrixA)
    return matrixMultiplication(transpose(matrixQ), matrixA)
}
```
- **Explanation:**
  - This function calculates $`R`$ by multiplying the transpose of the orthonormal matrix $`Q`$ with matrix $`A`$:
    ![equation](https://latex.codecogs.com/svg.image?R=Q%5ET%20A%20)

## Compute the Slope and Intercept
These functions solve for the slope ($`m`$) and intercept ($`b`$) of the line of best fit:
```swift
func getSlope() -> Double {
    var solutionVector:[Double] = []

    let matrixA = get

AMatrix()
    let matrixB = getBMatrix()
    let matrixQTranspose = transpose(orthonormalBasisAsMatrix(matrixA))
    let matrixRInverse = squareMatrixInverse(getRMatrix())

    let QtransposeTimesB = matrixMultiplication(matrixQTranspose, matrixB)
    let solutionMatrix = matrixMultiplication(matrixRInverse, QtransposeTimesB)

    for element in solutionMatrix.value {
        solutionVector.append(Double(Int(element[0] * 100000))/100000.0)
    }

    return solutionVector[0]
}

func getIntercept() -> Double {
    var solutionVector:[Double] = []

    let matrixA = getAMatrix()
    let matrixB = getBMatrix()
    let matrixQTranspose = transpose(orthonormalBasisAsMatrix(matrixA))
    let matrixRInverse = squareMatrixInverse(getRMatrix())

    let QtransposeTimesB = matrixMultiplication(matrixQTranspose, matrixB)
    let solutionMatrix = matrixMultiplication(matrixRInverse, QtransposeTimesB)

    for element in solutionMatrix.value {
        solutionVector.append(Double(Int(element[0] * 10000))/10000.0)
    }

    return solutionVector[1]
}
```
- **Explanation:**
  - These functions perform the following steps to solve for $`m`$ and $`b`$:
    1. **Compute $`Q^T b`$:**
       ![equation](https://latex.codecogs.com/svg.image?Q%5ET%20b=Q%5ET%5Ctimes%20b%20)
    2. **Compute the Inverse of $`R`$:**
       Done with the inverse function created in MathCalculator class
    3. **Solve for the Solution Matrix:**
       ![equation](https://latex.codecogs.com/svg.image?%5Ctext%7Bsolution%20vector%7D=R%5E%7B-1%7D%5Ctimes(Q%5ET%20b))
    4. **Extract the Slope ($`m`$) and Intercept ($`b`$) from the Solution Matrix:**
       - The first value in the solution matrix is the slope.
       - The second value in the solution matrix is the intercept.

## Summary
- **Construct Matrix $`A`$ and Vector $`b`$:** These represent the system of equations for the points.
- **Projection and Gram-Schmidt:** The projection function helps in computing orthogonal vectors. The Gram-Schmidt process orthogonalizes these vectors to form the matrix $`Q`$.
- **Compute $`R`$:** By multiplying $`Q^T`$ and $`A`$, we get $`R`$.
- **Solve for Slope and Intercept:** Finally, by solving the system $`R x = Q^T b`$, we find the slope and intercept of the best fit line.
