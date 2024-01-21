//
//  ContentView.swift
//  ARubikGuide
//
//  Created by Gabe on 2024-01-20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {

        Text("Lets match the cube")
            .font(.title)
            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            .frame(alignment: .topLeading)
            .foregroundColor(.blue)
            .multilineTextAlignment(.leading)
        
        
        let firstHalf = rubiksCube.prefix(3)
        let secondHalf = rubiksCube.dropFirst(3)
        
        
        
        HStack{
            VStack {
                ForEach(firstHalf, id: \.self) { cube in
                    CubeSide(colors: cube)
                        .padding(2)
                }
            }
            
            VStack {
                ForEach(secondHalf, id: \.self) { cube in
                    CubeSide(colors: cube)
                        .padding(2)
                }
            }
           
        }
    }
}

#Preview {
    ContentView()
}
