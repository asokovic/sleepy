//
//  Shell.swift
//  Sleepy
//
//  Created by Andrija Sokovic on 8. 11. 2025..
//

import Foundation

struct Shell {
    /// Runs a command asynchronously (no blocking), returns PID if successful.
    @discardableResult
    static func runShell(_ command: String) -> Int32? {
        let process = Process()
        process.executableURL = URL(fileURLWithPath: "/bin/bash")
        process.arguments = ["-c", command]

        do {
            try process.run()
            print("Command started: \(command)")
            print("PID: \(process.processIdentifier)")
            return process.processIdentifier
        } catch {
            print("Failed to start process: \(error.localizedDescription)")
            return nil
        }
    }
}
