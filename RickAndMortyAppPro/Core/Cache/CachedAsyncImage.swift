//
//  CachedAsyncImage.swift
//  RickAndMortyAppPro
//
//  Created by Brayan Gutierrez Juarez on 04/04/26.
//

import SwiftUI

struct CachedAsyncImage: View {

    let url: URL?

    @StateObject private var loader = ImageLoader()

    var body: some View {

        Group {

            if let image = loader.image {

                Image(uiImage: image)
                    .resizable()

            } else {

                ProgressView()
            }
        }
        .task {
            if let url = url {
                await loader.load(from: url)
            }
        }
    }
}
