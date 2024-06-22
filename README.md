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

Here's the information formatted as a README.txt file:


# Line of Best Fit using QR Factorization and Gram-Schmidt Process

## Data Points
First, we define our data points:

```swift
var points: [[Double]] = [[0, 0], [1, 0], [1, 2]]
```
These points are (0,0), (1,0), and (1,2).

## Constructing Matrix \( A \)
The `getAMatrix` function constructs the matrix \( A \):
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
  - This function creates a matrix \( A \) where each row represents a point's x-coordinate and an additional 1 to account for the intercept \( b \).
  - For points \((0,0)\), \((1,0)\), and \((1,2)\), the matrix \( A \) is:
    \[
    A = \begin{bmatrix} 0 & 1 \\ 1 & 1 \\ 1 & 1 \end{bmatrix}
    \]

## Constructing Vector \( b \)
The `getBMatrix` function constructs the vector \( b \):
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
  - This function creates a vector \( b \) where each element is a point's y-coordinate.
  - For points \((0,0)\), \((1,0)\), and \((1,2)\), the vector \( b \) is:
    \[
    b = \begin{bmatrix} 0 \\ 0 \\ 2 \end{bmatrix}
    \]

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
    \[
    \text{proj}_{\mathbf{b}} \mathbf{a} = \frac{\mathbf{a} \cdot \mathbf{b}}{\mathbf{b} \cdot \mathbf{b}} \mathbf{b}
    \]
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
  - This function takes the columns of matrix \( A \) and applies the Gram-Schmidt process to produce an orthonormal basis, stored in matrix \( Q \).
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
       - Converts the set of orthonormal vectors back into a matrix \( Q \).

## Compute Matrix \( R \)
The `getRMatrix` function computes matrix \( R \):
```swift
func getRMatrix() -> Matrix {
    let matrixA = getAMatrix()
    let matrixQ = orthonormalBasisAsMatrix(matrixA)
    return matrixMultiplication(transpose(matrixQ), matrixA)
}
```
- **Explanation:**
  - This function calculates \( R \) by multiplying the transpose of the orthonormal matrix \( Q \) with matrix \( A \):
    \[
    R = Q^T A
    \]

## Compute the Slope and Intercept
These functions solve for the slope (\( m \)) and intercept (\( b \)) of the line of best fit:
```swift
func getSlope() -> Double {
    var solutionVector:[Double] = []

    let matrixA = getAMatrix()
   

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
  - These functions perform the following steps to solve for \( m \) and \( b \):
    1. **Compute \( Q^T b \):**
       \[
       Q^T b = Q^T \times b
       \]
    2. **Compute the Inverse of \( R \):**
       \[
       R^{-1} = \text{inverse}(R)
       \]
    3. **Solve for the Solution Matrix:**
       \[
       \text{solutionMatrix} = R^{-1} \times (Q^T b)
       \]
    4. **Extract the Slope (\( m \)) and Intercept (\( b \)) from the Solution Matrix:**
       - The first value in the solution matrix is the slope.
       - The second value in the solution matrix is the intercept.

## Summary
- **Construct Matrix \( A \) and Vector \( b \):** These represent the system of equations for the points.
- **Projection and Gram-Schmidt:** The projection function helps in computing orthogonal vectors. The Gram-Schmidt process orthogonalizes these vectors to form the matrix \( Q \).
- **Compute \( R \):** By multiplying \( Q^T \) and \( A \), we get \( R \).
- **Solve for Slope and Intercept:** Finally, by solving the system \( R x = Q^T b \), we find the slope and intercept of the best fit line.
```
