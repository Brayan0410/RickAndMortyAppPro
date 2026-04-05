//
//  Endpoint.swift
//  RickAndMortyAppPro
//
//  Created by Brayan Gutierrez Juarez on 03/04/26.
//

import Foundation

enum Endpoint {

    case characters(page: Int, filters: CharacterFilters)
    case character(id: Int)
    case episodes(ids: [Int])

    private var baseURL: String {
        "https://rickandmortyapi.com/api"
    }

    var urlRequest: URLRequest {

        switch self {

        case .characters(let page, let filters):

            var components = URLComponents(string: "\(baseURL)/character")!

            var queryItems: [URLQueryItem] = [
                .init(name: "page", value: "\(page)")
            ]

            if let name = filters.name, !name.isEmpty {
                queryItems.append(.init(name: "name", value: name))
            }

            if let status = filters.status {
                queryItems.append(.init(name: "status", value: status))
            }

            if let species = filters.species {
                queryItems.append(.init(name: "species", value: species))
            }

            components.queryItems = queryItems

            return URLRequest(url: components.url!)

        case .character(let id):

            let url = URL(string: "\(baseURL)/character/\(id)")!
            return URLRequest(url: url)

        case .episodes(let ids):

            let idsString = ids.map { "\($0)" }.joined(separator: ",")
            let url = URL(string: "\(baseURL)/episode/\(idsString)")!

            return URLRequest(url: url)
        }
    }
}
