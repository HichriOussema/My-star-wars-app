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

    func fetchSpecies(completion: @escaping () -> Void) {
        NetworkService.shared.fetchData(endpoint: "species") { (result: Result<SpeciesResponse, Error>) in
            switch result {
            case .success(let response):
                self.species = response.results
                self.nextPageURL = response.next
                completion()
            case .failure(let error):
                print("Error fetching species: \(error)")
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
                completion()
            case .failure(let error):
                print("Error fetching next page: \(error)")
            }
        }
    }
}

