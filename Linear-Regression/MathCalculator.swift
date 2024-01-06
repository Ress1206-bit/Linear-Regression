//
//  MathCalculator.swift
//  Linear-Regression
//
//  Created by Adam Ress on 1/2/24.
//

import Foundation
import SwiftUI

class MathCalculator {
    
    var points: [[Int]] = [[0, 0], [1, 0], [1, 2]]
    
    init(points: [[Int]]){
        self.points = points
    }
    
    func checkPointsForError() -> Bool {
        if points.count < 2 {
            return true
        }
        
        for i in 0..<points.count {
            for j in 1..<points.count {
                if points[i][0] == points[j][0] {
                    return true
                }
            }
            
            return false
        }
        
        return false
    }
    
    func getSlope() -> Double {
        if checkPointsForError() {
            return Double()
        }
        
        var solutionVector:[Double] = []
        
        let matrixA = getAMatrix()
        let matrixB = getBMatrix()
        let matrixQTranspose = transpose(orthonormalBasisAsMatrix(matrixA))
        let matrixRInverse = squareMatrixInverse(getRMatrix())
        
        
        let QtransposeTimesB = matrixMultiplication(matrixQTranspose, matrixB)
        
        let solutionMatrix = matrixMultiplication(matrixRInverse, QtransposeTimesB)
        
        for element in solutionMatrix.value {
            solutionVector.append(Double(Int(element[0] * 10))/10.0)
        }
        
        return solutionVector[0]

    }
    
    func getIntercept() -> Double {
        if checkPointsForError() {
            return Double()
        }
        
        var solutionVector:[Double] = []
        
        let matrixA = getAMatrix()
        let matrixB = getBMatrix()
        let matrixQTranspose = transpose(orthonormalBasisAsMatrix(matrixA))
        let matrixRInverse = squareMatrixInverse(getRMatrix())
        
        
        let QtransposeTimesB = matrixMultiplication(matrixQTranspose, matrixB)
        
        let solutionMatrix = matrixMultiplication(matrixRInverse, QtransposeTimesB)
        
        for element in solutionMatrix.value {
            solutionVector.append(Double(Int(element[0] * 10))/10.0)
        }
        
        return solutionVector[1]

    }
    
    func getAMatrix() -> Matrix {
        
        var values:[[Double]] = []
        
        for i in 0..<points.count {
            values.append([Double(points[i][0]), 1])
        }
        
        return Matrix(value: values)
    }
    
    func getBMatrix() -> Matrix {
        var values:[[Double]] = []
        
        for i in 0..<points.count {
            values.append([Double(points[i][1])])
        }
        
        return Matrix(value: values)
    }
    
    func getRMatrix() -> Matrix {
        let matrixA = getAMatrix()
        let matrixQ = orthonormalBasisAsMatrix(matrixA)
        
        return matrixMultiplication(transpose(matrixQ), matrixA)
    }
    
    func proj(ontoVector: Vector, projectVector: Vector) -> Vector {
        if ontoVector.getSize() != projectVector.getSize() {
            print("Error: vectprs must be the same size!")
            return Vector(value: [-1])
        }
        
        var newVectorValue:[Double] = []
        
        
        var topValue:Double = 0
        var bottomValue:Double = 0
        
        for i in 0..<projectVector.getSize() {
            topValue += projectVector.value[i] * ontoVector.value[i]
        }
        for i in 0..<projectVector.getSize() {
            bottomValue += ontoVector.value[i] * ontoVector.value[i]
        }
        
        let valueToProject = topValue / bottomValue
        
        for i in 0..<projectVector.getSize() {
            newVectorValue.append(valueToProject * ontoVector.value[i])
        }
        
        return Vector(value: newVectorValue)
    }
    
    func orthonormalBasisAsMatrix(_ matrix: Matrix) -> Matrix {

        var vectors: [Vector] = []
        var newValue: [[Double]] = []
        
        for i in 0..<matrix.getColumnsAmount() {
            var vectorValue: [Double] = []
            
            for j in 0..<matrix.getRowsAmount(){
                vectorValue.append(matrix.value[j][i])
            }
            
            vectors.append(Vector(value: vectorValue))
        } // turn matrix into an array of vectors
        for i in 0..<vectors.count {
            var newVector = vectors[i]
            
            for j in 0..<i {
                for k in 0..<newVector.value.count {
                    newVector.value[k] -= proj(ontoVector: vectors[j], projectVector: vectors[i]).value[k]
                }
            }
            
            for k in 0..<newVector.value.count {
                newVector.value[k] /= newVector.getLength()
            }
            
            vectors[i] = newVector
        } // subtract each vector by projection of the vector on vector 1, vector2, ...
        for i in 0..<matrix.getRowsAmount() {
            
            var rowValue: [Double] = []
            
            for j in 0..<matrix.getColumnsAmount() {
                rowValue.append(vectors[j].value[i])
            }
            
            newValue.append(rowValue)
    
        } // convert array of vectors into matrix
        
        return Matrix(value: newValue)
    
        
    }
    
    func matrixAddition(_ matrixA: Matrix, _ matrixB: Matrix) -> Matrix {
        
        if(matrixA.getRowsAmount() != matrixB.getRowsAmount() || matrixA.getColumnsAmount() != matrixB.getColumnsAmount()){
            print("Error: Can't add matrices of different sizes")
            return Matrix(value: [[-1]])
        }
        
        var values: [[Double]] = []
        let rowLength = matrixA.getRowsAmount()
        let columnLength = matrixA.getColumnsAmount()
        
        for i in 0..<rowLength {
            
            var rowValue: [Double] = []
            
            for j in 0..<columnLength {
                rowValue.append(matrixA.value[i][j] + matrixB.value[i][j])
            }
            
            values.append(rowValue)
        }
        
        return Matrix(value: values)
        
    }
    
    func matrixSubtraction(_ matrixA: Matrix, _ matrixB: Matrix) -> Matrix {
        
        if(matrixA.getRowsAmount() != matrixB.getRowsAmount() || matrixA.getColumnsAmount() != matrixB.getColumnsAmount()){
            print("Error: Can't subtract matrices of different sizes")
            return Matrix(value: [[-1]])
        }
        
        var values: [[Double]] = []
        let rowLength = matrixA.getRowsAmount()
        let columnLength = matrixA.getColumnsAmount()
        
        for i in 0..<rowLength {
            
            var rowValue: [Double] = []
            
            for j in 0..<columnLength {
                rowValue.append(matrixA.value[i][j] - matrixB.value[i][j])
            }
            
            values.append(rowValue)
        }
        
        return Matrix(value: values)
        
    }
    
    func matrixMultiplication(_ matrixA: Matrix, _ matrixB: Matrix) -> Matrix {
        
        if(matrixA.getColumnsAmount() != matrixB.getRowsAmount()){
            print("Error: Can't multiply matrices where the number of columns of matrix A dont equal the number of rows of matrix B")
            return Matrix(value: [[-1]])
        }
        
        var values: [[Double]] = []
        
        
        let matrixAValues = matrixA.value
        let matrixBValues = matrixB.value

        
        for i in 0..<matrixA.getRowsAmount() {
            var rowValue: [Double] = []
            
            for j in 0..<matrixB.getColumnsAmount() {
                
                var elementValue:Double = 0.0
                
                for k in 0..<matrixB.getRowsAmount() {
                    elementValue += matrixAValues[i][k] * matrixBValues[k][j]
                }
                
                rowValue.append(elementValue)
            }
            
            values.append(rowValue)
        }
        
        return Matrix(value: values)
        
    }
    
    func matrixDivision(_ matrixA: Matrix, _ matrixB: Matrix) -> Matrix {
        
        if(matrixA.getColumnsAmount() != matrixB.getRowsAmount()){
            print("Error: Can't divide matrices where the number of columns of matrix A dont equal the number of rows of matrix B")
            return Matrix(value: [[-1]])
        }
        
        var values: [[Double]] = []
        let rowLength = matrixA.getRowsAmount()
        
        let matrixAValues = matrixA.value
        let matrixBValues = matrixB.value

        
        for i in 0..<rowLength {
            var rowValue: [Double] = []
            
            for j in 0..<rowLength {
                
                var elementValue:Double = 0.0
                
                for k in 0..<matrixB.getRowsAmount() {
                    elementValue += matrixAValues[i][k] / matrixBValues[k][j]
                }
                
                rowValue.append(elementValue)
            }
            
            values.append(rowValue)
        }
        
        return Matrix(value: values)
        
    }
    
    func transpose(_ matrix: Matrix) -> Matrix {
        let rowLength = matrix.getRowsAmount()
        let columnLength = matrix.getColumnsAmount()
        
        var newValues: [[Double]] = []
        
        for i in 0..<columnLength {
            
            var rowValue: [Double] = []
            
            for j in 0..<rowLength{
                rowValue.append(matrix.value[j][i])
            }
            
            newValues.append(rowValue)
        }
        
        return Matrix(value: newValues)
        
    }

    func determinant(_ matrix: Matrix) -> Double {
        
        if matrix.getRowsAmount() != matrix.getColumnsAmount() || matrix.getRowsAmount() == 1{ //Checks that the matrix is square
            print("Error: Can only find determinant of square matrix!")
            return -1
        }
        
        let rowAmount = matrix.getRowsAmount()
        let matrixValue = matrix.value
        
        var determinantPart:Double = 0.0
        
        while(rowAmount > 2){
            
            for i in 0..<rowAmount {
                let sign = (i % 2 == 0) ? 1.0 : -1.0
                let multiplier = matrixValue[0][i] * sign
                
                if multiplier != 0 {
                    var newMatrixValue = matrixValue
                    
                    for j in 0..<rowAmount {
                        newMatrixValue[j].remove(at: i)
                    }
                    
                    newMatrixValue.remove(at: 0) //Always removes the top row, so 0
                    
                    determinantPart += multiplier * determinant(Matrix(value: newMatrixValue))
                }
            }
            
            return determinantPart
        }
        
        let a = matrixValue[0][0]
        let b = matrixValue[0][1]
        let c = matrixValue[1][0]
        let d = matrixValue[1][1]
        
        return a*d - b*c //formula for determinant of 2x2 matrix
    }
    
    func squareMatrixInverse(_ matrix: Matrix) -> Matrix {
        
        if matrix.getRowsAmount() != matrix.getColumnsAmount() {
            print("Error: Not square matrix!")
            return Matrix(value: [[-1]])
        } //check that it is a square matrix
        
        if determinant(matrix) == 0 {
            print("Error: Matrix is Singular, Determinant is 0")
            return Matrix(value: [[-1]])
        } //check that matrix is not singular
        
        var newMatrix = matrix
        
        
        
        for i in 0..<newMatrix.getRowsAmount() {
            for j in 0..<newMatrix.getRowsAmount() {
                if i == j { //Is it a pivot, add one
                    newMatrix.value[i].append(1.0)
                }
                else { //not a pivot, add zero
                    newMatrix.value[i].append(0.0)
                }
            }
        } //add other half of matrix to find inverse on other side.
        for i in 0..<newMatrix.getRowsAmount() { //getRowsAmount is okay because it is a square matrix, but really going through each column
            var placeOfNonZeroEntry = 0
            
            for j in 0..<newMatrix.getRowsAmount() {
                if newMatrix.value[j][i] != 0 {
                    placeOfNonZeroEntry = j
                }
            }
            
            if newMatrix.value[i][i] == 0 {
                for k in 0..<newMatrix.getColumnsAmount() {
                    newMatrix.value[i][k] -= newMatrix.value[placeOfNonZeroEntry][k]
                }
            }
        } //makes sure all pivot positions do not equal zero.
        for i in 0..<newMatrix.getRowsAmount() { //getRowsAmount is okay because it is a square matrix, but really going through each column
            for j in 0..<newMatrix.getRowsAmount() {
                if(j != i){ //If the value is not the pivot then continue because we want that equal to 0
                    
                    let currentValue = newMatrix.value[j][i]
                    let pivotValue = newMatrix.value[i][i]
                    
                    for k in 0..<newMatrix.getColumnsAmount(){
                        newMatrix.value[j][k] -= newMatrix.value[i][k] * currentValue / pivotValue
                    }
                    
                }
            }
        } //remove all values above and below pivot.
        for i in 0..<newMatrix.getRowsAmount() {
            
            let pivotValue = newMatrix.value[i][i]
            
            for k in 0..<newMatrix.getColumnsAmount(){
                newMatrix.value[i][k] /= pivotValue
            }
        } //divide pivot by its own value to equal 1 and be in RREF form.
        for i in 0..<newMatrix.getRowsAmount() {
            for _ in 0..<newMatrix.getRowsAmount(){
                newMatrix.value[i].remove(at: 0)
            }
        } //chop off first half to be left with inverse.
        
        
        
        return newMatrix
    }
    
    
    
    
}



struct Matrix {

    var value: [[Double]]
    
    init(value: [[Double]]) {
        self.value = value
    }
    
    func getRowsAmount() -> Int {
//        if let rowsAmount = value.count {
//            return rowsAmount
//        }
//        return 0
        return value.count
    }
    
    func getColumnsAmount() -> Int {
//        if let columnsAmount = value[0].count {
//            return columnsAmount
//        }
//        return 0
        return value[0].count
    }
}


struct Vector {
    var value: [Double]
    
    init(value: [Double]) {
        self.value = value
    }
    
    func getSize() -> Int{
        return value.count
    }
    
    func getLength()-> Double{
        var unsquarerootedTotal:Double = 0
        
        for element in value {
            unsquarerootedTotal += (element * element)
        }
        
        return sqrt(unsquarerootedTotal)
    }
}
