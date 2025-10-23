//
//  PhotoListErrorView.swift
//  MyPhotoList
//
//  Created by PhinCon on 09/10/25.
//

import SwiftUI

struct PhotoListErrorView: View {
    @ObservedObject var vm: PhotoListViewModel
    
    var body: some View {
        VStack {
            Text("\(vm.errorState ?? "Error")")
                .font(Font.system(size: 30))
                .foregroundColor(.red)
            
            Button(action: {
                Task {
                    await vm.loadPhotos()
                }
            }, label: {
                Text("Coba Lagi")
                    .font(.headline)
                    .foregroundStyle(.white)
            })
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.roundedRectangle)
            .tint(.red)
        }
    }
}

#Preview {
    PhotoListErrorView(
        vm: PhotoListViewModel()
    )
}
