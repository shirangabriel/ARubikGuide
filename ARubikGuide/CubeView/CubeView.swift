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
        var mScene: SCNScene = createScene();
        
        VStack {
            
            Text("Let's Solve the Cube")
                .font(.title)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            
            
            GeometryReader { geometry in
                SceneKitView(scene: mScene, size: geometry.size)
                    .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            }
            
            Button(action: {
                // Rotate
                rotateFace(scene: mScene)
                
            }, label: {
                Text(":Button")
            })
            
        }
        
    }
    
    func createScene() -> SCNScene {
        let scene = SCNScene()
        for i in -1...1 {
            for j in -1...1 {
                for k in -1...1 {
                    let cube = Cube.init(color: .white, x: CFloat(i), y: CFloat(j), z: CFloat(k))
                        .getCubeSCN()
                    
                    let key = "\(Int(i))\(Int(j))\(Int(k))"
                    
                    let container = SCNNode()
                    container.name = key
                    container.addChildNode(cube)
                    scene.rootNode.addChildNode(container)
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


func rotateFace(scene: SCNScene) -> Void {
    for container in scene.rootNode.childNodes {
        if ["-111", "-1-11", "-101", "-100", "-11-1", "-1-1-1", "-110", "-10-1", "-1-10"].contains(container.name){ // first container
            let rotationAction = SCNAction.rotateBy(x: .pi * 0.5, y: 0, z: 0, duration: 4)
            container.runAction(rotationAction)
        }


        let waitAction = SCNAction.wait(duration: 6)
        let rotationAction = SCNAction.rotateBy(x: 0, y: 0, z: .pi * 0.5, duration: 4)
        let sequenceAction = SCNAction.sequence([waitAction, rotationAction]) // Create a sequence of actions


        if ["-11-1", "-110", "001", "-111", "111", "1-11", "011", "101", "0-11"].contains(container.name){ // second container
            container.runAction(sequenceAction)
        }
    }
            
}

func rotateFaceRight(face: SCNNode) -> Void {
    let rotationAction = SCNAction.rotateBy(x: 0, y: 0, z: .pi * 2, duration: 4)
    face.runAction(rotationAction)
}

struct SceneKitView: UIViewRepresentable {
    let scene: SCNScene
    let size: CGSize
    
    func makeUIView(context: Context) -> SCNView {
        let view = SCNView(frame: CGRect(origin: .zero, size: size), options: nil)
        view.scene = scene
        view.autoenablesDefaultLighting = true
        view.allowsCameraControl = true
        view.backgroundColor = UIColor.gray
        return view
    }
    
    func updateUIView(_ uiView: SCNView, context: Context) { }
    
}


#Preview {
    CubeView()
}
