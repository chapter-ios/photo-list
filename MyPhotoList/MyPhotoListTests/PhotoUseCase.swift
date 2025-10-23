//
//  PhotoUseCase.swift
//  MyPhotoListTests
//
//  Created by PhinCon on 09/10/25.
//

import Testing
import XCTest
@testable import MyPhotoList

final class PhotoUseCase: XCTestCase {
    var mockingRepo: MockingPhotoRepository!
    var sut: PhotoListUseCase!
    
    override func setUp() {
        super.setUp()
        mockingRepo = MockingPhotoRepository()
        sut = PhotoListUseCase()
    }
    
    override func tearDown() {
        mockingRepo = nil
        sut = nil
        super.tearDown()
    }
    
    func test_useCase_Success() async throws {
        let result = try await sut.execute(page: 1)
        
        XCTAssertGreaterThan(result.first?.width ?? 0, 10)
    }
    
    func test_useCase_Failed() async throws {
        
        do {
            let _ = try await sut.execute(page: -100)
        } catch {
            XCTAssertTrue(error is NetworkError)
        }
    }
    
}
