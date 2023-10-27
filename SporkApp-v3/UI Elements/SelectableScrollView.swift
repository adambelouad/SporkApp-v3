//
//  SelectableScrollView.swift
//  SporkApp-v3
//
//  Created by Adam Belouad on 12/21/23.
//

import SwiftUI

struct SelectableScrollView: View {
    
    //@ObservedObject private var recipeData = RecipeData.shared
    
    var values: [String]
    @Binding var selectedValue: String
    var action: (String) -> Void

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 15) {
                ForEach(values, id: \.self) { value in
                    SelectableButton(value: value, isSelected: selectedValue == value, action: action)
                }
            }
        }
        .padding()
    }
}

struct SelectableButton: View {
    
    //@ObservedObject private var recipeData = RecipeData.shared
    
    let value: String
    let isSelected: Bool
    let action: (String) -> Void

    var body: some View {
        Button(action: {
            action(value)
        }) {
            Text(value)
                .padding(13)
                .padding(.init(top: 0, leading: 5, bottom: 0, trailing: 5))
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .foregroundColor(isSelected ? CustomColors.accentPurple : CustomColors.accentGrey)
                )
                .foregroundColor(isSelected ? .white : .gray)
                .font(isSelected ? Font.custom("Nunito-ExtraBold", size: 18) : Font.custom("Nunito-Bold", size: 18))
        }
    }
}
