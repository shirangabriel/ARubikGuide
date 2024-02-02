//
//  Cube.swift
//  ARubikGuide
//
//  Created by Gabe on 2024-02-02.
//

import Foundation
import SwiftUI
import SceneKit

struct Cube {
    private var color: UIColor
    private var x: CGFloat
    private var y: CGFloat
    private var z: CGFloat
    
    init(color: UIColor, x: CFloat, y: CFloat, z: CFloat) {
        self.color = color
        self.x = CGFloat(x)
        self.y = CGFloat(y)
        self.z = CGFloat(z)
    }
    
    
    func getCubeSCN() ->SCNNode {
        let squareSize:CGFloat = 1.0
        let chamferRadius:CGFloat = 0.1
        
        
        let box = SCNBox(width: squareSize, height: squareSize, length: squareSize, chamferRadius: chamferRadius)
        
        box.materials = getPiecesForCoordinates(x: Float(self.x), y: Float(self.y), z: Float(self.z))
        
        
        let node = SCNNode(geometry: box)
        node.position = SCNVector3(x:Float(self.x), y: Float(self.y), z: Float(self.z))
        
        
        return node
    }
    
    
    private func getPiecesForCoordinates(x: Float, y: Float, z: Float) -> [SCNMaterial] {
        let key = "\(Int(x))\(Int(y))\(Int(z))"
        
        switch key {
            
            //"-111" || "-1-11" || "111" || "1-11" || "011" || "-101" || "101" || "0-11"
            
            // Center Pieces
        case "001": return face(front: UIColor.green)
            // Corner Pieces
        case "-111": return face(front: .green, left: .orange, top: .yellow)
        case "-1-11": return face(front: .green, left: .orange, bottom: .white)
        case "111": return face(front: .green, right: .red, top: .yellow)
        case "1-11": return face(front: .green, right: .red, bottom: .white)
            
            // Edge Pieces
        case "011": return face(front: UIColor.green, top: .yellow)
        case "-101": return face(front: UIColor.green, left: .orange)
        case "101": return face(front: UIColor.green, right: .red)
        case "0-11": return face(front: UIColor.green, bottom: .white)
            
        case "100": return face(right: .red)
        case "00-1": return face(back: .blue)
        case "-100": return face(left: .orange)
        case "010": return face(top: .yellow)
        case "0-10": return face(bottom: .white)
            
            
            // Corner Pieces
        case "-11-1": return face( back: .blue, left: .orange, top: .yellow)
        case "-1-1-1": return face( back: .blue, left: .orange, bottom: .white)
            
            
        case "11-1": return face(right: .red, back: .blue, top: .yellow)
        case "1-1-1": return face(right: .red, back: .blue, bottom: .white)
            
            // Middle Pieces
            
            
            // Right (red)
        case "110": return face(right: .red, top: .yellow)
        case "1-10": return face(right: .red, bottom: .white)
        case "10-1": return face(right: .red, back: .blue)
            
            
        case "-110": return face(left: .orange, top: .yellow)
        case "-10-1": return face(back: .blue, left: .orange)
        case "-1-10": return face(left: .orange, bottom: .white)
            
        case "0-1-1": return face(back: .blue, bottom: .white)
        case "01-1": return face(back: .blue, top: .yellow)
            
        default: return [coloredMaterial(with: .white)]
        }
        
    }
    
    
    private func face(front: UIColor? = nil, right: UIColor? = nil, back: UIColor? = nil, left: UIColor? = nil, top: UIColor? = nil, bottom: UIColor? = nil) -> [SCNMaterial] {
        
        let defaultColor = UIColor.black
        
        let materials: [SCNMaterial] = [
            coloredMaterial(with: (front != nil) ? front! : defaultColor), // front
            coloredMaterial(with: (right != nil) ? right! : defaultColor), // right
            coloredMaterial(with: (back != nil) ? back! : defaultColor), // back
            coloredMaterial(with: (left != nil) ? left! : defaultColor), // left
            coloredMaterial(with: (top != nil) ? top! : defaultColor), // top
            coloredMaterial(with: (bottom != nil) ? bottom! : defaultColor), // bottom
            
        ]
        
        return materials
    }
    
    
    private func coloredMaterial(with color: UIColor) -> SCNMaterial {
        let material = SCNMaterial()
        material.diffuse.contents = color
        material.isDoubleSided = false // Make sure both sides of the face have the same color
        return material
    }
    
    
    
    
    
}
