//
//  DIHelper.swift
//  MyPhotoList
//
//  Created by Satori on 12/12/25.
//  Copyright © 2025 Satori. All rights reserved.
//

import Foundation
import Swinject

extension AppDIContainer {
    
    func listDIHelper() {
        container.register(APIServiceProtocol.self) { _ in
            APIService()
        }
        
        container.register(BookmarkPhotoProtocol.self) { _ in
            BookmarkStorage()
        }
        
        container.register(GetPhotoListRepository.self) { resolver in
            let network = resolver.resolve(APIServiceProtocol.self)
            return PhotoRepositoryImplementation(api: network!)
        }
        
        container.register(GetPhotoUseCaseProtocol.self) { resolver in
            PhotoListUseCase(
                repository: resolver.resolve(GetPhotoListRepository.self)!
            )
        }
        
        container.register(PhotoListViewModel.self) { resolver in
            PhotoListViewModel(
                getUseCase: resolver.resolve(GetPhotoUseCaseProtocol.self)!,
                storage: resolver.resolve(BookmarkPhotoProtocol.self)!
            )
        }
    }
}
