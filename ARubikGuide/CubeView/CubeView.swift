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
    @State private var scene: SCNScene
    @State private var originalRotation: SCNMatrix4 = SCNMatrix4Identity
    @State private var rData: [[[String]]] = rubikData
    
    
    init(){
        _scene = State(initialValue: createScene())
    }
    
    
    var body: some View {
        let rot = .pi * 0.5;
        
        VStack {
            GeometryReader { geometry in
                SceneKitView(scene: scene, size: geometry.size)
                    .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            }
            // "UFR", "UR", "UBR", "FR", "R", "BR", "DFR", "DR", "DBR",
            Button(action: {
                
                var faces: [String] = []
                for i in 0..<rData[1].count {
                    for j in 0..<rData[1][i].count {
                        faces.append(rData[1][i][j])
                    }
                }
                
                
                let pieces = getPiecessOfFace(data: rData[CubeRotation().getFaceIndices(faceName: "U")["face"]!])
                
                rotate(scene: scene,
                       pieces: pieces,
                       rotateX: 0,
                       rotateY: CGFloat(0),
                       rotateZ: -CGFloat(rot))
                
                // rotateFace("F", left)
                
                rData = CubeRotation().Rotate(rubik: rData, face: "F");
                print(rData)
                
                
            }, label: {
                Text("Rotate")
            })
            
            
        }
        
    }
    
}


func createScene() -> SCNScene {
    
    let scene = SCNScene()
    for i in -1...1 {
        for j in -1...1 {
            for k in -1...1 {
                let cube = Cube.init(color: .white, x: CFloat(i), y: CFloat(j), z: CFloat(k))
                let key = "\(Int(i))\(Int(j))\(Int(k))"
                
                let container = SCNNode()
                container.name = cube.getPiecesForCoordinates(key: key).name
                container.addChildNode(cube.getCubeSCN())
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

func rotate(scene: SCNScene, pieces: [String], rotateX: CGFloat, rotateY: CGFloat, rotateZ: CGFloat) -> Void {
    for container in scene.rootNode.childNodes {
        if pieces.contains(container.name ?? ""){
            let rotationAction = SCNAction.rotateBy(x: rotateX, y: rotateY, z: rotateZ, duration: 1)
            
            container.runAction(rotationAction)
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
