//
//  ContentView.swift
//  SporkApp-v3
//
//  Created by Adam Belouad on 10/27/23.
//

import SwiftUI

struct HomeView: View {
    
    init() {
            //Use this if NavigationBarTitle is with Large Font
            UINavigationBar.appearance().largeTitleTextAttributes = [.font: UIFont(name: "Nunito-ExtraBold", size: 34)!]

            //Use this if NavigationBarTitle is with displayMode = .inline
            UINavigationBar.appearance().titleTextAttributes = [.font : UIFont(name: "Nunito-ExtraBold", size: 18)!]
    }
    
    @ObservedObject private var recipeData = RecipeData.shared
    
    var body: some View {
        
        NavigationStack {
            
            ZStack{
                
                VStack {
                    
                    ScrollView {
                        
                        HStack {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(CustomColors.accentPurple)
                                .frame(width: 80, height: 80)
                            
                            VStack(alignment: .leading) {
                                
                                Text("Chicken Parm")
                                    .font(.system(size: 22))
                                    .fontWeight(.bold)
                                
                                Text("30 Mins")
                                    .font(.system(size: 18))
        
                            }
                            .padding(.leading, 8)
                            Spacer()
                        }
                        .padding(.leading, 20)
                        .padding(.top, 20)
                        
                    }
                    .navigationTitle("recipes")
                    .background(CustomColors.backgroundColor)
                    
                    
                    NavigationLink(destination: NewRecipeView(), label: {
                        BottomScreenButton(title: "New Recipe", textColor: .white, backgroundColor: CustomColors.accentPurple)
                        
                    })
                    .simultaneousGesture(TapGesture().onEnded {
                        recipeData.selectedTimeValue = "any"
                        recipeData.ingredients = []
                        recipeData.newIngredient = ""
                    })
                    
                }
                .background(CustomColors.backgroundColor)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
