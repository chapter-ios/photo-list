//
//  BookmarkHelper.swift
//  MyPhotoList
//
//  Created by PhinCon on 09/10/25.
//

import Foundation

protocol BookmarkPhotoProtocol {
    func save(_ photos: [Photo])
    func load() -> [Photo]
}

final class BookmarkStorage: BookmarkPhotoProtocol {
    private let key = "bookmarked_photos"
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    private let defaults = UserDefaults.standard
    
    func save(_ photos: [Photo]) {
        if let data = try? encoder.encode(photos) {
            defaults.set(data, forKey: key)
        }
    }
    
    func load() -> [Photo] {
        guard let data = defaults.data(forKey: key),
              let decoded = try? decoder.decode([Photo].self, from: data)
        else { return [] }
        
        return decoded
    }
}
