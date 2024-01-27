//
//  RubikFacesGrid.swift
//  ARubikGuide
//
//  Created by Gabe on 2024-01-22.
//

import SwiftUI

struct RubikFacesGrid: View {
    var body: some View {
    
        let firstHalf = rubiksCube.prefix(3)
        let secondHalf = rubiksCube.dropFirst(3)
        
        let indicesFirstHalf = Array(0..<firstHalf.count)
        let indicesSecondHalf = Array(0..<secondHalf.count)
        
        
        
        NavigationSplitView {
            HStack{
                VStack {
                    ForEach(Array(zip(indicesFirstHalf, firstHalf)), id:\.0) { index, cube in
                        NavigationLink {
                            ColorMapping(cubeIndex: index)
                        } label: {
                            CubeSide(colors: cube)
                                .padding(2)
                        }
                    }
                }
                
                VStack {
                    ForEach(Array(zip(indicesSecondHalf, secondHalf)), id:\.0) { index, cube in
                        NavigationLink {
                            ColorMapping(cubeIndex: firstHalf.count + index)
                        } label: {
                            CubeSide(colors: cube)
                                .padding(2)
                        }
                        
                    }
                }
               
            }
            
        } detail: {
            Text("Hey")
           
        }
        
    }
}

#Preview {
    RubikFacesGrid()
}
