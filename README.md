# AI-Chat

`AI-Chat` is a macOS CLI project for running a local LLM from Terminal.

The repository contains two main parts:

- **AI-Chat** — the main project, executable target, and binary
- **LLMLibrary** — a reusable Swift module that encapsulates model-loading and inference-related logic

This repository provides the complete source code and a README describing how to build and run the project, what setup is needed to test it, and a short summary of what was implemented and how it works.

---

## Deliverables

This repository provides:

- complete source code in a GitHub-ready structure;
- a reusable module named **LLMLibrary**;
- a CLI executable target and binary named **AI-Chat**;
- instructions for building the project from the command line;
- instructions for running the binary from the build folder;
- setup notes needed to test the project;
- example commands for:
  - help output,
  - loading a local model,
  - a failing Hugging Face model load,
  - a successful Hugging Face model load.

---

## What was implemented

The project is split into two layers.

### `LLMLibrary`

A reusable Swift module responsible for:

- model source resolution;
- model loading;
- model validation;
- generation configuration;
- inference pipeline integration.

This module isolates model-related logic from the CLI layer so the same logic can later be reused by another app target.

### `AI-Chat`

A CLI application responsible for:

- parsing command-line arguments;
- printing help and error messages;
- creating the model source;
- passing generation options into `LLMLibrary`;
- running the end-to-end flow from Terminal.

---

## How it works

The execution flow is:

1. The user runs `AI-Chat` from Terminal.
2. The CLI parses flags such as `--model-path` or `--hf-model`.
3. The CLI validates input.
4. The CLI creates a model source.
5. `LLMLibrary` loads the model.
6. The application continues into inference and prints the result or an error.

In short:

```text
Terminal -> AI-Chat -> CLI parsing -> LLMLibrary -> model load -> inference -> console output
```

### `Build from the command line`
```code
xcodebuild -list -project AI-Chat.xcodeproj
```

### `Build the project into a local build folder`
```code
xcodebuild \
  -project AI-Chat.xcodeproj \
  -scheme AI-Chat \
  -configuration Debug \
  -derivedDataPath build \
  build
```

### `Run the binary from the build folder`
```code
cd build/Build/Products/Debug
./AI-Chat --hf-model mlx-community/Qwen3-4B-4bit
```
### `CLI commands`
```code
--model-path <path>
--hf-model <model-id>
--max-tokens <int>
--temperature <float>
--top-p <float>
--help / -h
```

```text
Exactly one model source must be provided:
either --model-path
or --hf-model
```

### `Example commands`
```text
Help
./AI-Chat --help
```

```text
Local model
./AI-Chat --model-path "/Users/alex/models/Qwen3-4B-4bit" --max-tokens 128
or
./AI-Chat --model-path "/Users/alex/models/Qwen3-4B-4bit"
```

```text
Example of a failing Hugging Face model load
./AI-Chat --hf-model mlx-community/Qwen3-4B-4bit
```
