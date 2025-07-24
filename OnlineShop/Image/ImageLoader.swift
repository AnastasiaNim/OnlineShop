//
//  ImageLoader.swift
//  OnlineShop
//
//  Created by Anastasia N.  on 02.07.2025.
//

import Foundation
import SwiftUI
import NukeUI


struct ImageLoader: View {
    let urlString: String?
    var body: some View {
        Rectangle()
            .opacity(0)
            .overlay {
                NukeImageLoader(url: URL(string: urlString ?? ""))
                    .allowsHitTesting(false)
            }
            .clipped()
    }
}

fileprivate struct NukeImageLoader: View {
    @State private var showError: Bool = false
    let url: URL?
    var body: some View {
        
        LazyImage(url: url) { state in
            if let image = state.image {
                image
                    .resizable()
                    .scaledToFill()
            } else if state.error != nil {
                ZStack {
                    Color.red
                    Text("Error loading image")// Indicates an error
                }
            } else {
                ProgressView()
            }
        }
    }
}


#Preview {
    VStack {
        
        ImageLoader(urlString: nil)
        ImageLoader(urlString: "https://fastly.picsum.photos/id/16/367/267.jpg?hmac=ZyyuET1a6X-Ym6MXK8OyHrdWFJiLI4To0iYLTlyrD-0")
        ImageLoader(urlString: "https://fastly.WRONGURL")
        
    }
    
}


