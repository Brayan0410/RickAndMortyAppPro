//
//  Character.swift
//  RickAndMortyAppPro
//
//  Created by Brayan Gutierrez Juarez on 03/04/26.
//

import Foundation

struct Character: Identifiable, Equatable {

    let id: Int
    let name: String
    let status: String
    let species: String
    let gender: String
    let image: URL?
    let locationName: String
    let episodeIDs: [Int]
}
