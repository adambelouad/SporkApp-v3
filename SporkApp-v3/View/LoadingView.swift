//
//  LoadingView.swift
//  SporkApp-v3
//
//  Created by Adam Belouad on 12/21/23.
//

import SwiftUI

struct LoadingView: View {
    
    var body: some View {
        
        ZStack {
            
            CustomColors.backgroundColor.ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Loading...")
                    .bold()
                    .font(Font.custom("Nunito-ExtraBold", size: 30))
                    .padding(.top, 300)
                
                Spacer()
            }
        }
    }
}
