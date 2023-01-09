//
//  NavigationLogoutHandler.swift
//
//  Created by Denis Kovalev
//

import Foundation

class NavigationLogoutHandler: LogoutHandler {
    private let handler: () -> Void

    init(logoutNavigationHandler: @escaping () -> Void) {
        handler = logoutNavigationHandler
    }

    func logout() async throws {
        await MainActor.run {
            handler()
        }
    }
}
