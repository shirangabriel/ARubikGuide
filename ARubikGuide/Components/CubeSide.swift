//
//  CubeSide.swift
//  ARubikGuide
//
//  Created by Gabe on 2024-01-20.
//

import SwiftUI

struct CubeSide: View {
    
    let colors: [[Color]]
    
    init(colors: [[Color]] = []) {
        self.colors = colors
    }
    
    
    var body: some View {
            VStack {
                ForEach(colors, id: \.self) { row in
                    HStack{
                        ForEach(row, id: \.self) { color in
                            Rectangle()
                                .fill(color)
                                .frame(width: 50, height: 50)
                                .cornerRadius(5)
                        }
                    }.shadow(radius: 2)
                    
                }
            }.padding(5)
    }
}

#Preview {
    CubeSide(colors: rubiksCube[3])
}
