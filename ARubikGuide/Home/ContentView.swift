//
//  ContentView.swift
//  ARubikGuide
//
//  Created by Gabe on 2024-01-20.
//

import SwiftUI

struct ContentView: View {
    @State var cubeData:[[[Color]]] = rubiksCube
    var body: some View {
        VStack {
            Spacer()
            Text("Lets match the cube")
                .font(.title)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .frame(alignment: .topLeading)
                .foregroundColor(.blue)
                .multilineTextAlignment(.leading)
            
            RubikFacesGrid(rubikData: $cubeData)
        }
    }
}

#Preview {
    ContentView()
}
