//
//  APIClient.swift
//  RickAndMortyAppPro
//
//  Created by Brayan Gutierrez Juarez on 03/04/26.
//

import Foundation

protocol APIClientProtocol {

    func request<T: Decodable>(_ url: URL) async throws -> T
}

final class APIClient: APIClientProtocol {

    func request<T: Decodable>(_ url: URL) async throws -> T {

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse,
              200...299 ~= httpResponse.statusCode
        else {
            throw URLError(.badServerResponse)
        }

        return try JSONDecoder().decode(T.self, from: data)
    }
}
