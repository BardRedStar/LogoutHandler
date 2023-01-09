//
//  LogoutHandlerComposed.swift
//
//  Created by Denis Kovalev
//

import Foundation

@resultBuilder
enum LogoutHandlerComposed {
    static func buildBlock(_ handlers: LogoutHandler...) -> [LogoutHandler] {
        Array(handlers)
    }
}
