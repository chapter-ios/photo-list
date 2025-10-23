//
//  MockingApiService.swift
//  MyPhotoListTests
//
//  Created by PhinCon on 09/10/25.
//

import Foundation

@testable import MyPhotoList

final class MockingApiService: APIServiceProtocol {
    
    var shouldReturnError = false
    var mockPhotos: [Photo] = []
    
    func fetch<T>(_ url: URL) async throws -> T where T : Decodable {
        if shouldReturnError {
            throw NetworkError.invalidResponse
        }
        
        let data = try JSONEncoder().encode(mockPhotos)
        return try JSONDecoder().decode(T.self, from: data)
    }
    
}


final class MockingPhotoRepository: GetPhotoListRepository {
    var mockingData: [Photo] = []
    var testingFail = false
    
    func getPhotoList(page: Int) async throws -> [Photo] {
        
        if testingFail {
            throw NetworkError.invalidURL
        }
        let photo = Photo(
            id: "1",
            author: "Marco",
            width: 100,
            height: 100,
            download_url: "https://picsum.photos/id/0/5000/3333")
        mockingData.append(photo)
        return mockingData
    }
    
    
}
