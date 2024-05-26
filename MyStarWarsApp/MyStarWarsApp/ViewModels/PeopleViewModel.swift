//
//  PeopleViewModel.swift
//  MyStarWarsApp
//
//  Created by oussema Hichri on 23/05/2024.
//

import Foundation

class PeopleViewModel {
  var people: [Person] = []
  var nextPageURL: String?
  private let databaseManager = DatabaseManager.shared
  
  func fetchPeople(completion: @escaping () -> Void) {
    let offlinePeople = databaseManager.fetchPeople()
    if !offlinePeople.isEmpty {
      self.people = offlinePeople
      print("Loaded people from database: \(offlinePeople)")
      completion()
    } else {
      NetworkService.shared.fetchData(endpoint: "people") { (result: Result<PeopleResponse, Error>) in
        switch result {
        case .success(let response):
          self.people = response.results
          self.nextPageURL = response.next
          self.databaseManager.savePeople(response.results)
          print("Saved people to database: \(response.results)")
          completion()
        case .failure(let error):
          print("Error fetching people: \(error)")
        }
      }
    }
  }
  
  func fetchNextPage(completion: @escaping () -> Void) {
    guard let nextPage = nextPageURL else { return }
    NetworkService.shared.fetchData(endpoint: nextPage) { (result: Result<PeopleResponse, Error>) in
      switch result {
      case .success(let response):
        self.people.append(contentsOf: response.results)
        self.nextPageURL = response.next
        self.databaseManager.savePeople(response.results)
        print("Saved next page people to database: \(response.results)")
        completion()
      case .failure(let error):
        print("Error fetching next page: \(error)")
      }
    }
  }
}
