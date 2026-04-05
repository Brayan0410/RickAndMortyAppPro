//
//  CharacterRepository.swift
//  RickAndMortyAppPro
//
//  Created by Brayan Gutierrez Juarez on 03/04/26.
//

import Foundation

final class CharacterRepository: CharacterRepositoryProtocol {

    private let apiClient: APIClientProtocol
    private let baseURL = "https://rickandmortyapi.com/api/character"

    init(apiClient: APIClientProtocol) {
        self.apiClient = apiClient
    }

    func fetchCharacters(
        page: Int,
        filters: CharacterFilters
    ) async throws -> [Character] {

        var urlComponents = URLComponents(string: baseURL)!

        var queryItems = [
            URLQueryItem(name: "page", value: "\(page)")
        ]

        if let name = filters.name, !name.isEmpty {
            queryItems.append(URLQueryItem(name: "name", value: name))
        }

        if let status = filters.status, !status.isEmpty {
            queryItems.append(URLQueryItem(name: "status", value: status))
        }

        if let species = filters.species, !species.isEmpty {
            queryItems.append(URLQueryItem(name: "species", value: species))
        }

        urlComponents.queryItems = queryItems

        guard let url = urlComponents.url else {
            throw URLError(.badURL)
        }

        let apiResponse: APIResponse = try await apiClient.request(url)

        return apiResponse.results.map { $0.toDomain() }
    }

    func fetchCharacter(by id: Int) async throws -> Character {

        let url = URL(string: "\(baseURL)/\(id)")!

        let dto: CharacterDTO = try await apiClient.request(url)

        return dto.toDomain()
    }
}
