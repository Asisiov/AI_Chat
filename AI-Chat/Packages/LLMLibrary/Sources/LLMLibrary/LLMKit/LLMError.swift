//
//  LLMError.swift
//  LLMLibrary
//
//  Created by Oleksandr on 14.04.2026.
//

import Foundation

public enum LLMError: Error {
    case modelDirectoryNotFound(URL)
    case modelDirectoryUnreadable(URL)
    case invalidModelPath(URL)
    case loadFailed(underlying: Error)
    case invalidRemoteModelID(String)
    case modelNotLoaded
    case emptyPrompt
    case emptyResponse
    case generationFailed(underlying: Error)
}
