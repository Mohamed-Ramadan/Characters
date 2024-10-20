//
//  CharactersModel.swift
//  Characters
//
//  Created by Mohamed Ramadan on 20/10/2024.
//

import Foundation

struct CharactersModel {
    let info: CharactersInfoModel
    let results: [CharacterModel]
}

// MARK: - CharactersInfoModel
struct CharactersInfoModel {
    let count, pages: Int
    let next, prev: String
}

// MARK: - CharacterModel
struct CharacterModel {
    let id: Int
    let name, status, species, type: String
    let gender: String
    let origin, location: CharacterLocationModel
    let image: String
    let episode: [String]
    let url: String
    let created: String
}

// MARK: - CharacterLocationModel
struct CharacterLocationModel {
    let name: String
    let url: String
}
