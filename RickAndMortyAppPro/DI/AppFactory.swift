//
//  AppFactory.swift
//  RickAndMortyAppPro
//
//  Created by Brayan Gutierrez Juarez on 03/04/26.
//

import Foundation
import SwiftUI

final class AppFactory {
    static let shared = AppFactory(container: AppContainer())
     let container: AppContainer

    init(container: AppContainer) {
        self.container = container
    }

    func makeCharacterListView() -> some View {

        let vm = CharacterListViewModel(
            characterRepository: container.characterRepository
        )

        return CharacterListView(viewModel: vm)
    }

    func makeCharacterDetailView(character: Character) -> some View {

            let vm = CharacterDetailViewModel(
                character: character,
                episodeRepository: container.episodeRepository
            )

            return CharacterDetailView(viewModel: vm)
        }
    func makeFavoritesView() -> some View {

        let vm = FavoritesViewModel(
            favoritesManager: container.favoritesManager,
            biometricAuthenticator: container.biometricAuthenticator,
            characterRepository: container.characterRepository
        )

        return FavoritesView(viewModel: vm)
    }
}
