//
//  GridStack.swift
//  ARubikGuide
//
//  Created by Gabe on 2024-01-20.
//

import SwiftUI

struct GridStack<Content: View>: View {
    private let rows: Int
    private let columns: Int
    @ViewBuilder private let content: (Int, Int) -> Content

    public init(
        _ rows: Int,
        _ columns: Int,
        @ViewBuilder content: @escaping (Int, Int) -> Content = { _, _ in EmptyView()}
    ) {
        self.rows = max(1, rows)
        self.columns = max(1, columns)
        self.content = content
    }

    private func calculatePlaceholderDimensions(contentCount: Int) -> (rows: Int, columns: Int) {
        guard contentCount > 0 else {
            return (rows, columns)
        }

        let sqrtValue = floor(sqrt(Double(contentCount)))
        let roundedRows = ceil(sqrt(Double(contentCount)))
        let roundedColumns = roundedRows <= sqrtValue ? ceil(Double(contentCount) / roundedRows) : sqrtValue

        return (Int(roundedRows), Int(roundedColumns))
    }

    var body: some View {
        GeometryReader { geometry in
            let contentCount = geometry.size.width * geometry.size.height / 30
            let (fallbackRows, fallbackColumns) = calculatePlaceholderDimensions(contentCount: Int(contentCount))

            HStack(spacing: 0) {
                ForEach(0..<min(self.rows, fallbackRows), id: \.self) { rowIndex in
                    VStack(spacing: 0) {
                        ForEach(0..<min(self.columns, fallbackColumns), id: \.self) { columnIndex in
                            if contentCount < Double(rows * columns) {
                                Color.clear.overlay(content(rowIndex, columnIndex)).frame(maxWidth: .infinity, maxHeight: .infinity)
                            } else {
                                content(rowIndex, columnIndex)
                            }
                        }
                    }
                }
            }
        }
    }
}
