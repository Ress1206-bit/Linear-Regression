//
//  Test Math.swift
//  Linear-Regression
//
//  Created by Adam Ress on 1/2/24.
//

import SwiftUI

struct Test_Math: View {
    var body: some View {
        
        // Example usage and testing
        let mathCalculator = MathCalculator()

        // Example matrices
        let matrixA = Matrix(value: [[2, 5], [3, 3], [6, 1]])
        
        let matrixB = Matrix(value: [[4, 7, 2], [7, 5, 5]])
        
        let matrixC = Matrix(value: [[1, 2], [2, 5]])

        // Test matrix addition
        let resultMatrix = mathCalculator.determinant(matrixC)

        Button(action: {
            // Print the result
//            print(matrixA.getRowsAmount())
//
//            print(matrixB.getColumnsAmount())
//            
//            print("Matrix A: \(matrixA.value)")
//
//            print("\nMatrix B: \(matrixB.value)")

            print("\nResult Matrix (A + B): \(resultMatrix)")//.value)")
        }, label: {
            /*@START_MENU_TOKEN@*/Text("Button")/*@END_MENU_TOKEN@*/
        })
    }
}

#Preview {
    Test_Math()
}
