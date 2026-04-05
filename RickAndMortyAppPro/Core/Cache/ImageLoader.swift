//
//  ImageLoader.swift
//  RickAndMortyAppPro
//
//  Created by Brayan Gutierrez Juarez on 04/04/26.
//

import UIKit
import SwiftUI
import Combine

@MainActor
class ImageLoader: ObservableObject {

    @Published var image: UIImage?

    func load(from url: URL) async {

        if let cached = ImageCache.shared.image(for: url) {
            image = cached
            return
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)

            if let downloaded = UIImage(data: data) {

                ImageCache.shared.insert(downloaded, for: url)

                image = downloaded
            }

        } catch {
            print("Image download failed:", error)
        }
    }
}
