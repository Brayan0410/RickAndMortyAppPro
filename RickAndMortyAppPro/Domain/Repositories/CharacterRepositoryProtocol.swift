//
//  CharacterRepositoryProtocol.swift
//  RickAndMortyAppPro
//
//  Created by Brayan Gutierrez Juarez on 03/04/26.
//

import Foundation

protocol CharacterRepositoryProtocol {

    func fetchCharacters(
        page: Int,
        filters: CharacterFilters
    ) async throws -> [Character]

    func fetchCharacter(by id: Int) async throws -> Character
}
