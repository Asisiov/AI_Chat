//
//  CLIArguments.swift
//  AI-Chat
//
//  Created by Oleksandr on 14.04.2026.
//

import Foundation
import LLMLibrary

struct CLIArguments {
    let modelPath: String?
    let hfModelID: String?
    let maxTokens: Int?
    let temperature: Float?
    let topP: Float?
    let isHelpRequested: Bool 

    static func parseFromCommandLine() throws -> CLIArguments {
        let rawArguments = Array(CommandLine.arguments.dropFirst())
        
        var modelPath: String?
        var hfModelID: String?
        var maxTokens: Int?
        var temperature: Float?
        var topP: Float?
        var isHelpRequested: Bool = false
        
        var index = 0
        
        while index < rawArguments.count {
            let argument = rawArguments[index]
            
            switch argument {
            case "--help", "-h":
                isHelpRequested = true
                index += 1
                
            case "--model-path":
                let value = try value(after: argument, in: rawArguments, at: index)
                modelPath = value
                index += 2
                
            case "--hf-model":
                let value = try value(after: argument, in: rawArguments, at: index)
                hfModelID = value
                index += 2
                
            case "--max-tokens":
                let value = try value(after: argument, in: rawArguments, at: index)
                guard let parsed = Int(value), parsed > 0 else {
                    throw CLIError.invalidMaxTokens(value)
                }
                maxTokens = parsed
                index += 2
                
            case "--temperature":
                let value = try value(after: argument, in: rawArguments, at: index)
                guard let parsed = Float(value), parsed >= 0 else {
                    throw CLIError.invalidTemperature(value)
                }
                temperature = parsed
                index += 2
                
            case "--top-p":
                let value = try value(after: argument, in: rawArguments, at: index)
                guard let parsed = Float(value), parsed > 0, parsed <= 1 else {
                    throw CLIError.invalidTopP(value)
                }
                topP = parsed
                index += 2
                
            default:
                throw CLIError.unknownArgument(argument)
            }
        }
        
        return CLIArguments(
            modelPath: modelPath,
            hfModelID: hfModelID,
            maxTokens: maxTokens,
            temperature: temperature,
            topP: topP,
            isHelpRequested: isHelpRequested
        )
    }

    func makeModelSource() throws -> ModelSource {
        if let modelPath, hfModelID == nil {
            return .directory(URL(filePath: modelPath))
        }

        if let hfModelID, modelPath == nil {
            return .huggingFace(
                id: hfModelID,
                progressHandler: { progress in
                    fputs("Loading: \(Int(progress.fractionCompleted * 100))%\n", stderr)
                }
            )
        }

        throw CLIError.invalidModelSourceArguments
    }

    func makeGenerationOptions() throws -> GenerationOptions {
        GenerationOptions(
            maxTokens: maxTokens ?? 256,
            temperature: temperature ?? 0.7,
            topP: topP ?? 1.0
        )
    }
    
    private static func value(
        after flag: String,
        in arguments: [String],
        at index: Int
    ) throws -> String {
        let valueIndex = index + 1
        
        guard valueIndex < arguments.count else {
            throw CLIError.missingValue(flag)
        }
        
        let value = arguments[valueIndex]
        
        guard !value.hasPrefix("--") else {
            throw CLIError.missingValue(flag)
        }
        
        return value
    }
    
    static var helpText: String {
            """
            Usage:
              llama-cli --model-path <path> [options]
              llama-cli --hf-model <model-id> [options]
            
            Required:
              --model-path <path>    Path to local model directory
              --hf-model <model-id>  Hugging Face model identifier
            
            Options:
              --max-tokens <int>     Maximum number of generated tokens (default: 256)
              --temperature <float>  Sampling temperature (default: 0.7)
              --top-p <float>        Top-p sampling value in range (0, 1] (default: 1.0)
              -h, --help             Show help information
            
            Examples:
              llama-cli --model-path /Users/user/models/Llama-3.2-1B
              llama-cli --hf-model mlx-community/Llama-3.2-1B-Instruct-4bit
              llama-cli --hf-model mlx-community/Llama-3.2-1B-Instruct-4bit --max-tokens 128 --temperature 0.5
            """
    }
}
