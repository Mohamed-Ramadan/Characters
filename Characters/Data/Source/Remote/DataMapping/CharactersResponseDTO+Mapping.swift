//
//  CharactersResponseDTO+Mapping.swift
//  Characters
//
//  Created by Mohamed Ramadan on 20/10/2024.
//

import Foundation

// MARK: - CharactersResponseDTO
struct CharactersResponseDTO: Codable {
    let info: Info
    let results: [CharacterDTO]
}

// MARK: - Info
struct Info: Codable {
    let count, pages: Int
    let next, prev: String
}

// MARK: - CharacterDTO
struct CharacterDTO: Codable {
    let id: Int
    let name, status, species, type: String
    let gender: String
    let origin, location: CharacterLocation
    let image: String
    let episode: [String]
    let url: String
    let created: String
}

// MARK: - CharacterLocation
struct CharacterLocation: Codable {
    let name: String
    let url: String
}

//MARK: Mapping To Domain
extension CharactersResponseDTO {
    func toDomain(page: Int) -> CharactersModel {
        return .init(info: .init(count: info.count,
                                 pages: info.pages,
                                 next: info.next,
                                 prev: info.prev),
                     results: results.map{ $0.toDomain()})
    }
}

extension CharacterDTO {
    func toDomain() -> CharacterModel {
        return .init(id: id,
                     name: name,
                     status: status,
                     species: species,
                     type: type,
                     gender: gender,
                     origin: .init(name: origin.name,
                                   url: origin.url),
                     location: .init(name: location.name,
                                     url: location.url),
                     image: image,
                     episode: episode,
                     url: url,
                     created: created)
    }
}
