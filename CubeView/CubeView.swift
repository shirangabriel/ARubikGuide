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
        let colors:[UIColor] = [.red, .white, .blue, .orange, .yellow, .green]
        let squareSize:CGFloat = 1.0
        let chamferRadius:CGFloat = 0.1
        
        for i in -1...1{
            for j in -1...1 {
                for k in -1...1 {
                    let box = SCNBox(width: squareSize, height: squareSize, length: squareSize, chamferRadius: chamferRadius)
                    let material =  SCNMaterial()
                    material.diffuse.contents = colors.randomElement()
                    material.specular.contents = UIColor.white
                    box.materials = [material]
                    
                    let node = SCNNode(geometry: box)
                    node.position = SCNVector3(x: Float(i), y: Float(j), z: Float(k))
                    scene.rootNode.addChildNode(node)
                }
            }
        }
        
        
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 10)
        scene.rootNode.addChildNode(cameraNode)
        return scene
        
    }
}



struct SceneKitView: UIViewRepresentable {
    let scene: SCNScene
    let size: CGSize
    
    func makeUIView(context: Context) -> SCNView {
        let view = SCNView(frame: CGRect(origin: .zero, size: size), options: nil)
        view.scene = scene
        view.autoenablesDefaultLighting = true
        view.allowsCameraControl = true
        view.backgroundColor = UIColor.lightGray
        return view
    }
    
    func updateUIView(_ uiView: SCNView, context: Context) { }
    
}


#Preview {
    CubeView()
}
