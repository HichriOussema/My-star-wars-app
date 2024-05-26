//
//  PeopleModel.swift
//  MyStarWarsApp
//
//  Created by oussema Hichri on 23/05/2024.
//

import Foundation
import GRDB

struct PeopleResponse: Decodable {
  let count: Int
  let next: String?
  let previous: String?
  let results: [Person]
}

struct Person: Decodable, FetchableRecord, PersistableRecord {
  var id: Int64?
  let name: String
  let height: String
  let mass: String
  let hairColor: String
  let skinColor: String
  let eyeColor: String
  let birthYear: String
  let gender: String
  let homeworld: String
  let created: String
  let edited: String
  let url: String
  
  enum CodingKeys: String, CodingKey {
    case name, height, mass, url
    case hairColor = "hair_color"
    case skinColor = "skin_color"
    case eyeColor = "eye_color"
    case birthYear = "birth_year"
    case gender, homeworld, created, edited
  }
  
  // Required initializers for FetchableRecord and PersistableRecord
  init(row: Row) {
    id = row["id"]
    name = row["name"]
    height = row["height"]
    mass = row["mass"]
    hairColor = row["hairColor"]
    skinColor = row["skinColor"]
    eyeColor = row["eyeColor"]
    birthYear = row["birthYear"]
    gender = row["gender"]
    homeworld = row["homeworld"]
    created = row["created"]
    edited = row["edited"]
    url = row["url"]
  }
  
  func encode(to container: inout PersistenceContainer) {
    container["id"] = id
    container["name"] = name
    container["height"] = height
    container["mass"] = mass
    container["hairColor"] = hairColor
    container["skinColor"] = skinColor
    container["eyeColor"] = eyeColor
    container["birthYear"] = birthYear
    container["gender"] = gender
    container["homeworld"] = homeworld
    container["created"] = created
    container["edited"] = edited
    container["url"] = url
  }
}
