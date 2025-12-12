//
//  ContentView.swift
//  MyPhotoList
//
//  Created by PhinCon on 09/10/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        let vm: PhotoListViewModel = AppDIContainer.shared.container.resolve(PhotoListViewModel.self)!
        PhotoListContainerView(vm: vm)
    }
}

#Preview {
    ContentView()
}
