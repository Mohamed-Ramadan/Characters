//
//  CharactersUseCase.swift
//  Characters
//
//  Created by Mohamed Ramadan on 20/10/2024.
//

import Foundation


protocol CharactersUseCase {
    func fetchCharacters(requestValue: CharactersRequestValue,
                         completion: @escaping (Result<CharactersModel, Error>) -> Void)
    
    func fetchCharacterDetails(requestValue: CharacterDetailsRequestValue,
                               completion: @escaping (Result<CharacterModel, Error>) -> Void)
}

final class DefaultCharactersUseCase: CharactersUseCase {
    
    private let charactersRepository: CharactersRepository
    
    init(charactersRepository: CharactersRepository) {
        self.charactersRepository = charactersRepository
    }
    
    func fetchCharacters(requestValue: CharactersRequestValue,
                         completion: @escaping (Result<CharactersModel, Error>) -> Void) {
        
        return self.charactersRepository.getCharacters(status: requestValue.status,
                                                       page: requestValue.page) { (result) in
            switch result {
            case .success(let model):
                completion(.success(model.toDomain(page: requestValue.page)))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchCharacterDetails(requestValue: CharacterDetailsRequestValue,
                               completion: @escaping (Result<CharacterModel, Error>) -> Void) {
        return self.charactersRepository.getCharacterDetails(characterID: requestValue.characterId) { (result) in
            switch result {
            case .success(let model):
                completion(.success(model.toDomain()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

struct CharactersRequestValue {
    let page: Int
    let status: String
}

struct CharacterDetailsRequestValue {
    let characterId: Int
}

