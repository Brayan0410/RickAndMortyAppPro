//
//  FavoritesViewModel.swift
//  RickAndMortyAppPro
//
//  Created by Brayan Gutierrez Juarez on 03/04/26.
//

import Foundation
import Combine

@MainActor
final class FavoritesViewModel: ObservableObject {

    @Published var isAuthenticated = false
    @Published var errorMessage: String?
    @Published var favoriteCharacters: [Character] = []

    private let favoritesManager: FavoritesManager
    private let biometricAuthenticator: BiometricAuthenticator
    private let characterRepository: CharacterRepositoryProtocol

    init(
        favoritesManager: FavoritesManager,
        biometricAuthenticator: BiometricAuthenticator,
        characterRepository: CharacterRepositoryProtocol
    ) {
        self.favoritesManager = favoritesManager
        self.biometricAuthenticator = biometricAuthenticator
        self.characterRepository = characterRepository
    }

    func authenticate() async {

        do {

            try await biometricAuthenticator.authenticateUser()

            isAuthenticated = true

            await loadFavorites()

        } catch {

            errorMessage = "Autenticación fallida o cancelada"

            isAuthenticated = false
        }
    }

    func loadFavorites() async {

        let ids = Array(favoritesManager.favoriteIDs)

        var chars: [Character] = []

        for id in ids {

            do {

                let character = try await characterRepository.fetchCharacter(by: id)

                chars.append(character)

            } catch {

                print("Error loading character \(id): \(error)")
            }
        }

        favoriteCharacters = chars
    }
}
