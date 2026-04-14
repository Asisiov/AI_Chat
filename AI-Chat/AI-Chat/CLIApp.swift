//
//  CLIApp.swift
//  AI-Chat
//
//  Created by Oleksandr on 14.04.2026.
//

import LLMLibrary

struct CLIApp {
    let arguments: CLIArguments
    let console: ConsoleIO
    
    func run() async throws {
        let source = try arguments.makeModelSource()
        let options = try arguments.makeGenerationOptions()
        let enginee = LLMEngineFactory.build()
        
        console.writeLine("Loading model...")
        do {
            try await enginee.load(from: source)
        } catch {
            console.writeError("Failed to load model: \(error)")
            throw error
        }
        
        let chat = ChatLoop(engine: enginee, console: console, options: options)
        try await chat.run()
    }
}
