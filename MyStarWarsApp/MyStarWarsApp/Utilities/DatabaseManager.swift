//
//  DatabaseManager.swift
//  MyStarWarsApp
//
//  Created by oussema Hichri on 24/05/2024.
//
import GRDB
import Foundation

protocol DatabaseManager {
    func createTables() throws
    func fetch<T: FetchableRecord & PersistableRecord & Decodable>() -> [T]
    func insert<T: PersistableRecord>(_ object: T) throws
}

final class MyDatabaseManager: DatabaseManager  {
    
    static let shared = MyDatabaseManager()
    private var dbQueue: DatabaseQueue?
    
    private init() {
        setupDatabase()
    }
    
    private func setupDatabase() {
        do {
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let dbURL = documentDirectory.appendingPathComponent("database.sqlite")
            dbQueue = try DatabaseQueue(path: dbURL.path)
            try createTables()
        } catch {
            print("Database setup failed: \(error)")
        }
    }
    
    func createTables() throws {
        try dbQueue?.write { db in
            if try !db.tableExists("person") {
                try db.create(table: "person") { t in
                    t.column("id", .integer).primaryKey()
                    t.column("name", .text).notNull()
                    t.column("height", .text).notNull()
                    t.column("mass", .text).notNull()
                    t.column("hairColor", .text).notNull()
                    t.column("skinColor", .text).notNull()
                    t.column("eyeColor", .text).notNull()
                    t.column("birthYear", .text).notNull()
                    t.column("gender", .text).notNull()
                    t.column("homeworld", .text).notNull()
                    t.column("created", .text).notNull()
                    t.column("edited", .text).notNull()
                    t.column("url", .text).notNull()
                }
            }
            
            if try !db.tableExists("species") {
                try db.create(table: "species") { t in
                    t.column("id", .integer).primaryKey()
                    t.column("name", .text).notNull()
                    t.column("classification", .text).notNull()
                    t.column("designation", .text).notNull()
                    t.column("average_height", .text).notNull()
                    t.column("skin_colors", .text).notNull()
                    t.column("hair_colors", .text).notNull()
                    t.column("eye_colors", .text).notNull()
                    t.column("average_lifespan", .text).notNull()
                    t.column("homeworld", .text)
                    t.column("language", .text).notNull()
                    t.column("created", .text).notNull()
                    t.column("edited", .text).notNull()
                    t.column("url", .text).notNull()
                }
            }
        }
    }
    
    func fetch<T>() -> [T] where T: FetchableRecord & PersistableRecord & Decodable {
        do {
            let objects: [T] = try dbQueue?.read { db in
                try T.fetchAll(db)
            } ?? []
            print("Loaded objects from database: \(objects)")
            return objects
        } catch {
            print("Failed to fetch objects: \(error)")
            return []
        }
    }
    
    func insert<T>(_ object: T) throws where T : PersistableRecord {
        do {
            try dbQueue?.write { db in
                try object.insert(db)
            }
        } catch {
            print("Failed to insert object: \(error)")
            throw error
        }
    }
}
