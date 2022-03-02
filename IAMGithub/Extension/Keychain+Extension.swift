//
//  Keychain+Extension.swift
//  IAMGithub
//
//  Created by 강호성 on 2022/03/01.
//

import Foundation

import KeychainSwift

@propertyWrapper
struct Keychain<T> {
    private let key: String
    private let defaultValue: T

    init(key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }

    var wrappedValue: T {
        get {
            return KeychainSwift().get(key) as? T ?? defaultValue
        }
    }
}

struct Token {
    @Keychain(key: "accessToken", defaultValue: "")
    static var accessToken: String
}

enum keyEnum: String {
    case accessToken = "accessToken"
}
