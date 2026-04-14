//
//  main.swift
//  AI-Chat
//
//  Created by Oleksandr on 13.04.2026.
//

import Foundation
//import LLMLibrary

do {
    let console = ConsoleIO()
    let arguments = try CLIArguments.parseFromCommandLine()
    if arguments.isHelpRequested {
        console.writeHelp()
        Foundation.exit(EXIT_SUCCESS)
    }
        
    let app = CLIApp(arguments: arguments, console: console)
    try await app.run()
    Foundation.exit(EXIT_SUCCESS)
} catch {
    fputs("Error: \(error)\n", stderr)
    Foundation.exit(EXIT_FAILURE)
}
