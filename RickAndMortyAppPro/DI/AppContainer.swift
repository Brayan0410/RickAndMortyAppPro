//
//  AppContainer.swift
//  RickAndMortyAppPro
//
//  Created by Brayan Gutierrez Juarez on 03/04/26.
//

import Foundation

final class AppContainer {

    lazy var apiClient: APIClientProtocol = APIClient()

    lazy var characterRepository: CharacterRepositoryProtocol =
        CharacterRepository(apiClient: apiClient)

    lazy var episodeRepository: EpisodeRepositoryProtocol =
        EpisodeRepository(apiClient: apiClient)

    lazy var favoritesManager = FavoritesManager()

    lazy var biometricAuthenticator = BiometricAuthenticator()

}
