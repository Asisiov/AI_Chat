//
//  main.swift
//  AI-Chat
//
//  Created by Oleksandr on 13.04.2026.
//

import Foundation
import LLMLibrary

func runMultipleExamples() async {
    let engine = LLMEngineFactory.build()

    do {
        try await engine.load(
            from: .huggingFace(id: "mlx-community/Qwen3-4B-4bit", progressHandler: { progress in
                print("Loading \(progress.completedUnitCount)/\(progress.totalUnitCount)")
            })
        )

        let prompts: [(String, GenerationOptions)] = [
            (
                "What does a Research Engineer do?",
                .default
            ),
            (
                "Give 3 concise interview answers about Swift Concurrency.",
                GenerationOptions(
                    maxTokens: 120,
                    temperature: 0.2,
                    topP: 0.9
                )
            ),
            (
                "Suggest 5 macOS app names for a local AI assistant.",
                GenerationOptions(
                    maxTokens: 180,
                    temperature: 1.0,
                    topP: 1.0
                )
            )
        ]

        for (prompt, options) in prompts {
            let response = try await engine.generate(
                prompt: prompt,
                options: options
            )

            print("Prompt: \(prompt)")
            print("Response: \(response)")
            print("-----")
        }
    } catch {
        print("Error: \(error)")
    }
}

await runMultipleExamples()
