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
    @State private var path = NavigationPath()
    
    func handleOnCubeFacePressed(index: Int){
        print("onPress")
        
        self.selectedCubeFaceIndex = index
        
        
        if let _selectedCubeFaceIndex = self.selectedCubeFaceIndex {
           // Trigger navigation only after selecting a face
           self.navigateToColorMapping = true
       }
    }
    
    
    var body: some View {
            Text("Lets match the cube")
                .font(.title)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .frame(alignment: .topLeading)
                .foregroundColor(.blue)
                .multilineTextAlignment(.leading)
            
            
        RubikFacesGrid(onCubeFacePress: handleOnCubeFacePressed)

    }
}

#Preview {
    ContentView()
}
