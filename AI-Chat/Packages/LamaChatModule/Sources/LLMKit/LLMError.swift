//
//  LLMError.swift
//  LamaChatModule
//
//  Created by Oleksandr on 14.04.2026.
//

import Foundation

public enum LLMError: Error {
    case modelNotFound
    case invalidModelDirectory
    case modelNotLoaded
    case generationFailed(String)
}
