//
//  PhotoListView.swift
//  MyPhotoList
//
//  Created by PhinCon on 09/10/25.
//

import SwiftUI

struct PhotoListView: View {
    @ObservedObject var vm: PhotoListViewModel
    @State var writers = ""
    let showBookmarks: Bool
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 12) {
                ForEach(showBookmarks ? vm.bookmarkedPhotos : vm.filteredPhoto) { data in
                    PhotoRowView(
                        photo: data,
                        isBookmarked: vm.isBookmarked(data),
                        toggleBookmark: { vm.toggleBookmark(for: data) }
                    )
                    .onAppear {
                        if !showBookmarks {
                            vm.loadMoreIfNeeded(currentItem: data)
                        }
                    }
                }
                
                if vm.isLoading && !showBookmarks {
                    ProgressView()
                        .tint(.red)
                        .padding()
                }
            }
        }
    }
}

struct PhotoRowView: View {
    let photo: Photo
    let isBookmarked: Bool
    let toggleBookmark: () -> Void
    
    var body: some View {
        ZStack {
            AsyncImage(
                url: URL(string: photo.download_url),
                content: { image in
                    image.resizable()
                        .scaledToFill()
                },
                placeholder: {
                    LoadingImageView()
                }
            )
            .cornerRadius(8)
            .clipped()
            .overlay(alignment: .topTrailing) {
                Button(action: {
                    toggleBookmark()
                }, label: {
                    Image(systemName: isBookmarked ? "bookmark.fill" : "bookmark")
                        .foregroundColor(isBookmarked ? .yellow : .white)
                        .padding(6)
                        .background(Color.black.opacity(0.3))
                        .clipShape(Circle())
                })
            }
            
            Text(photo.author)
                .foregroundStyle(.white)
                .font(Font.system(size: 20, weight: .heavy))
                .padding(.leading, 4)
                .offset(y: 80)
            
            Spacer()
        }
        .padding(.horizontal)
    }
}
