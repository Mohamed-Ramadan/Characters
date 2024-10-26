//
//  NetworkServiceTests.swift
//  CharactersTests
//
//  Created by Mohamed Ramadan on 26/10/2024.
//

import Testing
import XCTest
@testable import Characters

class NetworkServiceTests: XCTestCase {
    
    var service: NetworkService!
    
    override func setUp() {
        super.setUp()
        service = URLSessionNetworkService()
    }
    
    override func tearDown() {
        service = nil
        super.tearDown()
    }
    
    func testFetchCharactersSuccess() {
        let expectation = self.expectation(description: "Fetch characters success")
        
        service.getCharacters(request: .init(page: 1, status: "")){ result in
            switch result {
            case .success(let response):
                XCTAssertNotNil(response)
                XCTAssertFalse(response.results.isEmpty, "No characters fetched")
            case .failure(let error):
                XCTFail("Error fetching characters: \(error)")
            }
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testFetchCharactersWithStatusFilter() {
        let expectation = self.expectation(description: "Filteres characters fitched successful")
        
        service.getCharacters(request: .init(page: 1, status: "alive")){ result in
            switch result {
            case .success(let response):
                XCTAssertNotNil(response)
                XCTAssertFalse(response.results.isEmpty, "No Alive characters fetched")
                XCTAssertEqual(response.results.first?.status.lowercased(), "alive")
            case .failure(let error):
                XCTFail("Error fetching characters with filter: \(error)")
            }
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
}
