//
//  File.swift
//  ARubikGuide
//
//  Created by Gabe on 2024-01-20.
//

import Foundation
import SwiftUI


let rubiksCube: [[[Color]]] = [
    // Front face
    [
        [Color.gray, Color.gray, Color.gray],
        [Color.gray, Color.red, Color.gray],
        [Color.gray, Color.gray, Color.gray]
    ],
    
    // Back face
    [
        [Color.gray, Color.gray, Color.gray],
        [Color.gray, Color.blue, Color.gray],
        [Color.gray, Color.gray, Color.gray]
    ],
    
    // Top face
    [
        [Color.gray, Color.gray, Color.gray],
        [Color.gray, Color.yellow, Color.gray],
        [Color.gray, Color.gray, Color.gray]
    ],
    
    // Bottom face
    [
        [Color.gray, Color.gray, Color.gray],
        [Color.gray, Color.white, Color.gray],
        [Color.gray, Color.gray, Color.gray]
    ],
    
    // Left face
    [
        [Color.gray, Color.gray, Color.gray],
        [Color.gray, Color.orange, Color.gray],
        [Color.gray, Color.gray, Color.gray]
    ],
    
    // Right face
    [
        [Color.gray, Color.gray, Color.gray],
        [Color.gray, Color.green, Color.gray],
        [Color.gray, Color.gray, Color.gray]
    ]
]


let rubikData: [[[String]]] = [
    // front
    [
        ["UFL", "UF", "UFR"],
        ["FL", "F", "FR"],
        ["DFL", "DF", "DFR"]
    ],
    // back
    [
        ["UBL", "UB", "UBR"],
        ["BL", "B", "BR"],
        ["DBL", "DB", "DBR"]
    ],
    // left
    [
        ["UFL", "UL", "UBL"],
        ["FL", "L", "BL"],
        ["DFL", "DL", "DBL"]
    ],
    // right
    [
        ["UFR", "UR", "UBR"],
        ["FR", "R", "BR"],
        ["DFR", "DR", "DBR"]
    ],
    // up
    [
        ["UBL", "UB", "UBR"],
        ["UL", "U", "UR"],
        ["UFL", "UF", "UFR"]
    ],
    // down
    [
        ["DFL", "DF", "DFR"],
        ["DL", "D", "DR"],
        ["DBL", "DB", "DBR"]
    ]
    
]
