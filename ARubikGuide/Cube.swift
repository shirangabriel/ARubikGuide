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
        
        let key = "\(Int(self.x))\(Int(self.y))\(Int(self.z))"
        
        box.materials = getPiecesForCoordinates(key: key).materials
        
        
        let node = SCNNode(geometry: box)
        node.position = SCNVector3(x:Float(self.x), y: Float(self.y), z: Float(self.z))
        
        
        
        nameFacesForReference(node: node)
        
        
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
    
    
    public func getPiecesForCoordinates(key: String) -> (name: String, materials: [SCNMaterial]) {
        var name: String
        var materials: [SCNMaterial]
        
        
        switch key {
            
            // Corner Pieces
        case "-111":
            name = "UFL"
            materials =  face(up: .yellow, front: .green, left: .red)
        case "111":
            name = "UFR"
            materials =  face(up: .yellow, front: .green, right: .orange)
        case "-11-1":
            name = "UBL"
            materials =  face(up: .yellow, back: .blue, left: .red)
        case "11-1":
            name = "UBR"
            materials =  face(up: .yellow, right: .orange, back: .blue)
        case "-1-11":
            name = "DFL"
            materials =  face(front: .green, left: .red, down: .white)
        case "1-11":
            name = "DFR"
            materials =  face(front: .green, right: .orange, down: .white)
        case "-1-1-1":
            name = "DBL"
            materials =  face(back: .blue, left: .red, down: .white)
        case "1-1-1":
            name = "DBR"
            materials =  face(right: .orange, back: .blue, down: .white)
            
            
            // Center Pieces
        case "010":
            name = "U"
            materials =  face(up: .yellow)
        case "001":
            name = "F"
            materials =  face(front: .green)
        case "100":
            name = "R"
            materials =  face(right: .orange)
        case "00-1":
            name = "B"
            materials =  face(back: .blue)
        case "-100":
            name = "L"
            materials =  face(left: .red)
        case "0-10":
            name = "D"
            materials =  face(down: .white)
            
            
            // Edge Pieces
        case "011":
            name = "UF"
            materials =  face(up: .yellow, front: .green)
        case "110":
            name = "UR"
            materials =  face(up: .yellow, right: .orange)
        case "01-1":
            name = "UB"
            materials =  face(up: .yellow, back: .blue)
        case "-110":
            name = "UL"
            materials =  face(up: .yellow, left: .red)
        case "0-11":
            name = "DF"
            materials =  face(front: .green, down: .white)
        case "-1-10":
            name = "DL"
            materials =  face(left: .red, down: .white)
        case "0-1-1":
            name = "DB"
            materials =  face(back: .blue, down: .white)
        case "1-10":
            name = "DR"
            materials =  face(right: .orange, down: .white)
        case "101":
            name = "FR"
            materials =  face(front: .green, right: .orange)
        case "-101":
            name = "FL"
            materials =  face(front: .green, left: .red)
            
        case "10-1":
            name = "BR"
            materials =  face(right: .orange, back: .blue)
        case "-10-1":
            name = "BL"
            materials =  face(back: .blue, left: .red)
            
            
        default:
            name = ""
            materials = [coloredMaterial(with: .clear)]
        }
        
        
        return (name, materials)
        
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
