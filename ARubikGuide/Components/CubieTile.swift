//
//  CubieTile.swift
//  ARubikGuide
//
//  Created by Gabe on 2024-01-20.
//

import SwiftUI

struct CubieTile: View {
    var color: Color
    
    init(color: Color = .gray) {
        self.color = color
    }
    
    
    var body: some View {
        Rectangle()
            .fill(color)
            .frame(width: 50, height: 50)
            .cornerRadius(5)
    }
}




#Preview {
    CubieTile(color: .gray)
}
