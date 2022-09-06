//
//  RestaurantRepository.swift
//  RestaurantiOS
//
//  Created by Marcelo Fernandez on 05/09/2022.
//

import Foundation

class RestaurantRepository: RestaurantRepositoryProtocol {
    private let restaurantsUrl = "https://alanflament.github.io/TFTest/test.json"
    private let emptyMessage = "There are no restaurants to show at the moment. Please try again later."
    
    func getRestaurants(completionHandler: @escaping (RestaurantsResponse) -> Void) {
        NetworkService.getDataFrom(url: URL(string: restaurantsUrl)) { state in
            switch state {
            case .success(data: let data):
                let restaurants = self.parseResponse(data)
                if restaurants.isEmpty {
                    completionHandler(.error(message: self.emptyMessage))
                } else {
                    completionHandler(.success(restaurants: restaurants))
                }
            case .error(message: let message):
                completionHandler(.error(message: message))
            case .empty:
                completionHandler(.error(message: self.emptyMessage))
            }
        }
    }
    
    private func parseResponse(_ data: Data) -> [Restaurant] {
        do {
            let decodedData = try JSONDecoder().decode(Response.self, from: data)
            return decodedData.data
        } catch {
            print("An error ocurred trying to decode the server response.")
            return []
        }
    }
}
