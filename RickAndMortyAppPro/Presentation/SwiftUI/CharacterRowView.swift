//
//  CharacterRowView.swift
//  RickAndMortyAppPro
//
//  Created by Brayan Gutierrez Juarez on 04/04/26.
//

import SwiftUI

struct CharacterRowView: View {

    let character: Character
    @EnvironmentObject var favoritesManager: FavoritesManager

    var body: some View {

        HStack {

            CachedAsyncImage(url: character.image)
                .scaledToFill()
                .frame(width: 60, height: 60)
                .clipShape(Circle())

            VStack(alignment: .leading, spacing: 4) {

                Text(character.name)
                    .font(.headline)

                HStack {

                    Circle()
                        .fill(statusColor)
                        .frame(width: 8, height: 8)

                    Text("\(character.status) - \(character.species)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }

            Spacer()

            Button {

                favoritesManager.toggleFavorite(id: character.id)

            } label: {

                Image(
                    systemName: favoritesManager.isFavorite(id: character.id)
                    ? "heart.fill"
                    : "heart"
                )
                .foregroundColor(.red)
            }
            .buttonStyle(.borderless)
        }
        .padding(.vertical, 6)
    }

    private var statusColor: Color {

        switch character.status {

        case "Alive": return .green
        case "Dead": return .red
        default: return .gray
        }
    }
}
