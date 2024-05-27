//
//  PeopleRemoteRepository.swift
//  MyStarWarsApp
//
//  Created by oussema Hichri on 27/05/2024.
//

import Foundation

enum PeopleError: Error {
    case noData
}

protocol PeopleRepositoryFetcher {
    func fetch(page:Int, completion: @escaping (Result<[Person], Error>) -> Void )
}

final class PeopleRemoteRepository: PeopleRepositoryFetcher {
    private let networkManager: NetworkService
    
    init(networkManager: NetworkService) {
        self.networkManager = networkManager
    }
    
    func fetch(page:Int,completion: @escaping (Result<[Person], Error>) -> Void) {
        networkManager.fetchData(endpoint: "people?page=\(page)") { (result: Result<PeopleResponse, Error>) in
            switch result {
                case .success(let response):
                    let people = response.results
                    completion(.success(people))
                case .failure(let error):
                    print(error)
                    completion(.failure(PeopleError.noData))
            }
        }
    }
}
