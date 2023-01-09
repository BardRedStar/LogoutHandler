//
//  SyncCompositeLogoutHandler.swift
//
//  Created by Denis Kovalev
//

import Foundation

class SyncCompositeLogoutHandler: CompositeLogoutHandler {
    private let handlers: [LogoutHandler]

    required init(@LogoutHandlerComposed handlerBuilder: () -> [LogoutHandler]) {
        handlers = handlerBuilder()
    }

    func logout() async throws {
        try await handlers.syncForEach {
            try await $0.logout()
        }
    }
}
