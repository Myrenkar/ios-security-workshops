//
//  DatabaseProvider.swift
//  Woobly
//
//  Copyright © 2017 netguru. All rights reserved.
//

import Foundation
import SQLiteManager


final class DatabaseProvider {
    
    private static let data = [
        ["John", "Smiths", "jsmiths", "user"],
        ["Tom", "Path", "tpath", "user"],
        ["Jeremy", "Johnson", "jjackson", "user"],
        ["Kate", "Kowalski", "kkowalski", "user"],
        ["Margaret", "Simpson","msimpson", "user"],
        ["Paul", "Santiago", "psantiago", "user"],
        ["George", "Ladner", "gladner", "user"],
        ["Kim", "Kim", "kim", "user"]
    ]
    
    let db: SQLite
    
    
    init() throws {
        db =  try SQLitePool.manager().initialize(database: "database", withExtension: "db")
    }
    
    func prepare() throws {
        try addDummyData()
    }
    
    private func addDummyData() throws {

        let result = try db.query("select count(*) as user_count from users")
        let count = result.results?.first!["user_count"] as? NSNumber
        guard let c = count, c.intValue == 0 else {
            return
        }
        
        for row in DatabaseProvider.data {
            let _ = try db.bindQuery("INSERT INTO 'users' (firstName, lastName, nick, role) VALUES (?,?,?,?)", bindValues: [sqlStr(row[0]), sqlStr(row[1]), sqlStr(row[2]), sqlStr(row[3])])
        }
    }
}
