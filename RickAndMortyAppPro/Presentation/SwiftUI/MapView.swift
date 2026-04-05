//
//  MapView.swift
//  RickAndMortyAppPro
//
//  Created by Brayan Gutierrez Juarez on 04/04/26.
//

import SwiftUI
import MapKit

struct MapView: View {

    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 23.6345, longitude: -102.5528),
        span: MKCoordinateSpan(latitudeDelta: 50, longitudeDelta: 50)
    )

    @State private var characters: [Character] = []

    let favoritesManager: FavoritesManager
    let characterRepository: CharacterRepositoryProtocol

    var body: some View {

        Map(coordinateRegion: $region, annotationItems: characters) { character in

            MapAnnotation(
                coordinate: LocationSimulator.simulatedCoordinate(for: character.id)
            ) {

                VStack {

                    Image(systemName: "mappin.circle.fill")
                        .font(.title)
                        .foregroundColor(.blue)

                    Text(character.name)
                        .font(.caption)
                }
            }
        }
        .navigationTitle("Mapa de Personajes")

        .task {

            await loadCharacters()
        }
    }

    func loadCharacters() async {

        let ids = Array(favoritesManager.favoriteIDs)

        guard !ids.isEmpty else { return }

        var results: [Character] = []

        for id in ids {

            if let character = try? await characterRepository.fetchCharacter(by: id) {

                results.append(character)
            }
        }

        characters = results
    }
}
