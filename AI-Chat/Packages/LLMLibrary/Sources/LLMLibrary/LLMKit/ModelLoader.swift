//
//  ModelLoader.swift
//  LLMLibrary
//
//  Created by Oleksandr on 14.04.2026.
//

import MLXLLM
import MLXLMHFAPI
import MLXLMTokenizers

protocol ModelLoading {
    func load(from source: ModelSource) async throws -> ModelContext
}

final class ModelLoader: ModelLoading {
    
    private let validator: ModelSourceValidator
    
    init(validator: ModelSourceValidator = ModelSourceValidatorImpl()) {
        self.validator = validator
    }
    
    func load(from source: ModelSource) async throws -> ModelContext {
        do {
            switch source {
            case .directory(let url):
                let directoryURL = try validator.validateLocalDirectory(url)
                let container = try await loadModelContainer(from: directoryURL)
                return ModelContext(container: container)
                
            case .huggingFace(let id, let progressHandler):
                try validator.validateRemoteModelID(id)
                
                let hub: HubClient = .default
                let container = try await loadModelContainer(
                    from: hub,
                    using: TokenizersLoader(),
                    id: id
                ) { progress in
                    progressHandler?(progress)
                }
                
                return ModelContext(container: container)
            }
        } catch let error as LLMError {
            throw error
        } catch {
            throw LLMError.loadFailed(underlying: error)
        }
    }
}
