//
//  CompositeLogoutHandler.swift
//
//  Created by Denis Kovalev
//

import Foundation

protocol CompositeLogoutHandler: LogoutHandler {
    init(@LogoutHandlerComposed handlerBuilder: () -> [LogoutHandler])
}
