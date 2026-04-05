//
//  FavoritesManager.swift
//  RickAndMortyAppPro
//
//  Created by Eduardo Geovanni Pérez Munguía on 04/04/26.
//

import SwiftUI
import Combine

class FavoritesManager: ObservableObject {

    @Published private(set) var favoriteIDs: Set<Int> = []

    private let repository = FavoritesRepository()

    init() {
        loadFavorites()
    }

    func loadFavorites() {

        let ids = repository.getFavorites()

        favoriteIDs = Set(ids)
    }

    func toggleFavorite(id: Int) {

        if favoriteIDs.contains(id) {

            repository.removeFavorite(id: id)
            favoriteIDs.remove(id)

        } else {

            repository.addFavorite(id: id)
            favoriteIDs.insert(id)
        }
    }

    func isFavorite(id: Int) -> Bool {

        favoriteIDs.contains(id)
    }
}
