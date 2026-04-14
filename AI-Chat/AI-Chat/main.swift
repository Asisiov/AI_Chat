//
//  main.swift
//  AI-Chat
//
//  Created by Oleksandr on 13.04.2026.
//

import Foundation
import LLMLibrary

print("Hello, World!")

let engine = LLMEngineFactory.build()

await loadLocalModel(engine)
await loadRemoteModel(engine)

print("Finish load!")

func loadLocalModel(_ engine: LLMEngine) async {
    do {
        try await engine.load(
            from: .directory(URL(filePath: "/Users/alex/models/Qwen3-4B-4bit"))
        )
    } catch {
        print(error)
    }
}

func loadRemoteModel(_ engine: LLMEngine) async {
    do {
        try await engine.load(
            from: .huggingFace(id: "mlx-community/Qwen3-4B-4bit", progressHandler: { progress in
                print("Loading \(progress.completedUnitCount)/\(progress.totalUnitCount)")
            })
        )
    } catch {
        print(error)
    }
}
