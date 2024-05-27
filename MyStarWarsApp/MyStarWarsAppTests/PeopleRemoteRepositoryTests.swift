//
//  PeopleRemoteRepositoryTests.swift
//  MyStarWarsAppTests
//
//  Created by oussema Hichri on 27/05/2024.
//

import XCTest
@testable import MyStarWarsApp

final class PeopleRemoteRepositoryTests: XCTestCase {

    let mockNetworkManager = MockNetworkManager()

    func test_peopleFetched() {
        let sut = PeopleRemoteRepository(networkManager: mockNetworkManager)
        let expectation = self.expectation(description: "Fetching people")

        sut.fetch(page: 1) { result in
            switch result {
            case .success(let people):
                XCTAssertTrue(self.mockNetworkManager.fetchInvoked)
                XCTAssertEqual(people.count, 1)
                XCTAssertEqual(people.first?.name, "Luke Skywalker")
            case .failure(_):
                XCTFail()
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)
    }
}

class MockNetworkManager: NetworkService {
    var fetchInvoked = false
    
    func fetchData<T: Decodable>(endpoint: String, completion: @escaping (Result<T, Error>) -> Void) {
        fetchInvoked = true
        let mockPerson = Person(id: 1, name: "Luke Skywalker", height: "172", mass: "77", hairColor: "blond", skinColor: "fair", eyeColor: "blue", birthYear: "19BBY", gender: "male", homeworld: "Tatooine", created: "2014-12-09T13:50:51.644000Z", edited: "2014-12-20T21:17:56.891000Z", url: "https://swapi.dev/api/people/1/")
        let mockPeopleResponse = PeopleResponse(count: 1, next: nil, previous: nil, results: [mockPerson])
        completion(.success(mockPeopleResponse as! T))
    }
}
