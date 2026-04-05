//
//  CharacterMapper.swift
//  RickAndMortyAppPro
//Created by Brayan Gutierrez Juarez on 03/04/26.
//

import Foundation

extension CharacterDTO {

    func toDomain() -> Character {

        let episodeIDs: [Int] = episode.compactMap {
            Int($0.split(separator: "/").last ?? "")
        }

        return Character(
            id: id,
            name: name,
            status: status,
            species: species,
            gender: gender,
            image: URL(string: image),
            locationName: location.name,
            episodeIDs: episodeIDs
        )
    }
}
