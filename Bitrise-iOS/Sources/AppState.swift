//
//  AppState.swift
//  Bitrise-iOS
//
//  Created by Yu Tawata on 2019/06/10.
//

import Foundation

enum AppMessage {
    case loggedIn
}

struct AppState {
    enum LoginState {
        case unauthorized
        case authorized
    }

    var loginState: LoginState

    init(loginState: LoginState = .unauthorized) {
        self.loginState = loginState
    }
}
