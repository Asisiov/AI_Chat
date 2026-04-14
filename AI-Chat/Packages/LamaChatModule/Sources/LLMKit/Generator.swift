//
//  Generator.swift
//  LamaChatModule
//
//  Created by Oleksandr on 14.04.2026.
//

import Foundation
import MLXLMCommon

final class Generator {

    func generate(
        prompt: String,
        context: ModelContext,
        options: GenerationOptions
    ) async throws -> String {
        let trimmedPrompt = prompt.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedPrompt.isEmpty else {
            throw LLMError.emptyPrompt
        }

        let userInput = UserInput(prompt: .text(trimmedPrompt))
        let preparedInput = try await context.container.prepare(input: userInput)

        let parameters = GenerateParameters(
            maxTokens: options.maxTokens,
            temperature: options.temperature,
            topP: options.topP ?? 1.0
        )

        let stream = try await context.container.generate(
            input: preparedInput,
            parameters: parameters
        )

        var response = ""

        for await generation in stream {
            switch generation {
            case .chunk(let text):
                response += text

            case .info:
                // Для MVP CLI можно игнорировать метаданные.
                break

            case .toolCall:
                // Для первого минимального CLI tool calling не нужен.
                // Лучше явно игнорировать, чем делать вид, что ты его поддерживаешь.
                break

            @unknown default:
                break
            }
        }

        let finalText = response.trimmingCharacters(in: .whitespacesAndNewlines)

        if finalText.isEmpty {
            throw LLMError.emptyResponse
        }

        return finalText
    }
}
