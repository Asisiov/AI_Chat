//
//  ChatLoop.swift
//  AI-Chat
//
//  Created by Oleksandr on 14.04.2026.
//

import Foundation
import LLMLibrary

struct ChatLoop {
    let engine: LLMEngine
    let console: ConsoleIO
    let options: GenerationOptions
    
    func run() async throws {
        console.writeLine("Model loaded.")
        console.writeLine("Type your message.")
        console.writeLine("Commands: /help, /clear, /exit, /quite")
        
        while true {
            console.write("Your message:")
            
            guard let message = console.readLine() else {
                console.writeLine("")
                console.writeLine("Bye")
                return
            }
            
            let trimmed = message.trimmingCharacters(in: .whitespacesAndNewlines)
            guard !trimmed.isEmpty else { continue }
            
            if let command = CLICommand.parse(from: trimmed) {
                switch command {
                case .help:
                    console.writeLine("""
                                        Commands:
                                          /help  Show commands
                                          /clear Clear terminal screen
                                          /exit  Quit
                                          /quit  Quit
                                        """)
                case .clear:
                    console.clearScreen()
                case .exit, .quit:
                    console.writeLine("Bye")
                    return
                }
                
                continue
            }
            
            do {
                console.writeLine("Assistant:")
                let response = try await engine.generate(
                    prompt: trimmed,
                    options: options
                )
                console.writeLine(response)
            } catch {
                console.writeErrorLine("Generation error: \(error)")
            }
        }
    }
}
