//
//  FavoritesRepository.swift
//  RickAndMortyAppPro
//
//  Created by Eduardo Geovanni Pérez Munguía on 04/04/26.
//

import CoreData

final class FavoritesRepository {

    private let context = CoreDataStack.shared.context

    func getFavorites() -> [Int] {

        let request: NSFetchRequest<FavoriteCharacter> = FavoriteCharacter.fetchRequest()

        let results = try? context.fetch(request)

        return results?.map { Int($0.id) } ?? []
    }

    func addFavorite(id: Int) {

        let favorite = FavoriteCharacter(context: context)
        favorite.id = Int64(id)

        CoreDataStack.shared.save()
    }

    func removeFavorite(id: Int) {

        let request: NSFetchRequest<FavoriteCharacter> = FavoriteCharacter.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", id)

        if let result = try? context.fetch(request).first {

            context.delete(result)

            CoreDataStack.shared.save()
        }
    }

    func isFavorite(id: Int) -> Bool {

        let request: NSFetchRequest<FavoriteCharacter> = FavoriteCharacter.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", id)

        let count = (try? context.count(for: request)) ?? 0

        return count > 0
    }
}
