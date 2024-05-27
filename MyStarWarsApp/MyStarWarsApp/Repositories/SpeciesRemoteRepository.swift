//
//  SpeciesRemoteRepository.swift
//  MyStarWarsApp
//
//  Created by oussema Hichri on 27/05/2024.
//

import Foundation

enum SpeicesError: Error {
    case noData
}

protocol SpeciesRepositoryFetcher {
    func fetch(page:Int, completion: @escaping (Result<[Species], Error>) -> Void )
}

final class SpeciesRemoteRepository: SpeciesRepositoryFetcher {
    private let networkManager: NetworkService
    
    init(networkManager: NetworkService) {
        self.networkManager = networkManager
    }
    
    func fetch(page:Int,completion: @escaping (Result<[Species], Error>) -> Void) {
        networkManager.fetchData(endpoint: "species?page=\(page)") { (result: Result<SpeciesResponse, Error>) in
            switch result {
                case .success(let response):
                    let species = response.results
                    completion(.success(species))
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
}
