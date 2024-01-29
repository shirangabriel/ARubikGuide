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
            RubikFacesGrid(rubikData: $cubeData)
    }
}

#Preview {
    ContentView()
}
