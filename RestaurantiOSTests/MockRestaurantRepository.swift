//
//  MockRestaurantRepository.swift
//  RestaurantiOSTests
//
//  Created by Marcelo Fernandez on 06/09/2022.
//

import Foundation
@testable import RestaurantiOS

class MockRestaurantRepository: RestaurantRepositoryProtocol {
    var getRestaurantsCalled = false
    var completeClossure: ((RestaurantsResponse) -> Void)!
    let mockErrorMessage = "The call to the service has failed"
    
    func getRestaurants(completionHandler: @escaping (RestaurantsResponse) -> Void) {
        getRestaurantsCalled = true
        completeClossure = completionHandler
    }
    
    func getSuccess() {
        completeClossure(RestaurantsResponse.success(restaurants: [Restaurant]()))
    }
    
    func getFailure() {
        completeClossure(RestaurantsResponse.error(message: mockErrorMessage))
    }
}

