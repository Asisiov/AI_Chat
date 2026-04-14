//
//  LLMEngine.swift
//  LLMLibrary
//
//  Created by Oleksandr on 14.04.2026.
//

public protocol LLMEngine {
    func load(from source: ModelSource) async throws
}

final class LLMEngineImpl: LLMEngine {
    private let loader: ModelLoader
    private var context: ModelContext?
    
    init(loader: ModelLoader) {
        self.loader = loader
    }
    
    public func load(from source: ModelSource) async throws {
        self.context = try await loader.load(from: source)
    }
}

public enum LLMEngineFactory {
    public static func build() -> LLMEngine {
        let loader = ModelLoader()
        return LLMEngineImpl(loader: loader)
    }
}
