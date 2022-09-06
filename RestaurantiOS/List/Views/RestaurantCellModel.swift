//
//  RestaurantCellViewModel.swift
//  RestaurantiOS
//
//  Created by Marcelo Fernandez on 06/09/2022.
//

import Foundation

struct RestaurantCellModel {
    let id: String
    let image: URL?
    let name: String
    let rating: Double
    let address: String
    let favorite: Bool
    
    static func fromServiceModel(_ model: Restaurant) -> RestaurantCellModel {
        RestaurantCellModel(
            id: model.id,
            image: model.imageUrl,
            name: model.name,
            rating: model.rating,
            address: model.address,
            favorite: RestaurantCellModel.isFavorite(model.id)
        )
    }
    
    static func isFavorite(_ id: String) -> Bool {
        FavoritesRepository.isFavorite(id)
    }
    
    static func addFavorite(_ id: String) {
        FavoritesRepository.addFavorite(id)
    }
    
    static func removeFavorite(_ id: String) {
        FavoritesRepository.removeFavorite(id)
    }
}
