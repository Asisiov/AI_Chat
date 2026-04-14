//
//  GenerationOptions.swift
//  LamaChatModule
//
//  Created by Oleksandr on 14.04.2026.
//

struct GenerationOptions {
    let maxTokens: Int?
    let temperature: Float
    let topP: Float?

    static let `default` = GenerationOptions(
        maxTokens: 256,
        temperature: 0.6,
        topP: 1.0
    )
}
