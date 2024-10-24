//
//  CharactersListItemViewModel.swift
//  Characters
//
//  Created by Mohamed Ramadan on 20/10/2024.
//

import Foundation

struct CharactersListItemViewModel {
    var id: Int
    var name: String
    var status: String
    var type: String
    var imageURL: String
    var species: String
}

extension CharactersListItemViewModel {
    init(character: CharacterModel) {
        self.id = character.id
        self.name = character.name
        self.type = character.type
        self.imageURL = character.image
        self.species = character.species
        self.status = character.status
    }
}

