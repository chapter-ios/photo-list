//
//  LoadingImageView.swift
//  MyPhotoList
//
//  Created by PhinCon on 09/10/25.
//

import SwiftUI

struct LoadingImageView: View {
    
    var body: some View {
        ZStack {
            Color.blue.frame(width: 250, height: 250)
            VStack {
                CircularLoadingView()
                    .foregroundStyle(.white)
            }
            
        }
    }
}

struct GeneralLoadingView: View {
    @State private var rotate = false
    
    var body: some View {
        VStack {
            CircularLoadingView()
            Text("Loading Data")
        }
        
    }
}

struct CircularLoadingView: View {
    @State private var rotate = false
    
    var body: some View {
        Circle()
            .trim(from: 0.2, to: 1)
            .stroke(style: StrokeStyle(lineWidth: 4, lineCap: .round))
            .frame(width: 40, height: 40)
            .rotationEffect(.degrees(rotate ? 360 : 0))
            .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false))
            .onAppear {
                rotate.toggle()
            }
            .padding()
    }
}

#Preview {
    LoadingImageView()
    GeneralLoadingView()
}
