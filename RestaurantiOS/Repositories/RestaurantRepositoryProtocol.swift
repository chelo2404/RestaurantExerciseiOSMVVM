//
//  RestaurantRepositoryProtocol.swift
//  RestaurantiOS
//
//  Created by Marcelo Fernandez on 06/09/2022.
//

import Foundation

enum RestaurantsResponse {
    case success(restaurants:[Restaurant])
    case error(message:String)
}

protocol RestaurantRepositoryProtocol {
    func getRestaurants(completionHandler: @escaping (RestaurantsResponse) -> Void)
}
