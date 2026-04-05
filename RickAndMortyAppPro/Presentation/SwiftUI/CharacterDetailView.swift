//
//  CharacterDetailView.swift
//  RickAndMortyAppPro
//
//  Created by Brayan Gutierrez Juarez on 04/04/26.
//

import SwiftUI

struct CharacterDetailView: View {

    @StateObject var viewModel: CharacterDetailViewModel
    @EnvironmentObject var favoritesManager: FavoritesManager

    @State private var showMap = false

    var body: some View {

        ScrollView {

            VStack(alignment: .leading, spacing: 16) {

                characterImage

                characterInfo

                Divider()

                episodesSection

                Divider()

                actionsSection
            }
            .padding(.vertical)
        }
        .navigationTitle(viewModel.character.name)
        .navigationBarTitleDisplayMode(.inline)

        .task {
            await viewModel.loadEpisodes()
        }
    }
    private var characterImage: some View {
        
        Group {
            
            if let url = viewModel.character.image {
                
                CachedAsyncImage(url: url)
                    .aspectRatio(contentMode: .fill)
                
            } else {
                
                ZStack {
                    Color.gray.opacity(0.2)
                    Image(systemName: "photo")
                        .font(.largeTitle)
                        .foregroundColor(.gray)
                }
            }
        }
        .frame(height: 300)
        .clipped()
        .cornerRadius(10)
    }
    private var characterInfo: some View {

        VStack(alignment: .leading, spacing: 8) {

            Text(viewModel.character.name)
                .font(.largeTitle)
                .fontWeight(.bold)

            HStack {

                Text("Estado:")

                Text(viewModel.character.status)
                    .foregroundColor(
                        viewModel.character.status == "Alive" ? .green : .red
                    )
            }

            Text("Especie: \(viewModel.character.species)")
            Text("Género: \(viewModel.character.gender)")
            Text("Ubicación: \(viewModel.character.locationName)")
        }
        .padding(.horizontal)
    }
    private var episodesSection: some View {

        VStack(alignment: .leading, spacing: 8) {

            Text("Episodios")
                .font(.title2)
                .bold()

            if viewModel.isLoading {

                ProgressView()

            } else if let error = viewModel.errorMessage {

                Text("Error: \(error)")
                    .foregroundColor(.red)

            } else {

                ForEach(viewModel.episodes) { episode in

                    VStack(alignment: .leading) {

                        Text(episode.name)

                        Text(episode.episode)
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    .padding(.vertical, 4)
                }
            }
        }
        .padding(.horizontal)
    }
    private var actionsSection: some View {

        HStack(spacing: 16) {

            Button {

                favoritesManager.toggleFavorite(id: viewModel.character.id)

            } label: {

                Label(
                    favoritesManager.isFavorite(id: viewModel.character.id)
                    ? "Favorito"
                    : "Agregar a favoritos",

                    systemImage:
                        favoritesManager.isFavorite(id: viewModel.character.id)
                    ? "heart.fill"
                    : "heart"
                )
            }
            .buttonStyle(.borderless)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.blue.opacity(0.1))
            .cornerRadius(10)

            Button {

                showMap = true

            } label: {

                Label("Ver en mapa", systemImage: "map")
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.green.opacity(0.1))
            .cornerRadius(10)
        }
        .padding(.horizontal)

        .sheet(isPresented: $showMap) {

            NavigationView {

                CharacterMapView(character: viewModel.character)
            }
        }
    }
}

