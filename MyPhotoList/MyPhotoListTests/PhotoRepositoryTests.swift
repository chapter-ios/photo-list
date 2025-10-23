//
//  PhotoRepositoryTests.swift
//  MyPhotoListTests
//
//  Created by PhinCon on 09/10/25.
//

import XCTest
import Foundation
@testable import MyPhotoList

final class PhotoRepositoryTests: XCTestCase {
    
    var mockAPI: MockingApiService!
    var sut: PhotoRepositoryImplementation!
    
    override func setUp() {
        super.setUp()
        mockAPI = MockingApiService()
        sut = PhotoRepositoryImplementation(api: mockAPI)
    }
    
    override func tearDown() {
        sut = nil
        mockAPI = nil
        super.tearDown()
    }
    
    func test_fetchPhotoList_Success() async throws {
        mockAPI.shouldReturnError = false
        mockAPI.mockPhotos = [
            Photo(
                id: "1",
                author: "Jaka",
                width: 100,
                height: 0,
                download_url: "https://picsum.photos/id/0/5000/3333"
            ),
            Photo(
                id: "2",
                author: "Beno",
                width: 0,
                height: 0,
                download_url: "https://picsum.photos/id/0/5000/3333"
            )
        ]
        
        let photos = try await sut.getPhotoList(page: 1)
        XCTAssertEqual(photos.count, 2)
        XCTAssertGreaterThan(photos.first?.width ?? 0, 50)
    }
    
    func test_fetchPhotoList_Failed() async throws {
        mockAPI.shouldReturnError = true
        
        do {
            let _ = try await sut.getPhotoList(page: 1)
        } catch {
            XCTAssertTrue(error is NetworkError)
        }
    }
}

