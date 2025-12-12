//
//  AppDIContainer.swift
//  MyPhotoList
//
//  Created by Satori on 12/12/25.
//  Copyright © 2025 Satori. All rights reserved.
//
import Swinject

class AppDIContainer {
    static let shared = AppDIContainer()
    let container = Container()
    
    private init() {
        listDIHelper()
    }
}
