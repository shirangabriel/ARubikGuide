//
//  ColorMapping.swift
//  ARubikGuide
//
//  Created by Gabe on 2024-01-21.
//

import SwiftUI

struct ColorMapping: View {
    @State var stickers:[[Color]] = []
    @State var selectedRowIndex: Int = 0
    @State var selectedSticker: Int = 0
    var cubeIndex: Int = 0
    
    let applicableColors = [Color.red, Color.green, Color.white, Color.yellow, Color.orange, Color.blue]
    
    
    init(cubeIndex: Int) {
        self.cubeIndex = cubeIndex
        self._stickers = State(initialValue: rubiksCube[cubeIndex])
    }
    
    
    var body: some View {
        
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, content: {
            VStack {
                ForEach(Array(stickers.enumerated()), id: \.offset) { rowIndex, row in
                    HStack{
                        ForEach(Array(row.enumerated()), id: \.offset) { index, color in
                            Rectangle()
                                .fill(color)
                                .frame(width: 100, height: 100)
                                .cornerRadius(5)
                                .border(self.selectedRowIndex == rowIndex && self.selectedSticker == index ?  Color.black : Color.clear, width: 1)
                            
                                .onTapGesture {
                                    self.selectedRowIndex = rowIndex
                                    self.selectedSticker = index
                                    print("Tapped \(self.selectedSticker) ")
                                }
                        }
                    }.shadow(radius: 2)
                    
                }
            }.padding(5)
            HStack {
                ForEach(applicableColors, id: \.self) { color in
                    Button(action: {
                        stickers[self.selectedRowIndex][self.selectedSticker] = color
                    }, label: {
                        Circle()
                            .stroke(.black, lineWidth: 1)
                            .fill(color)
                            .frame(height: 30)
                            .padding(3)
                    })
                }
            }
            .padding(10)
        })
        
        
    }
}

#Preview {
    ColorMapping(cubeIndex: 0)
}
