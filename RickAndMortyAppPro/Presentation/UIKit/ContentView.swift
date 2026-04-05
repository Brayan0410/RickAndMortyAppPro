//
//  ContentView.swift
//  RickAndMortyAppPro
//
//  Created by Brayan Gutierrez Juarez on 04/04/26.
//

import SwiftUI

struct ContentView: View {

    let factory = AppFactory.shared

    var body: some View {

        TabView {

            NavigationView {
                factory.makeCharacterListView()
            }
            .tabItem {
                Label("Personajes", systemImage: "person.3.fill")
            }

            NavigationView {
                factory.makeFavoritesView()
            }
            .tabItem {
                Label("Favoritos", systemImage: "heart.fill")
            }

            NavigationView {
                MapView(
                    favoritesManager: factory.container.favoritesManager,
                    characterRepository: factory.container.characterRepository
                )
            }
            .tabItem {
                Label("Mapa", systemImage: "map.fill")
            }
        }
    }
}
