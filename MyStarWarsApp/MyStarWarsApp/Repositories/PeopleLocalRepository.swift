//
//  PeopleLocalRepository.swift
//  MyStarWarsApp
//
//  Created by oussema Hichri on 27/05/2024.
//

import Foundation

protocol PeopleLocalStorable{
    func savePeople(_ people: [Person])
    func fetchPeople() -> [Person]
}

final class PeopleLocalRepository: PeopleLocalStorable{
    private let databaseManger: DatabaseManager
    
    init(databaseManger: DatabaseManager){
        self.databaseManger = databaseManger
    }
    
    
    func savePeople(_ people: [Person]) {
        for person in people {
            try? databaseManger.insert(person)
        }
    }
    
    func fetchPeople() -> [Person] {
        let people: [Person] = databaseManger.fetch()
        return people
    }
}
