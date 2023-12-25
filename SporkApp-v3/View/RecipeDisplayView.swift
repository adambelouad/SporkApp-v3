//
//  RecipeDisplayView.swift
//  SporkApp-v3
//
//  Created by Adam Belouad on 11/23/23.
//

import SwiftUI

struct RecipeDisplayView: View {
    
    @ObservedObject private var recipeData = RecipeData.shared
    @State private var recipeResponse: RecipeResponse?
    
    @ObservedObject var generatedImage = ImageGenerator()
    @State var text = ""
    @State var image: UIImage?

    func fetchData() async {
        do {
            recipeResponse = try await OpenAIService.shared.sendPromptToChatGPT(message: "Write a recipe for me that can be cooked in \(recipeData.selectedTimeValue) time or less using these ingredients: \(recipeData.ingredients). The recipe should serve \(recipeData.servesValues) number of people.")
        } catch {
            print("Error: \(error)")
        }
    }

    var body: some View {
        
        VStack {
            
            ScrollView {
                
                VStack(alignment: .leading) {
                    
                    if let response = recipeResponse {
                        
                        //let unbulletedList = response.ingredients
                        //let stringWithBulletPoints = unbulletedList.replacingOccurrences(of: "-", with: "•")
                        
                        VStack {
                            
                            if let image = image {
                                Image(uiImage: image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 350, height: 250)
                                    .clipShape(RoundedRectangle(cornerRadius: 20))
                                    .padding(.top, 25)
                                
                            } else {
                                
                                ZStack {
                                    
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(Color.gray)
                                        .frame(width: 350, height: 250)
                                        .padding(.top, 25)
                                    
                                    
                                    Text("Loading Image...")
                                        .frame(maxWidth: .infinity, alignment: .center)
                                        .font(Font.custom("Nunito-ExtraBold", size: 25))
                                    
                                }
                                
                            }
                            
                        }.onAppear {
                            generatedImage.setup()
                            Task {
                                let returnedImage = await generatedImage.generateImage(prompt: "Generate a high-quality image of a delicious and visually appealing \(String(describing: recipeResponse?.title)). The image should be in the sytle of a photograph.")
                                self.image = returnedImage
                            }
                        }
                        
                        Text("\(response.title)")
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.bottom, -5)
                            .padding(.top, 10)
                            .font(Font.custom("Nunito-ExtraBold", size: 34))
                        
                        Text("\(capitalizeFirstLetterOfEachWord(response.time)) • Serves \(capitalizeFirstLetterOfEachWord(response.serves))")
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.bottom, 10)
                            .font(Font.custom("Nunito-Bold", size: 20))
                        
                        Text("Ingredients")
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.bottom, 10)
                            .font(Font.custom("Nunito-Bold", size: 20))
                        
                        Text("\(replaceHyphenWithBulletPoint("\(response.ingredients)"))")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.bottom, 10)
                            .font(Font.custom("Nunito-SemiBold", size: 20))
                            .lineSpacing(10)
                            .padding(.leading, 10)
                        
                        Text("Instructions")
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.bottom, 10)
                            .font(Font.custom("Nunito-Bold", size: 20))
                        
                        Text("\(response.instructions.replacingOccurrences(of: "\n", with: "\n\n")))")
                            .font(Font.custom("Nunito-SemiBold", size: 20))
                            .lineSpacing(7)
                            .padding(.leading, 10)
                        
                        Spacer()
                        
                    } else {
                        
                        LoadingView()
                        
                        /*
                        Text("Loading...")
                            .bold()
                            .font(Font.custom("Nunito-ExtraBold", size: 30))
                         */
                    }
                    
                }
                .padding()
                .onAppear {
                    Task {
                        await fetchData()
                    }
                }
            }
            .background(CustomColors.backgroundColor)
            
            if recipeResponse != nil {
                BottomScreenButton(title: "Save Recipe",
                                   textColor: .white,
                                   backgroundColor: CustomColors.accentPurple)
            }
            
        }
        .background(CustomColors.backgroundColor) // change button eventually to be an overlay 
        
    }
}

func capitalizeFirstLetterOfEachWord(_ input: String) -> String {
        return input
            .split(separator: " ")
            .map { String($0.prefix(1).capitalized + $0.dropFirst()) }
            .joined(separator: " ")
} // eventually move to new struct where I can do all text editining

func replaceHyphenWithBulletPoint(_ input: String) -> String {
    var modifiedText = ""

    // Split the input into lines
    let lines = input.components(separatedBy: "\n")

    // Process each line
    for (index, line) in lines.enumerated() {
        // Check if the first character of the line is a hyphen
        if let firstCharacter = line.trimmingCharacters(in: .whitespacesAndNewlines).first, firstCharacter == "-" {
            // Replace the first hyphen with a bullet point
            let modifiedLine = "•" + line.dropFirst()
            modifiedText += modifiedLine
        } else {
            modifiedText += line
        }

        // Add a newline character if it's not the last line
        if index < lines.count - 1 {
            modifiedText += "\n"
        }
    }

    return modifiedText
}

func processText(_ input: String) -> String {
        let lines = input.components(separatedBy: .newlines)

        var modifiedText = ""

        for line in lines {
            if line.trimmingCharacters(in: .whitespaces).starts(with: ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "."]) {
                let components = line.components(separatedBy: " ")
                if let numberAndPeriod = components.first {
                    let font = "Nunito-Bold" // Set your desired font
                    let restOfLine = components.dropFirst().joined(separator: " ")
                    modifiedText += "<font face='\(font)'>\(numberAndPeriod)</font> \(restOfLine)\n"
                }
            } else {
                modifiedText += "\(line)\n"
            }
        }

        return modifiedText
}

struct RecipeDisplayView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDisplayView()
    }
}
