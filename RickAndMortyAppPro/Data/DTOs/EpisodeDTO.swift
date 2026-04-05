//
//  EpisodeDTO.swift
//  RickAndMortyAppPro
//
//  Created by Brayan Gutierrez Juarez on 03/04/26.
//

import Foundation

struct EpisodeDTO: Codable {
    let id: Int
    let name: String
    let episode: String
    
    func toDomain() -> Episode {
        return Episode(id: id, name: name, episode: episode)
    }
}
