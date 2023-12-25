//
//  NewRecipeView.swift
//  SporkApp-v3
//
//  Created by Adam Belouad on 11/10/23.
//

import SwiftUI
import UIKit

struct NewRecipeView: View {
    
    @ObservedObject private var recipeData = RecipeData.shared
    @State var showSheet: Bool = false
    
    var body: some View {
        
        ScrollView {
            
            NavigationStack {
                
                Text("max time").bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 10)
                    .padding()
                    .padding(.bottom, -25)
                    .font(Font.custom("Nunito-Bold", size: 20))
                
                SelectableScrollView(values: recipeData.timeValues, selectedValue: $recipeData.selectedTimeValue) { value in
                    recipeData.selectedTimeValue = value
                    print(recipeData.selectedTimeValue)
                }
                .padding(.leading, 10)
                .padding(.bottom, -20)
                
                Text("people").bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 10)
                    .padding()
                    .padding(.bottom, -25)
                    .font(Font.custom("Nunito-Bold", size: 20))
                
                SelectableScrollView(values: recipeData.servesValues, selectedValue: $recipeData.selectedServesValue) { value in
                    recipeData.selectedServesValue = value
                    print(recipeData.selectedServesValue)
                }
                .padding(.leading, 10)
                .padding(.bottom, -5)
                
                Text("ingredients").bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .padding(.bottom, -25)
                    .font(Font.custom("Nunito-Bold", size: 20))
                    .padding(.leading, 10)
                
                VStack{
                    ForEach(recipeData.ingredients.indices, id: \.self) { index in
                        
                        ZStack {
                            
                            RoundedRectangle(cornerRadius: 15)
                                .fill(CustomColors.accentGrey)
                                .frame(width: 370, height: 50)
                            
                            HStack {
                          
                                TextField("Enter an ingredient", text: $recipeData.ingredients[index])
                                    .font(Font.custom("Nunito-Bold", size: 20))
                                    .textCase(.lowercase)
                                    .foregroundColor(.gray)
                                    .accentColor(.gray)
                                Button(action: {
                                    recipeData.ingredients.remove(at: index)
                                }) {
                                    Image(systemName: "minus.circle")
                                        .foregroundColor(.gray)
                                        .padding(.trailing, 18)
                                        .font(Font.system(size: 15,weight: .bold))
                                }
                            }
                            .padding(.leading, 5)//
                        }
                        .padding(.bottom, 5)
                    }
                    .padding(.leading, 5) //
                    
                    ZStack {
                        
                        RoundedRectangle(cornerRadius: 15)
                            .fill(CustomColors.accentGrey)
                            .frame(width: 370, height: 50)
                            .padding(.leading, 5)
                        
                        TextField("", text: $recipeData.newIngredient, prompt: Text("enter a new ingredient")
                            .font(Font.custom("Nunito-Bold", size: 20)))
                            .foregroundColor(.black)
                            .accentColor(.black)
                            .textInputAutocapitalization(.never)
                            .onSubmit {
                                if !recipeData.newIngredient.isEmpty {
                                    recipeData.ingredients.append(recipeData.newIngredient)
                                    recipeData.newIngredient = ""
                                }
                                print(recipeData.ingredients)
                            }
                            .padding(.leading, 5)
                        
                    }
                    .padding(.top, -5)
                }
                .padding()
                
            }
            .navigationTitle("new recipe")
            
        }
        
        Button(action: { showSheet.toggle() },
               label: {
            
            Text("Generate Recipe")
                .frame(width: 350, height: 50)
                .foregroundColor(.white)
                .background(CustomColors.accentPurple)
                .font(.system(size: 20, weight: .bold, design: .default))
                .cornerRadius(20)
        })
        .sheet(isPresented: $showSheet, content: { RecipeDisplayView() })
    }
}

struct SpecialNavBar: ViewModifier {

    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.font: Font.custom("Nunito-Bold", size: 30)]
    }

    func body(content: Content) -> some View {
        content
    }

}

extension View {

    func specialNavBar() -> some View {
        self.modifier(SpecialNavBar())
    }

}

struct NewRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        NewRecipeView()
    }
}

