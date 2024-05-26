//
//  PeopleViewModel.swift
//  MyStarWarsApp
//
//  Created by oussema Hichri on 23/05/2024.
//

import Foundation

import Foundation

class PeopleViewModel {
    var people: [Person] = []
    var nextPageURL: String?
    private let databaseManager = DatabaseManager.shared

    func fetchPeople(completion: @escaping () -> Void) {
        print("Fetching initial data")
        let offlinePeople = databaseManager.fetchPeople()
        if !offlinePeople.isEmpty {
            self.people = offlinePeople
            print("Loaded offline people from database: \(offlinePeople)")
            completion()
        } else {
            NetworkService.shared.fetchData(endpoint: "people") { (result: Result<PeopleResponse, Error>) in
                switch result {
                case .success(let response):
                    self.people = response.results
                    self.nextPageURL = response.next
                    self.databaseManager.savePeople(response.results)
                    print("Fetched people from network: \(response.results)")
                    print("Next page URL: \(self.nextPageURL ?? "None")")
                    completion()
                case .failure(let error):
                    print("Error fetching people: \(error)")
                }
            }
        }
    }

    func fetchNextPage(completion: @escaping () -> Void) {
        guard let nextPage = nextPageURL else {
            print("No nextPageURL")
            return
        }
        print("Fetching next page from URL: \(nextPage)")
        NetworkService.shared.fetchData(endpoint: nextPage) { (result: Result<PeopleResponse, Error>) in
            switch result {
            case .success(let response):
                self.people.append(contentsOf: response.results)
                self.nextPageURL = response.next
                self.databaseManager.savePeople(response.results)
                print("Fetched next page people from network: \(response.results)")
                print("Next page URL: \(self.nextPageURL ?? "None")")
                completion()
            case .failure(let error):
                print("Error fetching next page: \(error)")
            }
        }
    }
}
