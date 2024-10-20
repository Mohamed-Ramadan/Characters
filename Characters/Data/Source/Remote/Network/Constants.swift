//
//  Constants.swift
//  Characters
//
//  Created by Mohamed Ramadan on 20/10/2024.
//

import Foundation


class Constants {
    static let serverBaseURl = "https://rickandmortyapi.com/api/"
    
    static let apiHeaders = [
        "accept": "application/json"
      ]
}

enum HTTPMethod: String {
    case get = "GET"
}
