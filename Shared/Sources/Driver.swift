//
//  Driver.swift
//  Shared
//
//  Created by Yu Tawata on 2019/06/13.
//

import Foundation

public class Dispatcher<Message> {
    var callback: (Message) -> Void

    init(callback: @escaping (Message) -> Void) {
        self.callback = callback
    }

    func dispatch(_ message: Message) {
        callback(message)
    }
}

public typealias Mutation<Model, Message> = (Model, Message) -> Model

public struct DriverPlugin<Model, Message> {

    private let _willChange: (Model, Message) -> Void
    private let _didChange: (Model) -> Void

    public init(willChange: @escaping (Model, Message) -> Void, didChange: @escaping (Model) -> Void) {
        self._willChange = willChange
        self._didChange = didChange
    }

    func willChange(model: Model, message: Message) {
        _willChange(model, message)
    }

    func didChange(model: Model) {
        _didChange(model)
    }
}

public class Driver<Model, Message> {
    public struct Token: Hashable {
        var value: String
    }

    struct Holder {
        var handler: (Any) -> Void

        init<V>(_ handler: @escaping (V) -> Void) {
            self.handler = { value in
                handler(value as! V) // swiftlint:disable:this force_cast
            }
        }
    }

    public static func create(initial: Model, mutation: @escaping Mutation<Model, Message>, plugins: [DriverPlugin<Model, Message>] = []) -> (Dispatcher<Message>, Driver<Model, Message>) {
        let driver = Driver<Model, Message>(initial: initial, mutation: mutation)
        let dispatcher = Dispatcher<Message>(callback: { message in
            plugins.forEach {
                $0.willChange(model: driver.current, message: message)
            }
            driver.current = driver.mutation(driver.current, message)
            plugins.forEach {
                $0.didChange(model: driver.current)
            }
        })
        return (dispatcher, driver)
    }

    var current: Model
    var mutation: Mutation<Model, Message>

    var holders = [Token: Holder]()

    init(initial: Model, mutation: @escaping Mutation<Model, Message>) {
        self.current = initial
        self.mutation = mutation
    }

    public func subscribe(handler: @escaping (Model) -> Void) -> Token {
        let token = Token(value: UUID().uuidString)
        holders[token] = Holder(handler)
        return token
    }

    public func unsubscribe(_ token: Token) {
        holders[token] = nil
    }
}
