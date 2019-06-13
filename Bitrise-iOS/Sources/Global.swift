//
//  Global.swift
//  Bitrise-iOS
//
//  Created by Yu Tawata on 2019/06/10.
//

import Foundation
import UIKit
import Shared

private let (dispatcher, driver) = Driver<AppState, AppMessage>.create(initial: .init(), mutation: { (state, message) -> AppState in
    return state
})

let app = App(window: UIWindow(frame: UIScreen.main.bounds), dispatcher: dispatcher, driver: driver)
