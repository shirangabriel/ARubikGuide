//
//  RubikFacesGrid.swift
//  ARubikGuide
//
//  Created by Gabe on 2024-01-22.
//

import SwiftUI

struct RubikFacesGrid: View {
    
    let onCubeFacePress: (Int) -> () // Declare the callback parameter
    
    init(onCubeFacePress: @escaping (Int) -> Void) {
           self.onCubeFacePress = onCubeFacePress
    }
    
    
    var body: some View {
        
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
                        
                        onCubeFacePress(index)

                        
                    }) {
                        CubeSide(colors: cube)
                            .padding(2)
                    }
                }
            }
            
            VStack {
                
                ForEach(Array(zip(indicesSecondHalf, secondHalf)), id:\.0) { index, cube in
                    Button(action: {
                        // Access the index here
                        print("index: \(firstHalf.count + index), cube: \(rubiksCube[firstHalf.count + index])")
                        onCubeFacePress(firstHalf.count + index)
                    }) {
                        CubeSide(colors: cube)
                            .padding(2)
                    }
                }
            }
           
        }
    }
}

#Preview {
    RubikFacesGrid(onCubeFacePress: { _ in })
}
