//
//  EpisodeRepositoryProtocol.swift
//  RickAndMortyAppPro
//
//  Created by Brayan Gutierrez Juarez on 03/04/26.
//

import Foundation

protocol EpisodeRepositoryProtocol {
    func fetchEpisodes(by ids: [Int]) async throws -> [Episode]
}
