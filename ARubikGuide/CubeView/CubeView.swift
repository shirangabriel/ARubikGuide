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
    
    
    init(){
        _scene = State(initialValue: createScene())
    }
    
    
    var body: some View {
        
        
        VStack {
            
            Text("Let's Solve the Cube")
                .font(.title)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            
            
            GeometryReader { geometry in
                SceneKitView(scene: scene, size: geometry.size)
                    .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            }
            
            Button(action: {
                // Rotate
                let rot = .pi * 0.5;
                
                //                "UFR", "UR", "UBR", "FR", "R", "BR", "DFR", "DR", "DBR"
                //                "UBL", "UB", "UFR", "UL", "U", "FR", "UFL", "UF", "DFR"
                //                "UFR", "UB", "UBL", "DR", "R", "UR", "DBR", "BR", "UBR"
                
                
                rotate(scene: scene, faces: [ "UFR", "UR", "UBR", "FR", "R", "BR", "DFR", "DR", "DBR"], rotateX: CGFloat(rot), rotateY: CGFloat(0), rotateZ: CGFloat(0))
                
            }, label: {
                Text("Rotate")
            })
            
            
            Button(action: {
                printFaces(scene: scene)
                
            }, label: {
                Text("Print")
            })
            
            Button(action: {
                
                
            }, label: {
                Text("Reset")
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
                    .getCubeSCN()
                
                let key = "\(Int(i))\(Int(j))\(Int(k))"
                
                let container = SCNNode()
                container.name = getPiecesNameForCoordinates(key: key)
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

func rotate(scene: SCNScene, faces: [String], rotateX: CGFloat, rotateY: CGFloat, rotateZ: CGFloat) -> Void {
    for container in scene.rootNode.childNodes {
        if faces.contains(container.name ?? ""){ // first container
            let rotationAction = SCNAction.rotateBy(x: rotateX, y: rotateY, z: rotateZ, duration: 1)
            container.runAction(rotationAction)
            
            
            //            let waitAction = SCNAction.wait(duration: 2)
            //            let rotationAction = SCNAction.rotateBy(x: 0, y: -rotate, z: 0, duration: 1)
            //            let sequenceAction = SCNAction.sequence([waitAction, rotationAction]) // Create a sequence of actions
            //            container.runAction(sequenceAction)
        }
    }
    
}


func printFaces(scene: SCNScene) -> Void {
    for container in scene.rootNode.childNodes {
        print("\(container.name)" )
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


public  func getPiecesNameForCoordinates(key: String) -> String {
    
    switch key {
    case "-111": return  "UFL"
    case "111": return  "UFR"
    case "-11-1": return  "UBL"
    case "11-1": return  "UBR"
        
    case "-1-11": return  "DFL"
    case "1-11": return  "DFR"
    case "-1-1-1": return  "DBL"
    case "1-1-1": return  "DBR"
        
        // Centers
    case "010": return "U"
    case "001": return "F"
    case "100": return "R"
    case "00-1": return "B"
    case "-100": return "L"
    case "0-10": return "D"
        
        // Edges
    case "011": return  "UF"
    case "110": return  "UR"
    case "01-1": return  "UB"
    case "-110": return  "UL"
    case "0-11": return  "DF"
    case "-1-10": return  "DL"
    case "0-1-1": return  "DB"
    case "1-10": return  "DR"
    case "101": return  "FR"
    case "-101": return  "FL"
    case "10-1": return  "BR"
    case "-10-1": return  "BL"
        
    default: return ""
    }
}



#Preview {
    CubeView()
}
