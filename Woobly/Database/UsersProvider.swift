//
//  UsersProvider.swift
//  Woobly
//
//  Copyright © 2017 netguru. All rights reserved.
//

import Foundation
import SQLiteManager


final class UsersProvider {
    
    private let databaseProvider: DatabaseProvider
    private let db: SQLite
    
    private var loggedInUserId: Int {
        get {
            return UserDefaults.standard.integer(forKey: "loggedInUserId")
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: "loggedInUserId")
            UserDefaults.standard.synchronize()
            loadLoggedInUser()
        }
    }
    
    var loggedInUser: User?
    
    init() throws {
        databaseProvider = try DatabaseProvider()
        db = databaseProvider.db
        loadLoggedInUser()
    }
    
    func all(completion: @escaping ([User]?) -> ()) {
        db.query("SELECT * FROM users", successClosure: { (result) in
            let users = result.results?.flatMap { row in
                return try? User(row: row)
            }
           completion(users)
            
        }, errorClosure: { error in
            print(error)
            completion(nil)
        })
    }
    
    func find(text: String, completion: @escaping ([User]?) -> ()) {
        let statement = "SELECT * FROM users WHERE firstName LIKE '\(text)'"
        db.query(statement, successClosure: { result in
            let users = result.results?.flatMap { row in
                return try? User(row: row)
            }
            completion(users)
            
        }, errorClosure: { error in
            print(error)
            completion(nil)
        })
    }
    
    private func loadLoggedInUser() {
        db.query("SELECT * FROM users WHERE `id` = \(loggedInUserId)", successClosure: {  [weak self] result in
            let users = result.results?.flatMap { row in
                return try? User(row: row)
            }
            self?.loggedInUser = users?.first
            
        }, errorClosure: { error in
            print(error)
        })
    }
}
