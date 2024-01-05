//
//  MathCalculator.swift
//  Linear-Regression
//
//  Created by Adam Ress on 1/2/24.
//

import Foundation
import SwiftUI

class MathCalculator {
    
    //Initiallize Points
    
    //Init
    
    //Convert Points into matrices
    
    //Gram Schimdt Function
    
    //Matrx Multiplier Function
    
    var body: some View {
        VStack{
            Text("Hello")
        }
    }
    
    func matrixAddition(_ matrixA: Matrix, _ matrixB: Matrix) -> Matrix {
        
        if(matrixA.getRowsAmount() != matrixB.getRowsAmount() || matrixA.getColumnsAmount() != matrixB.getColumnsAmount()){
            print("Error: Can't add matrices of different sizes")
            return Matrix(value: [[-1]])
        }
        
        var values: [[Int]] = []
        let rowLength = matrixA.getRowsAmount()
        let columnLength = matrixA.getColumnsAmount()
        
        for i in 0..<rowLength {
            
            var rowValue: [Int] = []
            
            for j in 0..<columnLength {
                rowValue.append(matrixA.value[i][j] + matrixB.value[i][j])
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
        
        var values: [[Int]] = []
        let rowLength = matrixA.getRowsAmount()
        
        let matrixAValues = matrixA.value
        let matrixBValues = matrixB.value

        
        for i in 0..<rowLength {
            var rowValue: [Int] = []
            
            for j in 0..<rowLength {
                
                var elementValue = 0
                
                for k in 0..<matrixB.getRowsAmount() {
                    elementValue += matrixAValues[i][k] * matrixBValues[k][j]
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
        
        var newValues: [[Int]] = []
        
        for i in 0..<columnLength {
            
            var rowValue: [Int] = []
            
            for j in 0..<rowLength{
                rowValue.append(matrix.value[j][i])
            }
            
            newValues.append(rowValue)
        }
        
        return Matrix(value: newValues)
        
    }
    
    //func squareMatrixInverse(_ matrix: Matrix) -> Matrix {
//        if matrix.getRowsAmount() != matrix.getColumnsAmount() {
//            print("Error: Not square matrix!")
//            return Matrix(value: [[-1]])
//        }
        
        
        
    //}

    func determinant(_ matrix: Matrix) -> Int {
        
        if matrix.getRowsAmount() != matrix.getColumnsAmount() || matrix.getRowsAmount() == 1{ //Checks that the matrix is square
            print("Error: Can only find determinant of square matrix!")
            return -1
        }
        
        let rowAmount = matrix.getRowsAmount()
        let matrixValue = matrix.value
        
        var determinantPart = 0
        
        while(rowAmount > 2){
            
            for i in 0..<rowAmount {
                let sign = (i % 2 == 0) ? 1 : -1
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
    
    
    
    
}



struct Matrix {

    var value: [[Int]]
    
    init(value: [[Int]]) {
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

//
//// Example usage and testing
//let mathCalculator = MathCalculator()
//
//// Example matrices
//let matrixA = Matrix(rows: 2, columns: 2, value: [1, 2, 3, 4])
//let matrixB = Matrix(rows: 2, columns: 2, value: [5, 6, 7, 8])
//
//// Test matrix addition
//let resultMatrix = mathCalculator.matrixAddition(matrixA: matrixA, matrixB: matrixB)
//
//// Print the result
//print("Matrix A: \(matrixA.value)")
//
//print("\nMatrix B: \(matrixB.value)")
//
//print("\nResult Matrix (A + B): \(resultMatrix.value)")
