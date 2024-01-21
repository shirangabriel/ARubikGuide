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
