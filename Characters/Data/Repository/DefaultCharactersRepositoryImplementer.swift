//
//  DefaultCharactersRepositoryImplementer.swift
//  Characters
//
//  Created by Mohamed Ramadan on 20/10/2024.
//

import Foundation

final class DefaultCharactersRepositoryImplementer: CharactersRepository {
    
    private let networkService: NetworkService
    
    init(networkService: NetworkService = URLSessionNetworkService()) {
        self.networkService = networkService
    }
    
    func getCharacters(status: String,
                       page: Int,
                       completion: @escaping (Result<CharactersResponseDTO, Error>) -> Void) {
        let requestDTO = CharactersRequestDTO(page: page, status: status)
        
        // load Characters from remote service
        networkService.getCharacters(request: requestDTO, completion: completion)
    }
    
    func getCharacterDetails(characterID: Int, completion: @escaping (Result<CharacterDTO, Error>) -> Void) {
        let requestDTO = CharacterRequestDTO(id: characterID)
        
        // load Character Details from remote service
        networkService.getCharacter(request: requestDTO, completion: completion)
    }
}

