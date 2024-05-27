//
//  SpeciesModel.swift
//  MyStarWarsApp
//
//  Created by oussema Hichri on 23/05/2024.
//

import Foundation
import GRDB

struct SpeciesResponse: Decodable {
  let count: Int
  let next: String?
  let previous: String?
  let results: [Species]
}

struct Species: Decodable, FetchableRecord, PersistableRecord {
  var id: Int64?
  let name: String
  let classification: String
  let designation: String
  let averageHeight: String
  let skinColors: String
  let hairColors: String
  let eyeColors: String
  let averageLifespan: String
  let homeworld: String?
  let language: String
  let created: String
  let edited: String
  let url: String
  
  enum CodingKeys: String, CodingKey {
    case name, classification, designation
    case averageHeight = "average_height"
    case skinColors = "skin_colors"
    case hairColors = "hair_colors"
    case eyeColors = "eye_colors"
    case averageLifespan = "average_lifespan"
    case homeworld, language, created, edited, url
  }
  // Custom initializer
  init(id: Int64?, name: String, classification: String, designation: String, averageHeight: String, skinColors: String, hairColors: String, eyeColors: String, averageLifespan: String, homeworld: String?, language: String, created: String, edited: String, url: String) {
    self.id = id
    self.name = name
    self.classification = classification
    self.designation = designation
    self.averageHeight = averageHeight
    self.skinColors = skinColors
    self.hairColors = hairColors
    self.eyeColors = eyeColors
    self.averageLifespan = averageLifespan
    self.homeworld = homeworld
    self.language = language
    self.created = created
    self.edited = edited
    self.url = url
  }
  init(row: Row) {
    id = row["id"]
    name = row["name"]
    classification = row["classification"]
    designation = row["designation"]
    averageHeight = row["average_height"]
    skinColors = row["skin_colors"]
    hairColors = row["hair_colors"]
    eyeColors = row["eye_colors"]
    averageLifespan = row["average_lifespan"]
    homeworld = row["homeworld"]
    language = row["language"]
    created = row["created"]
    edited = row["edited"]
    url = row["url"]
  }
  
  func encode(to container: inout PersistenceContainer) {
    container["id"] = id
    container["name"] = name
    container["classification"] = classification
    container["designation"] = designation
    container["average_height"] = averageHeight
    container["skin_colors"] = skinColors
    container["hair_colors"] = hairColors
    container["eye_colors"] = eyeColors
    container["average_lifespan"] = averageLifespan
    container["homeworld"] = homeworld
    container["language"] = language
    container["created"] = created
    container["edited"] = edited
    container["url"] = url
  }
}
