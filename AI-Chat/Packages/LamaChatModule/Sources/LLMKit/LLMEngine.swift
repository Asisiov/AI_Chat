//
//  LLMEngine.swift
//  LamaChatModule
//
//  Created by Oleksandr on 14.04.2026.
//

public protocol LLMEngine {
    func load(from source: ModelSource) async throws
}

public final class LLMEngineImpl: LLMEngine {
    private let loader: ModelLoader
    private let context: ModelContext?
    
    init(loader: ModelLoader) {
        self.loader = loader
    }
    
    func load(from source: ModelSource) async throws {
        self.context = try await loader.load(from: source)
    }
}

public extension LLMEngineImpl {
    static func make() -> Self {
        let loader = ModelLoader()
        return LLMEngineImpl(loader: loader)
    }
}
