//
//  PhotoListView.swift
//  MyPhotoList
//
//  Created by PhinCon on 09/10/25.
//

import SwiftUI

struct PhotoListContainerView: View {
    @StateObject var vm = PhotoListViewModel()
    @State private var showBookmarks = false
    
    var body: some View {
        NavigationView {
            content
                .navigationTitle(
                    showBookmarks ? "bookmark list" : "Photo List")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            showBookmarks.toggle()
                        } label: {
                            Image(
                                systemName: showBookmarks ? "bookmark.fill" : "bookmark"
                            )
                        }
                    }
                }
                .onAppear {
                    Task {
                        await vm.loadPhotos()
                    }
                }
        }
    }
    
    @ViewBuilder
    private var content: some View {
        
        if vm.isLoading && vm.photos.isEmpty {
            GeneralLoadingView()
        } else if let _ = vm.errorState {
            PhotoListErrorView(vm: vm)
        } else {
            PhotoListView(
                vm: vm,
                showBookmarks: showBookmarks
            )
        }
    }
}

#Preview {
    PhotoListContainerView()
}
