//
//  APIResponse.swift
//  RickAndMortyAppPro
//
//  Created by Brayan Gutierrez Juarez on 03/04/26.
//

import Foundation

struct APIResponse: Codable {
    let info: PageInfo
    let results: [CharacterDTO]
}

struct PageInfo: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}
