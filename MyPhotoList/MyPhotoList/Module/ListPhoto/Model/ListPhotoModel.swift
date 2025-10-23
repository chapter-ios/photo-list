//
//  ListPhotoModel.swift
//  MyPhotoList
//
//  Created by PhinCon on 09/10/25.
//

struct Photo: Identifiable, Codable {
    let id: String
    let author: String
    let width, height: Int
    let download_url: String
}
