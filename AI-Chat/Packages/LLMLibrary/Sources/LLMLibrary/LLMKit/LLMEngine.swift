//
//  LLMEngine.swift
//  LLMLibrary
//
//  Created by Oleksandr on 14.04.2026.
//

public protocol LLMEngine {
    func load(from source: ModelSource) async throws
    func generate(prompt: String, options: GenerationOptions) async throws -> String
}

final class LLMEngineImpl: LLMEngine {
    private let loader: ModelLoader
    private let generator: Generator
    private var context: ModelContext?
    
    init(loader: ModelLoader, generator: Generator) {
        self.loader = loader
        self.generator = generator
    }
    
    public func load(from source: ModelSource) async throws {
        self.context = try await loader.load(from: source)
    }
    
    func generate(prompt: String, options: GenerationOptions) async throws -> String {
        guard let context else {
            throw LLMError.modelNotLoaded
        }
        
        return try await generator.generate(prompt: prompt, context: context, options: options)
    }
}

public enum LLMEngineFactory {
    public static func build() -> LLMEngine {
        let loader = ModelLoader()
        let generator = Generator()
        return LLMEngineImpl(loader: loader, generator: generator)
    }
}
