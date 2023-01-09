//
//  Sequence+Concurrency.swift
//
//  Created by Denis Kovalev
//

import Foundation

extension Sequence {
    /// Runs asynchronous `operation` lambda for each element in the Sequence synchronously.
    /// Awaits previous step completion before performing the next operation
    func syncForEach(_ operation: (Element) async throws -> Void) async rethrows {
        for element in self {
            try await operation(element)
        }
    }

    /// Runs asynchronous `operation` lambda for each element in the Sequence asynchronously.
    /// Performs operations in parallel and returns after all tasks are completed
    func asyncForEach(_ operation: @escaping (Element) async throws -> Void) async rethrows {
        await withThrowingTaskGroup(of: Void.self) { group in
            for element in self {
                group.addTask {
                    try await operation(element)
                }
            }
        }
    }
}
