//
//  PeopleViewModelTests.swift
//  MyStarWarsAppTests
//
//  Created by oussema Hichri on 27/05/2024.
//

import XCTest
@testable import MyStarWarsApp

class MockPeopleLocalRepository: PeopleLocalStorable {
    func fetchPeople() -> [Person] {
        return []
    }
    
    func savePeople(_ people: [Person]) {}
}

class MockPeopleRepositoryFetcher: PeopleRepositoryFetcher {
    func fetch(page: Int, completion: @escaping (Result<[Person], Error>) -> Void) {
        let mockPerson = Person(id: 1, name: "Luke Skywalker", height: "172", mass: "77", hairColor: "blond", skinColor: "fair", eyeColor: "blue", birthYear: "19BBY", gender: "male", homeworld: "Tatooine", created: "2014-12-09T13:50:51.644000Z", edited: "2014-12-20T21:17:56.891000Z", url: "https://swapi.dev/api/people/1/")
        completion(.success([mockPerson]))
    }
}

class MockReachabilityManager: ReachabilityManager {
    var isConnected: Bool = true
}

final class PeopleViewModelTests: XCTestCase {

    func test_fetchPeople_online() {
        let localRepository = MockPeopleLocalRepository()
        let reachabilityManager = MockReachabilityManager()
        let fetcher = MockPeopleRepositoryFetcher()
        let sut = PeopleViewModel(peopleLocalRepository: localRepository, reachabilityManager: reachabilityManager, peopleFetcher: fetcher)
        
        let expectation = self.expectation(description: "Fetching people")
        
        sut.fetchPeople {
            XCTAssertEqual(sut.people.count, 1)
            XCTAssertEqual(sut.people.first?.name, "Luke Skywalker")
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func test_fetchPeople_offline() {
        let localRepository = MockPeopleLocalRepository()
        let reachabilityManager = MockReachabilityManager()
        reachabilityManager.isConnected = false
        let fetcher = MockPeopleRepositoryFetcher()
        let sut = PeopleViewModel(peopleLocalRepository: localRepository, reachabilityManager: reachabilityManager, peopleFetcher: fetcher)
        
        let expectation = self.expectation(description: "Fetching people from local storage")
        
        sut.fetchPeople {
            XCTAssertEqual(sut.people.count, 0)
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)
    }
}
