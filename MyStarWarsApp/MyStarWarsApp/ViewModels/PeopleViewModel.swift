//
//  PeopleViewModel.swift
//  MyStarWarsApp
//
//  Created by oussema Hichri on 23/05/2024.
//

import Foundation

class PeopleViewModel {
  var people: [Person] = []
  var page = 1
  private let peopleLocalRepository:PeopleLocalStorable
  private let reachabilityManager: ReachabilityManager
  private let peopleFetcher: PeopleRepositoryFetcher
  
  init(
    peopleLocalRepository: PeopleLocalStorable,
    reachabilityManager: ReachabilityManager,
    peopleFetcher:PeopleRepositoryFetcher
  ) {
    self.peopleLocalRepository = peopleLocalRepository
    self.reachabilityManager = reachabilityManager
    self.peopleFetcher = peopleFetcher
  }
  
  func fetchPeople(completion: @escaping () -> Void) {
    if !reachabilityManager.isConnected {
      people = peopleLocalRepository.fetchPeople()
      completion()
    } else {
      peopleFetcher.fetch(page:page) { result in
        switch result {
        case .success(let people):
          self.people = people
          self.peopleLocalRepository.savePeople(people)
          completion()
        case .failure(let error ):
          print(error)
          completion()
          
        }
      }
    }
  }
  
  func fetchNextPage(completion: @escaping () -> Void) {
    page += 1
    peopleFetcher.fetch(page:page) { result in
      switch result {
      case .success(let people):
        self.people.append(contentsOf: people)
        self.peopleLocalRepository.savePeople(people)
        completion()
      case .failure(_): break
      }
    }
  }
}
