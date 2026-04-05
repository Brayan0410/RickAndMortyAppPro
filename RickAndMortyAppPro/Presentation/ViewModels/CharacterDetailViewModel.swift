//
//  CharacterDetailViewModel.swift
//  RickAndMortyAppPro
//
//  Created by Brayan Gutierrez Juarez on 03/04/26.
//

import Foundation
import Combine

@MainActor
final class CharacterDetailViewModel: ObservableObject {

    @Published var character: Character
    @Published var episodes: [Episode] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let episodeRepository: EpisodeRepositoryProtocol

    init(
        character: Character,
        episodeRepository: EpisodeRepositoryProtocol
    ) {
        self.character = character
        self.episodeRepository = episodeRepository
    }

    func loadEpisodes() async {

        guard !character.episodeIDs.isEmpty else { return }

        isLoading = true
        errorMessage = nil

        do {
            episodes = try await episodeRepository.fetchEpisodes(by: character.episodeIDs)
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }
}
