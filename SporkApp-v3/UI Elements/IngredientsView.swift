//
//  IngredientsView.swift
//  SporkApp-v3
//
//  Created by Adam Belouad on 12/21/23.
//

import SwiftUI

struct Ingredient: Identifiable {
    var id = UUID()
    var name: String
}

struct IngredientView: View {
    
    @Binding var ingredient: Ingredient
    var onDelete: () -> Void

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.gray)
                .frame(width: 370, height: 50)

            HStack {
                TextField("Enter an ingredient", text: $ingredient.name)
                    .font(Font.custom("Nunito-SemiBold", size: 20))
                    .textCase(.lowercase)
                    .foregroundColor(.white)
                    .accentColor(.white)

                Button(action: onDelete) {
                    Image(systemName: "minus.circle")
                        .foregroundColor(.white)
                        .padding(.trailing, 18)
                        .font(Font.system(size: 15, weight: .bold))
                }
            }
            .padding(.leading, 12)
        }
    }
}

