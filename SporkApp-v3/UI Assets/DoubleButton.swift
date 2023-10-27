//
//  DoubleButton.swift
//  SporkApp-v3
//
//  Created by Adam Belouad on 12/18/23.
//

import SwiftUI

struct DoubleButton: View {
    
    var title: String
    var textColor: Color
    var backgroundColor: Color
    
    var body: some View {
        HStack(spacing: 10) {
            BottomButton(title: title, textColor: textColor, backgroundColor: backgroundColor)
            BottomButton(title: title, textColor: textColor, backgroundColor: backgroundColor)
        }
    }
}

struct BottomButton: View {
    
    var title: String
    var textColor: Color
    var backgroundColor: Color
    
    var body: some View {
        Text(title)
            .frame(width: 150, height: 50) // Adjust the width based on your needs
            .foregroundColor(textColor)
            .background(backgroundColor)
            .font(.system(size: 20, weight: .bold, design: .default))
            .cornerRadius(20)
    }
}
