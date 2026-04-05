//
//  CharacterDTO.swift
//  RickAndMortyAppPro
//
//  Created by Brayan Gutierrez Juarez on 03/04/26.
//

import Foundation

struct CharacterDTO: Codable {

    let id: Int
    let name: String
    let status: String
    let species: String
    let gender: String
    let image: String
    let location: LocationDTO
    let episode: [String]
}
