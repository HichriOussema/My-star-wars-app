//
//  SpeciesViewModel.swift
//  MyStarWarsApp
//
//  Created by oussema Hichri on 23/05/2024.
//

import Foundation

class SpeciesViewModel {
  var species: [Species] = []
  var nextPageURL: String?
  var error: String?
  
  private let databaseManager = DatabaseManager.shared
  
  func fetchSpecies(completion: @escaping () -> Void) {
    let offlineSpecies = databaseManager.fetchSpecies()
    if !offlineSpecies.isEmpty {
      self.species = offlineSpecies
      print("Loaded species from database: \(offlineSpecies)")
      completion()
    } else {
      NetworkService.shared.fetchData(endpoint: "species") { (result: Result<SpeciesResponse, Error>) in
        switch result {
        case .success(let response):
          self.species = response.results
          self.nextPageURL = response.next
          self.databaseManager.saveSpecies(response.results)
          print("Saved species to database: \(response.results)")
          completion()
        case .failure(let error):
          self.error = error.localizedDescription
          print("Error fetching species: \(error)")
        }
      }
    }
  }
  
  func fetchNextPage(completion: @escaping () -> Void) {
    guard let nextPage = nextPageURL else { return }
    NetworkService.shared.fetchData(endpoint: nextPage) { (result: Result<SpeciesResponse, Error>) in
      switch result {
      case .success(let response):
        self.species.append(contentsOf: response.results)
        self.nextPageURL = response.next
        self.databaseManager.saveSpecies(response.results)
        completion()
      case .failure(let error):
        self.error = error.localizedDescription
        print("Error fetching next page: \(error)")
      }
    }
  }
}


