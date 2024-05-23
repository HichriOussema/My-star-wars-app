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

    func fetchPeople(completion: @escaping () -> Void) {
        NetworkService.shared.fetchData(endpoint: "people") { (result: Result<PeopleResponse, Error>) in
            switch result {
            case .success(let response):
                self.people = response.results
                self.nextPageURL = response.next
                completion()
            case .failure(let error):
                print("Error fetching people: \(error)")
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
                completion()
            case .failure(let error):
                print("Error fetching next page: \(error)")
            }
        }
    }
}

