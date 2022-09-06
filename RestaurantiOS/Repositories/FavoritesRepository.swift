//
//  FavoritesRepository.swift
//  RestaurantiOS
//
//  Created by Marcelo Fernandez on 06/09/2022.
//

import Foundation

struct FavoritesRepository {
    static let favoritesKey = "FAV_RESTS_KEY"
    
    static func getFavorites() -> [String]{
        return LocalStorageService.getArrayValueFor(key: favoritesKey)
    }
    
    static func removeFavorite(_ id: String) {
        var currentFavs = LocalStorageService.getArrayValueFor(key: favoritesKey)
        
        if let favIndex = currentFavs.firstIndex(of: id) {
            currentFavs.remove(at: favIndex)
        }
        
        LocalStorageService.setArrayValue(currentFavs, for: favoritesKey)
    }
    
    static func addFavorite(_ id: String) {
        var currentFavs = LocalStorageService.getArrayValueFor(key: favoritesKey)
        currentFavs.append(id)
        LocalStorageService.setArrayValue(currentFavs, for: favoritesKey)
    }
    
    static func isFavorite(_ id: String) -> Bool {
        let currentFavs = LocalStorageService.getArrayValueFor(key: favoritesKey)
        return currentFavs.contains { $0 == id }
    }
}
