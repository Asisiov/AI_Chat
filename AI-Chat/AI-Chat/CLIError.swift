//
//  CLIError.swift
//  AI-Chat
//
//  Created by Oleksandr on 14.04.2026.
//

import Foundation

enum CLIError: Error {
    case invalidModelSourceArguments
    case missingValue(String)
    case invalidMaxTokens(String)
    case invalidTemperature(String)
    case invalidTopP(String)
    case unknownArgument(String)
}
