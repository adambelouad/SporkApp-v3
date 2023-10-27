//
//  ImageAIService.swift
//  SporkApp-v3
//
//  Created by Adam Belouad on 12/20/23.
//

import SwiftUI
import OpenAIKit

final class ImageGenerator: ObservableObject {
    
    private var openai: OpenAI?
    
    func setup() {
        openai = OpenAI(Configuration(
            organizationId: "Adam Belouad",
            apiKey: Secrets.apiKey))
    }
    
    func generateImage(prompt: String) async -> UIImage? {
        guard let openai = openai else {
            return nil
        }
        do {
            let params = ImageParameters(
                prompt: prompt,
                resolution: .large,
                responseFormat: .base64Json
            )
            let result = try await openai.createImage(parameters: params)
            let data = result.data[0].image
            let image = try openai.decodeBase64Image(data)
            return image
        }
        catch {
            print(String(describing: error))
            return nil
        }
    }
}
