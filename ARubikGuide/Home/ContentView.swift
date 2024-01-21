//
//  ContentView.swift
//  ARubikGuide
//
//  Created by Gabe on 2024-01-20.
//

import SwiftUI

struct ContentView: View {
    
    
    @State private var selectedCubeFaceIndex: Int?
    @State private var navigateToColorMapping = false
    
    
    
    
    func handleOnCubeFacePressed(index: Int){
        self.selectedCubeFaceIndex = index
        
        
        if let _selectedCubeFaceIndex = self.selectedCubeFaceIndex {
           // Trigger navigation only after selecting a face
           self.navigateToColorMapping = true
       }
    }
    
    
    var body: some View {
        NavigationView{
            
            Text("Lets match the cube")
                .font(.title)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .frame(alignment: .topLeading)
                .foregroundColor(.blue)
                .multilineTextAlignment(.leading)
            
            
            let firstHalf = rubiksCube.prefix(3)
            let secondHalf = rubiksCube.dropFirst(3)
            
            
            let indicesFirstHalf = Array(0..<firstHalf.count)
            let indicesSecondHalf = Array(0..<secondHalf.count)
            
            
            
            HStack{
                VStack {
                    ForEach(Array(zip(indicesFirstHalf, firstHalf)), id:\.0) { index, cube in
                        Button(action: {
                            // Access the index here
                            print("index: \(index), cube: \(rubiksCube[index])")
                            
                           handleOnCubeFacePressed(index: index)
                            
                        }) {
                            CubeSide(colors: cube)
                                .padding(2)
                        }
                    }
                }
                
                VStack {
                    
                    ForEach(Array(zip(indicesFirstHalf, secondHalf)), id:\.0) { index, cube in
                        Button(action: {
                            // Access the index here
                            print("index: \(firstHalf.count + index), cube: \(rubiksCube[firstHalf.count + index])")
                            handleOnCubeFacePressed(index: firstHalf.count + index)
                            
                            
                        }) {
                            CubeSide(colors: cube)
                                .padding(2)
                        }
                    }
                }
                
                
                NavigationLink(destination: ColorMapping(), isActive: $navigateToColorMapping){
                    EmptyView()
                }
               
            }
        }
   
    }
}

#Preview {
    ContentView()
}
