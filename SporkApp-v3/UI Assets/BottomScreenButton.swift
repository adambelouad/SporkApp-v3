//
//  BottomScreenButton.swift
//  SporkApp-v3
//
//  Created by Adam Belouad on 11/2/23.
//

import SwiftUI

struct BottomScreenButton: View {
    
    var title: String
    var textColor: Color
    var backgroundColor: Color
    var body: some View {
        
        Text(title)
            .frame(width: 350, height: 50)
            .foregroundColor(textColor)
            .background(backgroundColor)
            .font(Font.custom("Nunito-ExtraBold", size: 20))
            .cornerRadius(20)
    }
}

