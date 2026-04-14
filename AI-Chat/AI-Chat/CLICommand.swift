//
//  CLICommand.swift
//  AI-Chat
//
//  Created by Oleksandr on 14.04.2026.
//

import Foundation

enum CLICommand: String {
    case help = "/help"
    case clear = "/clear"
    case exit = "/exit"
    case quit = "/quit"

    static func parse(from input: String) -> CLICommand? {
        let trimmed = input.trimmingCharacters(in: .whitespacesAndNewlines)
        return CLICommand(rawValue: trimmed)
    }
}
