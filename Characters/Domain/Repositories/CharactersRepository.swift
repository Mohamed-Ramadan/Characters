//
//  CharactersRepository.swift
//  Characters
//
//  Created by Mohamed Ramadan on 20/10/2024.
//

import Foundation

protocol CharactersRepository {
    
    func getCharacters(status: String,
                       page: Int,
                       completion: @escaping (Result<CharactersResponseDTO, Error>) -> Void)
    
    func getCharacterDetails(characterID: Int,
                             completion: @escaping (Result<CharacterDTO, Error>) -> Void)
}

