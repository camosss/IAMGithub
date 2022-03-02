//
//  Bundle.swift
//  IAMGithub
//
//  Created by 강호성 on 2022/03/01.
//

import Foundation

extension Bundle {
    var clientID: String {
        get {
            guard let filePath = self.path(forResource: "ClientInfo", ofType: "plist")
            else { fatalError("Couldn't find file 'ClientInfo.plist'.") }

            let plist = NSDictionary(contentsOfFile: filePath)

            guard let value = plist?.object(forKey: "client_id") as? String else {
                fatalError("client_id를 등록해주세요.")
            }
            return value
        }
    }

    var clientSecrets: String {
        get {
            guard let filePath = self.path(forResource: "ClientInfo", ofType: "plist")
            else { fatalError("Couldn't find file 'ClientInfo.plist'.") }

            let plist = NSDictionary(contentsOfFile: filePath)

            guard let value = plist?.object(forKey: "client_secrets") as? String else {
                fatalError("client_secrets를 등록해주세요.")
            }
            return value
        }
    }
}
