//
//  NetworkService.swift
//  Characters
//
//  Created by Mohamed Ramadan on 20/10/2024.
//

import Foundation


protocol NetworkService {
    func getCharacters(request: CharactersRequestDTO , completion:  @escaping (Result<CharactersResponseDTO, Error>) -> Void)
    func getCharacter(request: CharacterRequestDTO , completion:  @escaping (Result<CharacterDTO, Error>) -> Void)
}

class URLSessionNetworkService: NetworkService {
    func getCharacter(request: CharacterRequestDTO, completion: @escaping (Result<CharacterDTO, Error>) -> Void) {
        let urlString = Constants.serverBaseURl + "character/\(request.id)"
        guard let urlEncodedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed), let url = URL(string: urlEncodedString) else {
            print("Wrong URL!: \(urlString)")
            return
        }
        
        self.request(url, completion: completion)
    }
    
     
    func getCharacters(request: CharactersRequestDTO, completion: @escaping (Result<CharactersResponseDTO, Error>) -> Void) {
        
        let urlString = Constants.serverBaseURl + "character?page=\(request.page)&status=\(request.status)"
        guard let urlEncodedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed), let url = URL(string: urlEncodedString) else {
            print("Wrong URL!: \(urlString)")
            return
        }
        
        self.request(url, completion: completion)
    }
}

extension URLSessionNetworkService {
    private func request<T: Decodable>(
        _ requestURL: URL,
        httpMethod: HTTPMethod = .get,
        headerFields: [String: String]? = Constants.apiHeaders,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        var urlRequest = URLRequest(url: requestURL)
        urlRequest.httpMethod = httpMethod.rawValue
        urlRequest.allHTTPHeaderFields = headerFields
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                let error = NSError(domain: "Data not valid or empty", code: 402, userInfo: nil)
                completion(.failure(error))
                return
            }
            
            do {
                // parse json data to model items
                let response = try JSONDecoder().decode(T.self, from: data)
                
                completion(.success(response))
            } catch let error {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
}
