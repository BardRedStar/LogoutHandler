//
//  APILogoutHandler.swift
//
//  Created by Denis Kovalev
//

import Foundation

class APILogoutHandler: LogoutHandler {

    func logout() async throws {
        // Perform some logout operation on API
        try await Task.sleep(nanoseconds: 1000000000) 
    }
}
