//
//  ConsoleIO.swift
//  AI-Chat
//
//  Created by Oleksandr on 14.04.2026.
//

import Foundation

struct ConsoleIO {
    
    func readLine() -> String? {
        Swift.readLine()
    }
    
    func write(_ text: String) {
        Swift.print(text, terminator: "")
        fflush(stdout)
    }
    
    func writeLine(_ text: String) {
        Swift.print(text)
        fflush(stdout)
    }
    
    func writeError(_ text: String) {
        fputs(text, stderr)
        fflush(stderr)
    }
    
    func writeErrorLine(_ text: String) {
        fputs(text + "\n", stderr)
        fflush(stderr)
    }
    
    func clearScreen() {
        write("\u{001B}[2J")
        write("\u{001B}[H")
    }
    
    func writeHelp() {
        write(CLIArguments.helpText)
    }
}
