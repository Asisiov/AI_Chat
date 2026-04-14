//
//  Generator.swift
//  LLMLibrary
//
//  Created by Oleksandr on 14.04.2026.
//

import Foundation
import MLXLMCommon

protocol TextGenerating {
    func generate(
        prompt: String,
        context: ModelContext,
        options: GenerationOptions
    ) async throws -> String
}

final class Generator: TextGenerating {
    func generate(
        prompt: String,
        context: ModelContext,
        options: GenerationOptions
    ) async throws -> String {
        let trimmedPrompt = prompt.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !trimmedPrompt.isEmpty else {
            throw LLMError.emptyPrompt
        }
        
        do {
            let userInput = UserInput(prompt: .text(trimmedPrompt))
            let preparedInput = try await context.container.prepare(input: userInput)
            
            let parameters = GenerateParameters(maxTokens: options.maxTokens,
                                                temperature: options.temperature,
                                                topP: options.topP ?? 1)
            
            let stream = try await context.container.generate(input: preparedInput,
                                                              parameters: parameters)
            
            var response = ""
            for await generation in stream {
                switch generation {
                case .chunk(let text):
                    response += text
                default: break
                }
            }
            
            let finalText = response.trimmingCharacters(in: .whitespacesAndNewlines)
            guard !finalText.isEmpty else {
                throw LLMError.emptyResponse
            }
            
            return finalText
        } catch let error as LLMError {
            throw error
        } catch {
            throw LLMError.generationFailed(underlying: error)
        }
    }
}
