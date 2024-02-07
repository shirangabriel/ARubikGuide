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
        
        
        
        //        nameFacesForReference(node: node)
        
        
        return node
    }
    
    
    private func nameFacesForReference(node: SCNNode) -> Void {
        let faces = ["F", "B", "L", "R", "U", "D"]
        
        
        for(index, face) in faces.enumerated(){
            let text = SCNText(string: face, extrusionDepth: 0.1)
            text.firstMaterial?.diffuse.contents = UIColor.black
            
            let textNode = SCNNode(geometry: text)
            textNode.scale = SCNVector3(0.02, 0.02, 0.02) // adjust the scale to fit the text on the cube
            
            
            switch index {
            case 0: // Front
                textNode.position = SCNVector3(0, 0, 0.5)
            case 1: // Back
                textNode.position = SCNVector3(0, 0, -0.5)
            case 2: // Left
                textNode.position = SCNVector3(-0.5, 0, 0)
            case 3: // Right
                textNode.position = SCNVector3(0.5, 0, 0)
            case 4: // Top
                textNode.position = SCNVector3(0, 0.5, 0)
            case 5: // Bottom
                textNode.position = SCNVector3(0, -0.5, 0)
            default:
                break
                
            }
            
            node.addChildNode(textNode)
            
        }
    }
    
    
    private func getPiecesForCoordinates(x: Float, y: Float, z: Float) -> [SCNMaterial] {
        let key = "\(Int(x))\(Int(y))\(Int(z))"
        
        switch key {
            // Corners: UFL, UFR, UBL, UBR, DFL, DFR, DBL, DBR
        case "-111": return face(up: .yellow, front: .green, left: .red) // UFL
        case "111": return face(up: .yellow, front: .green, right: .orange) // UFR
        case "-11-1": return face(up: .yellow, back: .blue, left: .red) // UBL
        case "11-1": return face(up: .yellow, right: .orange, back: .blue) // UBR
            
        case "-1-11": return face(front: .green, left: .red, down: .white) // DFL
        case "1-11": return face(front: .green, right: .orange, down: .white) // DFR
        case "-1-1-1": return face(back: .blue, left: .red, down: .white) // DBL
        case "1-1-1": return face(right: .orange, back: .blue, down: .white) // DBR
            
            // Centers
        case "010": return face(up: .yellow)
        case "001": return face(front: .green)
        case "100": return face(right: .orange)
        case "00-1": return face(back: .blue)
        case "-100": return face(left: .red)
        case "0-10": return face(down: .white)
            
            // Edges
        case "011": return face(up: .yellow, front: .green) // UF
        case "110": return face(up: .yellow, right: .orange) // UR
        case "01-1": return face(up: .yellow, back: .blue) // UB
        case "-110": return face(up: .yellow, left: .red) // UL
        case "0-11": return face(front: .green, down: .white) // DF
        case "-1-10": return face(left: .red, down: .white) // DL
        case "0-1-1": return face(back: .blue, down: .white) // DB
        case "1-10": return face(right: .orange, down: .white) // DR
        case "101": return face(front: .green, right: .orange) // FL
        case "-101": return face(front: .green, left: .red) // FR
            
        case "10-1": return face(right: .orange, back: .blue) // BR
        case "-10-1": return face(back: .blue, left: .red)  // BL
            
            
        default: return [coloredMaterial(with: .clear)]
        }
        
    }
    
    private func face( up: UIColor? = nil, front: UIColor? = nil, right: UIColor? = nil, back: UIColor? = nil, left: UIColor? = nil, down: UIColor? = nil) -> [SCNMaterial] {
        
        let defaultColor = UIColor.black
        
        let materials: [SCNMaterial] = [
            coloredMaterial(with: (front != nil) ? front! : defaultColor), // front
            coloredMaterial(with: (right != nil) ? right! : defaultColor), // right
            coloredMaterial(with: (back != nil) ? back! : defaultColor), // back
            coloredMaterial(with: (left != nil) ? left! : defaultColor), // left
            coloredMaterial(with: (up != nil) ? up! : defaultColor), // up
            coloredMaterial(with: (down != nil) ? down! : defaultColor), // down
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
