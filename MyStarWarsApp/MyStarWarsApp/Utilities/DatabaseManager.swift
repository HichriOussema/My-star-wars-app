//
//  DatabaseManager.swift
//  MyStarWarsApp
//
//  Created by oussema Hichri on 24/05/2024.
//
import GRDB
import Foundation

class DatabaseManager {
  static let shared = DatabaseManager()
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
  
  private func createTables() throws {
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
  
  func savePeople(_ people: [Person]) {
    do {
      try dbQueue?.write { db in
        for person in people {
          try person.insert(db)
        }
      }
      print("Saved people to database: \(people)")
    } catch {
      print("Failed to save people: \(error)")
    }
  }
  
  func fetchPeople() -> [Person] {
    do {
      let people = try dbQueue?.read { db in
        try Person.fetchAll(db)
      } ?? []
      print("Loaded people from database: \(people)")
      return people
    } catch {
      print("Failed to fetch people: \(error)")
      return []
    }
  }
  
  func saveSpecies(_ species: [Species]) {
    do {
      try dbQueue?.write { db in
        for specie in species {
          try specie.insert(db)
        }
      }
      print("Saved species to database: \(species)")
    } catch {
      print("Failed to save species: \(error)")
    }
  }
  
  func fetchSpecies() -> [Species] {
    do {
      let species = try dbQueue?.read { db in
        try Species.fetchAll(db)
      } ?? []
      print("Loaded species from database: \(species)")
      return species
    } catch {
      print("Failed to fetch species: \(error)")
      return []
    }
  }
}
