//
//  App.swift
//  Bitrise-iOS
//
//  Created by Yu Tawata on 2019/06/10.
//

import Foundation
import UIKit
import Shared

class Coordinator {
    let window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }

    func start() {
        window.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
        window.makeKeyAndVisible()
    }
}

class App {
    let coordinator: Coordinator
    let dispatcher: Dispatcher<AppMessage>
    let driver: Driver<AppState, AppMessage>

    init(window: UIWindow, dispatcher: Dispatcher<AppMessage>, driver: Driver<AppState, AppMessage>) {
        self.coordinator = .init(window: window)
        self.dispatcher = dispatcher
        self.driver = driver
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
