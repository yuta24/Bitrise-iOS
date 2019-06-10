//
//  App.swift
//  Bitrise-iOS
//
//  Created by Yu Tawata on 2019/06/10.
//

import Foundation
import UIKit

class Coordinator {
    let window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }
}

class App {
    let coordinator: Coordinator

    init(window: UIWindow) {
        self.coordinator = .init(window: window)
    }
}

extension App {
    func didFinishLaunching(with launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return true
    }

    func willResignActive() {
    }

    func didEnterBackground() {
    }

    func willEnterForeground() {
    }

    func didBecomeActive() {
    }

    func willTerminate() {
    }
}
