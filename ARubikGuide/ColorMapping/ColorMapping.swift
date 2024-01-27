//
//  ColorMapping.swift
//  ARubikGuide
//
//  Created by Gabe on 2024-01-21.
//

import SwiftUI

struct ColorMapping: View {
    @Binding var rubikData: [[[Color]]]
    
    @State var selectedRowIndex: Int = 0
    @State var selectedSticker: Int = 0
    var cubeIndex: Int = 0
    
    let applicableColors = [Color.red, Color.green, Color.white, Color.yellow, Color.orange, Color.blue]
    
    
    init(cubeIndex: Int, rubikData: Binding<[[[Color]]]>) {
        self.cubeIndex = cubeIndex
        self._rubikData = rubikData
    }
    
    
    var body: some View {
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, content: {
            VStack {
                ForEach(Array(rubikData[cubeIndex].enumerated()), id: \.offset) { rowIndex, row in
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
                                }
                        }
                    }.shadow(radius: 2)
                }
            }.padding(5)
            HStack {
                ForEach(applicableColors, id: \.self) { color in
                    Button(action: {
                       
                        // Check if center piece
                        if(!(self.selectedRowIndex == 1 && self.selectedSticker == 1)){
                            rubikData[cubeIndex][self.selectedRowIndex][self.selectedSticker] = color
                        }
                        
                        if(self.selectedSticker < 2){
                            self.selectedSticker = self.selectedSticker + 1
                        }else if(self.selectedRowIndex < 2){
                            self.selectedRowIndex = self.selectedRowIndex + 1
                            self.selectedSticker = 0
                        }
                        
                        
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

struct ColorMapping_Previews: PreviewProvider {
    @State static var rubikData: [[[Color]]] = rubiksCube

    static var previews: some View {
        ColorMapping(cubeIndex: 0, rubikData: $rubikData)
    }
}
