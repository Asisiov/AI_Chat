//
//  ModelLoader.swift
//  LamaChatModule
//
//  Created by Oleksandr on 14.04.2026.
//

import MLXLLM
import MLXLMHFAPI
import MLXLMTokenizers
import MLXLMHuggingFace

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
                let container = try await loadModelContainer(
                    from: directoryURL,
                    using: TokenizersLoader()
                )
                
                return ModelContext(container: container)
                
            case .huggingFace(let id, let token):
                try validator.validateRemoteModelID(id)
                
                let hub: HubClient
                if let token, !token.isEmpty {
                    hub = HubClient(token: token)
                } else {
                    hub = HubClient.default
                }
                
                let container = try await loadModelContainer(
                    from: hub,
                    using: TokenizersLoader(),
                    id: id
                )
                
                return ModelContext(container: container)
            }
        } catch let error as LLMError {
            throw error
        } catch {
            throw LLMError.loadFailed(underlying: error)
        }
    }
}
