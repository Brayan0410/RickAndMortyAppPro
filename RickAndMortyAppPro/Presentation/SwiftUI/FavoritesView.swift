//
//  FavoritesView.swift
//  RickAndMortyAppPro
//
//  Created by Brayan Gutierrez Juarez on 04/04/26.
//

import SwiftUI

struct FavoritesView: View {

    @StateObject var viewModel: FavoritesViewModel

    var body: some View {

        Group {

            if !viewModel.isAuthenticated {

                authView

            } else {

                favoritesList
            }
        }
        .padding()
    }
    private var authView: some View {

        VStack(spacing: 20) {

            Text("Acceso a favoritos protegido")
                .font(.title2)

            if let error = viewModel.errorMessage {

                Text(error)
                    .foregroundColor(.red)
            }

            Button("Autenticarse") {

                Task {
                    await viewModel.authenticate()
                }
            }
            .buttonStyle(.borderedProminent)
        }
    }
    private var favoritesList: some View {

        List(viewModel.favoriteCharacters) { character in

            NavigationLink(
                destination: AppFactory.shared.makeCharacterDetailView(character: character)
            ) {

                CharacterRowView(character: character)
            }
        }
        .navigationTitle("Favoritos")

        .refreshable {

            await viewModel.loadFavorites()
        }
    }
}
