//
//  ResponseModels.swift
//  SporkApp-v3
//
//  Created by Adam Belouad on 11/11/23.
//

import Foundation

struct GPTResponse: Decodable {
    let choices: [GPTCompletion]
}

struct GPTCompletion: Decodable {
    let message: GPTResponseMessage
}

struct GPTResponseMessage: Decodable {
    let functionCall: GPTFunctionCall
    
    enum CodingKeys: String, CodingKey {
        case functionCall = "function_call"
    }
}

struct GPTFunctionCall: Decodable {
    let name: String
    let arguments: String
}

struct RecipeResponse: Decodable {
    let title: String
    let time: String
    let serves: String 
    let ingredients: String
    let instructions: String
}
