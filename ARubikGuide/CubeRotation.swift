//
//  CubeRotation.swift
//  ARubikGuide
//
//  Created by Gabe on 2024-03-01.
//

import Foundation

struct CubeRotation {
    func Rotate(rubik: [[[String]]]) -> [[[String]]] {
        var front = rubik[0];
        var back = rubik[1]
        var left = rubik[2]
        var right = rubik[3]
        var up = rubik[4]
        var down = rubik[5]
        
        
        var rotatedFace: [[String]] = Array(repeating: Array(repeating: "", count: 3), count: 3)
        
        for i in 0..<front.count {
            for j in 0..<front[i].count {
                rotatedFace[i][j] =  front[front.count - 1 - j][i]
            }
        }
        
        for i in 0..<rotatedFace.count{
            right[i][0] = rotatedFace[i][2]
            left[i][2] = rotatedFace[i][0]
            up[2][i] = rotatedFace[0][i]
            down[0][i] = rotatedFace[2][i]
        }
        
        front = rotatedFace
        
        
        return [rotatedFace, back, left, right, up, down]
    }
}
