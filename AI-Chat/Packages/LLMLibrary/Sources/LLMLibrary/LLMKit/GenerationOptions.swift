//
//  GenerationOptions.swift
//  LLMLibrary
//
//  Created by Oleksandr on 14.04.2026.
//

import Foundation

public struct GenerationOptions: Sendable {
    let maxTokens: Int?
    let temperature: Float
    let topP: Float?

    public init(
        maxTokens: Int? = 256,
        temperature: Float = 0.7,
        topP: Float? = 1.0
    ) {
        precondition(maxTokens == nil || maxTokens! > 0, "maxTokens must be > 0 or nil")
        precondition(temperature >= 0, "temperature must be >= 0")
        precondition(topP == nil || (topP! > 0 && topP! <= 1), "topP must be in (0, 1] or nil")

        self.maxTokens = maxTokens
        self.temperature = temperature
        self.topP = topP
    }

    public static let `default` = GenerationOptions()
}
