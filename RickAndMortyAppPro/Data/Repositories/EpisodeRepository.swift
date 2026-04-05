//
//  EpisodeRepository.swift
//  RickAndMortyAppPro
//
//  Created by Brayan Gutierrez Juarez on 03/04/26.
//

import Foundation

final class EpisodeRepository: EpisodeRepositoryProtocol {

    private let apiClient: APIClientProtocol
    private let baseURL = "https://rickandmortyapi.com/api/episode"

    init(apiClient: APIClientProtocol) {
        self.apiClient = apiClient
    }

    func fetchEpisodes(by ids: [Int]) async throws -> [Episode] {

        guard !ids.isEmpty else { return [] }

        let idsString = ids.map { "\($0)" }.joined(separator: ",")

        let url = URL(string: "\(baseURL)/\(idsString)")!

        if ids.count == 1 {

            let dto: EpisodeDTO = try await apiClient.request(url)

            return [dto.toDomain()]

        } else {

            let dtos: [EpisodeDTO] = try await apiClient.request(url)

            return dtos.map { $0.toDomain() }
        }
    }
}
