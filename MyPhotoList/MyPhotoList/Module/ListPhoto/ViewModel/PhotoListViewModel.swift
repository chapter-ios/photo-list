//
//  PhotoListViewModel.swift
//  MyPhotoList
//
//  Created by PhinCon on 09/10/25.
//

import Foundation

@MainActor
final class PhotoListViewModel: ObservableObject {
    @Published var photos: [Photo] = []
    @Published var filteredPhoto: [Photo] = []
    @Published var bookmarkedPhotos: [Photo] = []
    @Published var isLoading = false
    @Published var errorState: String?
    var searchQuery: String = "" {
        didSet {
            self.updateQuery()
        }
    }
    
    private let getUseCase: GetPhotoUseCaseProtocol
    private let storage: BookmarkPhotoProtocol
    
    private var page = 1
    private var loadMore = true
    
    init(
        getUseCase: GetPhotoUseCaseProtocol = PhotoListUseCase(),
        storage: BookmarkPhotoProtocol = BookmarkStorage()
    ) {
        self.getUseCase = getUseCase
        self.storage = storage
        self.bookmarkedPhotos = storage.load()
    }
    
    func toggleBookmark(for photo: Photo) {
        if isBookmarked(photo) {
            bookmarkedPhotos.removeAll { $0.id == photo.id }
        } else {
            bookmarkedPhotos.append(photo)
        }
        storage.save(bookmarkedPhotos)
    }
    
    func isBookmarked(_ photo: Photo) -> Bool {
        bookmarkedPhotos.contains(where: { $0.id == photo.id })
    }
    
    func loadInitialPhotos() {
        photos.removeAll()
        Task { await loadPhotos() }
    }
    
    func loadMoreIfNeeded(currentItem: Photo?) {
        guard let currentItem = currentItem else { return }
        let thresholdIndex = photos.index(photos.endIndex, offsetBy: -3)
        if photos.firstIndex(where: { $0.id == currentItem.id }) == thresholdIndex {
            Task { await loadPhotos() }
        }
    }
    
    func loadPhotos() async {
        guard !isLoading, loadMore else { return }
        isLoading = true
        defer { isLoading = false }
        
        do {
            let newPhotos = try await getUseCase.execute(page: self.page)
            if newPhotos.isEmpty {
                loadMore = false
                self.errorState = "Mengalami error, Silahkan Refresh dengan klik retry"
            } else {
                photos.append(contentsOf: newPhotos)
                self.filteredPhoto = photos
                self.page += 1
            }
        } catch {
            print(error.localizedDescription)
            self.errorState = "Mengalami error, Silahkan Refresh dengan klik retry"
        }
    }
    
    private func updateQuery() {
        if searchQuery.isEmpty {
            self.filteredPhoto = photos
            return
        }
        
        self.filteredPhoto = photos.filter {
            $0.author.lowercased().contains(searchQuery.lowercased())
        }
        print("search query is ", searchQuery)
    }
}
