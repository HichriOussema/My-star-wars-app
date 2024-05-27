//
//  SpeciesLocalRepository.swift
//  MyStarWarsApp
//
//  Created by oussema Hichri on 27/05/2024.
//

import Foundation

protocol SpeciesLocalStorable{
    func saveSpecies(_ species: [Species])
    func fetchSpecies() -> [Species]
}

final class SpeciesLocalRepository: SpeciesLocalStorable{
    private let databaseManger: DatabaseManager
    
    init(databaseManger: DatabaseManager){
        self.databaseManger = databaseManger
    }
    
    
    func saveSpecies(_ species: [Species]) {
        for specie in species {
            try? databaseManger.insert(specie)
        }
    }
    
    func fetchSpecies() -> [Species] {
        let species:[Species] = databaseManger.fetch()
        return species
    }
}
