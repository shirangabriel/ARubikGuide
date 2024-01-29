//
//  RubikFacesGrid.swift
//  ARubikGuide
//
//  Created by Gabe on 2024-01-22.
//

import SwiftUI

struct RubikFacesGrid: View {
    
    @Binding var rubikData: [[[Color]]]
    
    var body: some View {
    
        let firstHalf = rubikData.prefix(3)
        let secondHalf = rubikData.dropFirst(3)
        
        let indicesFirstHalf = Array(0..<firstHalf.count)
        let indicesSecondHalf = Array(0..<secondHalf.count)
    
        
       
        
        
        NavigationSplitView {
            
            VStack {
                
                Text("Lets match the cube")
                    .font(.largeTitle)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                    .padding(.horizontal, 16)
                
                HStack{
        
                    VStack {
                        ForEach(Array(zip(indicesFirstHalf, firstHalf)), id:\.0) { index, cube in
                            NavigationLink {
                                ColorMapping(cubeIndex: index, rubikData: $rubikData)
                            } label: {
                                CubeSide(colors: cube)
                                    .padding(2)
                            }
                        }
                    }
                    
                    VStack {
                        ForEach(Array(zip(indicesSecondHalf, secondHalf)), id:\.0) { index, cube in
                            NavigationLink {
                                ColorMapping(cubeIndex: firstHalf.count + index, rubikData: $rubikData)
                            } label: {
                                CubeSide(colors: cube)
                                    .padding(2)
                            }
                            
                        }
                    }
                   
                }
            }

      
            
            NavigationLink {
                CubeView()
            } label: {
                Text("Solve Cube")
            }
            
        } detail: {
            Text("Hey")
           
        }
        
    }
}

struct RubikFacesGrid_Previews: PreviewProvider {
    @State static var rubikData: [[[Color]]] = [[[Color.red]]]

    static var previews: some View {
        RubikFacesGrid(rubikData: $rubikData)
    }
}
