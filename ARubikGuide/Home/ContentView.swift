//
//  ContentView.swift
//  ARubikGuide
//
//  Created by Gabe on 2024-01-20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
            Spacer()
            Text("Lets match the cube")
                .font(.title)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .frame(alignment: .topLeading)
                .foregroundColor(.blue)
                .multilineTextAlignment(.leading)
        

            RubikFacesGrid()
    }
}

#Preview {
    ContentView()
}
