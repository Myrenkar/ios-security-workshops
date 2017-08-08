//
//  User.swift
//  Woobly
//
//  Copyright © 2017 netguru. All rights reserved.
//

import Foundation

struct UserModel {
    static let idKey = "id"
    static let firstNameKey = "firstName"
    static let lastNameKey = "lastName"
    static let nicknameKey = "nick"
    static let roleKey = "role"
}

final class User {
    
    let id: Int
    let firstName: String
    let lastName: String
    let nickname: String
    let role: String
    
    init(row: [NSString : NSObject]) throws {
        id = try row.intFor(key: UserModel.idKey)
        firstName = try row.stringFor(key: UserModel.firstNameKey)
        lastName = try row.stringFor(key: UserModel.lastNameKey)
        nickname = try row.stringFor(key: UserModel.nicknameKey)
        role = try row.stringFor(key: UserModel.roleKey)
    }
}

enum DataError: Error {
    case dataMissing
}

fileprivate extension Dictionary where Key == NSString {

    func stringFor(key: String) throws -> String {
        guard let value = self[key as NSString] as? String else {
            throw DataError.dataMissing
        }
        return value
    }
    
    func intFor(key: String) throws -> Int {
        guard let value = self[key as NSString] as? NSNumber else {
            throw DataError.dataMissing
        }
        return value.intValue
    }
}
