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
        
        VStack {
            
            Text("Let's Solve the Cube")
                .font(.title)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            
            
            GeometryReader { geometry in
                SceneKitView(scene: createScene(), size: geometry.size)
                    .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            }
            
            Button(action: {
                // Rotate
            }, label: {
                /*@START_MENU_TOKEN@*/Text("Button")/*@END_MENU_TOKEN@*/
            })

        }
        
    }
    
    func createScene() -> SCNScene {
        let scene = SCNScene()
        let containerNode = SCNNode()
        containerNode.name = "containerNode"
        
        for i in -1...1 {
            for j in -1...1 {
                for k in -1...1 {
                    let cube = Cube.init(color: .white, x: CFloat(i), y: CFloat(j), z: CFloat(k)).getCubeSCN()
                    containerNode.addChildNode(cube)
                }
            }
        }
        
//        containerNode1.eulerAngles = SCNVector3(GLKMathDegreesToRadians(40), GLKMathDegreesToRadians(0), 0)
//        containerNode2.eulerAngles = SCNVector3(GLKMathDegreesToRadians(40), GLKMathDegreesToRadians(0), 0)
//        
        // Apply the rotation to the container node
//        let rotationAction = SCNAction.rotateBy(x: 0, y: 0, z: .pi * 2, duration: 4)
//        containerNode1.runAction(rotationAction)
        
//        rotateSelectedCubes(containerNode: containerNode)
        
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 10)
        scene.rootNode.addChildNode(containerNode)
        scene.rootNode.addChildNode(cameraNode)
        return scene
        
    }
}

func rotateSelectedCubes(containerNode: SCNNode) {
    
    for node in containerNode.childNodes {
        let x = Int(node.position.x)
        let y = Int(node.position.y)
        let z = Int(node.position.z)
        let key = "\(x)\(y)\(z)"
        
        
        
        
        if ["-111", "-1-11", "111", "1-11", "011", "-101", "101", "0-11"].contains(key) {
            let rotationAction = SCNAction.rotateBy(x: 0, y: 0, z: .pi * 2, duration: 4)
            node.runAction(rotationAction)
        }
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
        view.backgroundColor = UIColor.white
        return view
    }
    
    func updateUIView(_ uiView: SCNView, context: Context) { }
    
}


#Preview {
    CubeView()
}
