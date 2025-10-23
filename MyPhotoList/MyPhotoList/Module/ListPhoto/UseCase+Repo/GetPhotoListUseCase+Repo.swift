//
//  GetPhotoListUseCaseProtocol.swift
//  MyPhotoList
//
//  Created by PhinCon on 09/10/25.
//

import Foundation

protocol GetPhotoUseCaseProtocol {
    func execute(page: Int) async throws -> [Photo]
}

protocol GetPhotoListRepository {
    func getPhotoList(page: Int) async throws -> [Photo]
}

final class PhotoRepositoryImplementation: GetPhotoListRepository {
    private let api: APIServiceProtocol
    
    init(api: APIServiceProtocol = APIService()) {
        self.api = api
    }
    
    func getPhotoList(page: Int) async throws -> [Photo] {
        guard let url = URL(string: "https://picsum.photos/v2/list?page=\(page)&limit=10") else {
            throw NetworkError.invalidURL
        }
        return try await self.api.fetch(url)
    }
}

final class PhotoListUseCase: GetPhotoUseCaseProtocol {
    private let repository: GetPhotoListRepository
    
    init(repository: GetPhotoListRepository = PhotoRepositoryImplementation()) {
        self.repository = repository
    }
    
    func execute(page: Int = 1) async throws -> [Photo] {
        try await repository.getPhotoList(page: page)
    }
}

