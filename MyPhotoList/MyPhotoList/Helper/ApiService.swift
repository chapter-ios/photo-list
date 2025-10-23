//
//  ApiService.swift
//  MyPhotoList
//
//  Created by PhinCon on 09/10/25.
//

import Foundation

protocol APIServiceProtocol {
    func fetch<T: Decodable>(_ url: URL) async throws -> T
}

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case decodingError
    case serverError(Int)
    case unknown(Error)
}

final class APIService: APIServiceProtocol {
    func fetch<T: Decodable>(_ url: URL) async throws -> T {
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              200 == httpResponse.statusCode else {
            throw NetworkError.invalidResponse
        }
        
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingError
        }
    }
}
