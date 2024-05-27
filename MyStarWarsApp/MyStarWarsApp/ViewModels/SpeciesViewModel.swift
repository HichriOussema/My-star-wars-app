//
//  SpeciesViewModel.swift
//  MyStarWarsApp
//
//  Created by oussema Hichri on 23/05/2024.
//

import Foundation

class SpeciesViewModel {
  var species: [Species] = []
  var page = 1
  private let speciesLocalRepository:SpeciesLocalStorable
  private let reachabilityManager: ReachabilityManager
  private let speicesFetcher: SpeciesRepositoryFetcher
  init(
    speciesLocalRepository: SpeciesLocalStorable,
    reachabilityManager: ReachabilityManager,
    speicesFetcher: SpeciesRepositoryFetcher
  ) {
    self.speciesLocalRepository = speciesLocalRepository
    self.reachabilityManager = reachabilityManager
    self.speicesFetcher = speicesFetcher
  }
  
  
  func fetchSpecies(completion: @escaping () -> Void) {
    if !reachabilityManager.isConnected {
      species = speciesLocalRepository.fetchSpecies()
      completion()
    } else {
      speicesFetcher.fetch(page: page) { result in
        switch result {
        case .success(let species):
          self.species = species
          self.speciesLocalRepository.saveSpecies(species)
          completion()
        case .failure(let error):
          print(error)
          completion()
        }
      }
    }
  }
  
  func fetchNextPage(completion: @escaping () -> Void) {
    page += 1
    speicesFetcher.fetch(page: page) { result in
      switch result {
      case .success(let species):
        self.species.append(contentsOf: species)
        self.speciesLocalRepository.saveSpecies(species)
        completion()
      case .failure(_): break
      }
    }
  }
}
