//
//  CubeView.swift
//  ARubikGuide
//
//  Created by Gabe on 2024-01-27.
//

import SwiftUI
import SceneKit

struct CubeView: View {
    @State private var angle: Double = 0
    @GestureState private var dragAmount = CGSize.zero
    
    var body: some View {
        GeometryReader { geometry in
            SceneKitView(scene: createScene(), size: geometry.size)
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        }
        
        
    }
    
    func createScene() -> SCNScene {
        let scene = SCNScene()
        let containerNode = SCNNode()
        
        for i in -1...1 {
            for j in -1...1 {
                for k in -1...1 {
                    let cube = cube(color: .white, x: CFloat(i), y: CFloat(j), z: CFloat(k))
                    containerNode.addChildNode(cube)
                }
            }
        }
        
        containerNode.eulerAngles = SCNVector3(GLKMathDegreesToRadians(40), GLKMathDegreesToRadians(0), 0)
        
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 10)
        scene.rootNode.addChildNode(containerNode)
        scene.rootNode.addChildNode(cameraNode)
        return scene
        
    }
}


func cube(color: UIColor, x: Float, y: Float, z: Float) ->SCNNode {
    let squareSize:CGFloat = 1.0
    let chamferRadius:CGFloat = 0.1
    
    
    let box = SCNBox(width: squareSize, height: squareSize, length: squareSize, chamferRadius: chamferRadius)
    
    box.materials = getPiecesForCoordinates(x: x, y: y, z: z)
    
    
    let node = SCNNode(geometry: box)
    node.position = SCNVector3(x:x, y: y, z: z)
    
    return node
}

private func getPiecesForCoordinates(x: Float, y: Float, z: Float) -> [SCNMaterial] {
    let key = "\(Int(x))\(Int(y))\(Int(z))"
    
    switch key {
        
        // Center Pieces
        case "001": return face(front: UIColor.green)
        case "100": return face(right: .red)
        case "00-1": return face(back: .blue)
        case "-100": return face(left: .orange)
        case "010": return face(top: .yellow)
        case "0-10": return face(bottom: .white)
        
        
        // Corner Pieces
        case "-111": return face(front: .green, left: .orange, top: .yellow)
        case "-11-1": return face( back: .blue, left: .orange, top: .yellow)
        case "-1-1-1": return face( back: .blue, left: .orange, bottom: .white)
        
        case "-1-11": return face(front: .green, left: .orange, bottom: .white)
        
        case "111": return face(front: .green, right: .red, top: .yellow)
        case "1-11": return face(front: .green, right: .red, bottom: .white)
        
        case "11-1": return face(right: .red, back: .blue, top: .yellow)
        case "1-1-1": return face(right: .red, back: .blue, bottom: .white)
        
        // Middle Pieces
        // Front (green)
        case "011": return face(front: UIColor.green, top: .yellow)
        case "-101": return face(front: UIColor.green, left: .orange)
        case "101": return face(front: UIColor.green, right: .red)
        case "0-11": return face(front: UIColor.green, bottom: .white)
        
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
    
    let defaultColor = UIColor.white
    
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



struct SceneKitView: UIViewRepresentable {
    let scene: SCNScene
    let size: CGSize
    
    func makeUIView(context: Context) -> SCNView {
        let view = SCNView(frame: CGRect(origin: .zero, size: size), options: nil)
        view.scene = scene
        view.autoenablesDefaultLighting = true
        view.allowsCameraControl = true
        view.backgroundColor = UIColor.white
        return view
    }
    
    func updateUIView(_ uiView: SCNView, context: Context) { }
    
}


#Preview {
    CubeView()
}
