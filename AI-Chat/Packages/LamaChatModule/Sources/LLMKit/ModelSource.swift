//
//  ModelSource.swift
//  LamaChatModule
//
//  Created by Oleksandr on 14.04.2026.
//

import Foundation

public enum ModelSource {
    case directory(URL)
    case huggingFace(id: String, token: String? = nil)
}

protocol ModelSourceValidator {
    func validateLocalDirectory(_ url: URL) throws -> URL
    func validateRemoteModelID(_ id: String) throws
}

final class ModelSourceValidatorImpl: ModelSourceValidator {
    func validateLocalDirectory(_ url: URL) throws -> URL {
        let normalizedURL = url.standardizedFileURL
        
        guard normalizedURL.isFileURL else {
            throw LLMError.invalidModelPath(normalizedURL)
        }
        
        let path = normalizedURL.path
        var isDirectory: ObjCBool = false
        
        let exists = FileManager.default.fileExists(
            atPath: path,
            isDirectory: &isDirectory
        )
        
        guard exists else {
            throw LLMError.modelDirectoryNotFound(normalizedURL)
        }
        
        guard isDirectory.boolValue else {
            throw LLMError.invalidModelPath(normalizedURL)
        }
        
        guard FileManager.default.isReadableFile(atPath: path) else {
            throw LLMError.modelDirectoryUnreadable(normalizedURL)
        }
        
        return normalizedURL
    }
    
    func validateRemoteModelID(_ id: String) throws {
        let trimmed = id.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else {
            throw LLMError.invalidRemoteModelID(id)
        }
    }
}
