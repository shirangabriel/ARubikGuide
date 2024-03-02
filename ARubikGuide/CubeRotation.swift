//
//  CubeRotation.swift
//  ARubikGuide
//
//  Created by Gabe on 2024-03-01.
//

import Foundation

struct CubeRotation {
    func Rotate(rubik: [[[String]]], face: String) -> [[[String]]] {
        let rubikMap = getFaceIndices(faceName: face)
        var rData = rubik
        
        let faceIndex = rubikMap["face"]
        let leftIndex = rubikMap["left"]
        let rightIndex = rubikMap["right"]
        let upIndex = rubikMap["up"]
        let downIndex = rubikMap["down"]
        
        
        let faceArray = rubik[faceIndex!]
        
        
        for i in 0..<faceArray.count {
            for j in 0..<faceArray[i].count {
                rData[faceIndex!][i][j] =  faceArray[faceArray.count - 1 - j][i]
            }
        }
        
        for i in 0..<rData[faceIndex!].count{
            rData[leftIndex!][i][2] = rData[faceIndex!][i][0]
            rData[rightIndex!][i][0] = rData[faceIndex!][i][2]
            rData[upIndex!][2][i] = rData[faceIndex!][0][i]
            rData[downIndex!][0][i] = rData[faceIndex!][2][i]
        }
        
        
        return rData
    }
    
    
    func getFaceIndices(faceName: String) -> [String: Int] {
        var rubikMap: [String: Int] = [:]
        
        switch faceName {
        case "F":
            rubikMap["face"] = 0
            rubikMap["left"] = 2
            rubikMap["right"] = 3
            rubikMap["up"] = 40
            rubikMap["down"] = 5
        case "B":
            rubikMap["face"] = 1
            rubikMap["left"] = 3
            rubikMap["right"] = 2
            rubikMap["up"] = 4
            rubikMap["down"] = 5
        case "L":
            rubikMap["face"] = 2
            rubikMap["left"] = 1
            rubikMap["right"] = 0
            rubikMap["up"] = 4
            rubikMap["down"] = 5
        case "R":
            rubikMap["face"] = 3
            rubikMap["left"] = 0
            rubikMap["right"] = 1
            rubikMap["up"] = 4
            rubikMap["down"] = 5
        case "U":
            rubikMap["face"] = 4
            rubikMap["left"] = 2
            rubikMap["right"] = 3
            rubikMap["up"] = 1
            rubikMap["down"] = 0
        case "D":
            rubikMap["face"] = 5
            rubikMap["left"] = 2
            rubikMap["right"] = 3
            rubikMap["up"] = 0
            rubikMap["down"] = 1
        default:
            break;
        }
        
        return rubikMap
    }
}
