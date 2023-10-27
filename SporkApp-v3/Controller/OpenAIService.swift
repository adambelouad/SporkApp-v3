//
//  NewRecipeModel.swift
//  SporkApp-v3
//
//  Created by Adam Belouad on 11/10/23.
//

import SwiftUI

enum HTTPMethod: String {
    case post = "POST"
    case get = "GET"
}

class OpenAIService {
    
    /*
    @Published var finTitle: String = ""
    @Published var finTime: String = ""
    @Published var finIngredients: String = ""
    @Published var finInstructions: String = ""
    */
    
    static let shared = OpenAIService()
    
    init () {}
    
    func generateURLRequest(httpMethod: HTTPMethod, message: String) throws -> URLRequest {
        guard let url = URL(string: "https://api.openai.com/v1/chat/completions") else {
            throw URLError(.badURL)
        }
        var urlRequest = URLRequest(url: url)
        
        // Method
        urlRequest.httpMethod = httpMethod.rawValue
        
        // Header
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("Bearer \(Secrets.apiKey)", forHTTPHeaderField: "Authorization")
        
        // Body
        let systemMessage = GPTMessage(role: "system", content: "You are creating a recipe using the paramaters I give you.")
        let userMessage = GPTMessage(role: "user", content: message)
        
        let title = GPTFunctionProperty(type: "string", description: "The name of the recipe")
        let time = GPTFunctionProperty(type: "string", description: "The time the recipe will take to cook")
        let ingredients = GPTFunctionProperty(type: "string", description: "The ingredients needed for the recipe. Provide in bullet points")
        let instructions = GPTFunctionProperty(type: "string", description: "The steps for the recipe. Provide in a numbered list")
        
        let params: [String: GPTFunctionProperty] = [
            "title": title,
            "time": time,
            "ingredients": ingredients,
            "instructions": instructions
        ]
        let functionParams = GPTFunctionParam(type: "object", properties: params, required: ["title", "time", "ingredients", "instructions"])
        let function = GPTFunction(name: "get_recipe", description: "Create a recipe using given parameters", parameters: functionParams)
        let payload = GPTChatPayload(model: "gpt-3.5-turbo-0613", messages: [systemMessage, userMessage], functions: [function])
        
        let jsonData = try JSONEncoder().encode(payload)
        
        urlRequest.httpBody = jsonData
        
        return urlRequest
    }
    
    func sendPromptToChatGPT(message: String) async throws -> RecipeResponse {
        let urlRequest = try generateURLRequest(httpMethod: .post, message: message)
        
        let (data, _) = try await URLSession.shared.data(for: urlRequest)
        
        let result = try JSONDecoder().decode(GPTResponse.self, from: data)
        
        let args = result.choices[0].message.functionCall.arguments
       
        guard let argsData = args.data(using: .utf8) else {
            throw URLError(.badURL)
        }
        
        let recipeResponse = try JSONDecoder().decode(RecipeResponse.self, from: argsData)
        
        return recipeResponse
        
        /*
        print(recipeResponse)
        print(recipeResponse.title)
        print(recipeResponse.time)
        print(recipeResponse.ingredients)
        print(recipeResponse.instructions)
        
        
        finTitle = recipeResponse.title
        finTime = recipeResponse.time
        finIngredients = recipeResponse.ingredients
        finInstructions = recipeResponse.instructions 
        
        print(finTime)
        print(finTime)
        print(finIngredients)
        print(finInstructions)
         */
        
        
        //print(result)
        //print(result.choices[0].message.functionCall)
        //print(String(data: data, encoding: .utf8)!)
    }
    
}
