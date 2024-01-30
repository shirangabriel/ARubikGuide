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
   
    box.materials = [centerPiece(x: x, y: y, z: z)]
 
    
    let node = SCNNode(geometry: box)
    node.position = SCNVector3(x:x, y: y, z: z)
    
    return node
}


private func centerPiece(x: Float, y: Float, z: Float) -> SCNMaterial {
    if(x == -1 && y == 0 && z == 0){
       return coloredMaterial(with: .orange, atIndex: 4) // Left
    }
    if(x == 0 && y == 1 && z == 0){
       return coloredMaterial(with: .yellow, atIndex: 5) // Top
    }
    
    if(x == 1 && y == 0 && z == 0) {
       return coloredMaterial(with: .red, atIndex: 2) // right
    }
    
    if(x == 0 && y == -1 && z == 0) {
       return  coloredMaterial(with: .white, atIndex: 6) // bottom
    }
    if(x == 0 && y == 0 && z == -1 ) {
       return coloredMaterial(with: .blue, atIndex: 3) // back
    }
    if( x == 0 && y == 0 && z == 1) {
       return coloredMaterial(with: .green, atIndex: 1) // front
    }
    
    return coloredMaterial(with: .white, atIndex: 0)
}


private func coloredMaterial(with color: UIColor, atIndex index: Int) -> SCNMaterial {
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
        view.backgroundColor = UIColor.lightText
        return view
    }
    
    func updateUIView(_ uiView: SCNView, context: Context) { }
    
}


#Preview {
    CubeView()
}
