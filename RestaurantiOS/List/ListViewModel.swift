//
//  ListViewModel.swift
//  RestaurantiOS
//
//  Created by Marcelo Fernandez on 05/09/2022.
//

import Foundation

class ListViewModel {
    @Published var dataArray: [Restaurant] = []
    @Published var errorMessage: String?
    private let repository: RestaurantRepositoryProtocol
    
    init(repository: RestaurantRepositoryProtocol = RestaurantRepository()) {
        self.repository = repository
    }
    
    func getRestaurants() {
        repository.getRestaurants { [weak self] response in
            switch response {
            case .success(restaurants: let restaurants):
                self?.dataArray = restaurants
            case .error(message: let message):
                self?.errorMessage = message
                self?.dataArray = []
            }
        }
    }
}
