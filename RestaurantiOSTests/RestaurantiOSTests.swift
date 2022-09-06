//
//  RestaurantiOSTests.swift
//  RestaurantiOSTests
//
//  Created by Marcelo Fernandez on 05/09/2022.
//

import XCTest
@testable import RestaurantiOS

class RestaurantiOSTests: XCTestCase {
    var mockRestaurantRepository: MockRestaurantRepository!
    var sut: ListViewModel!

    override func setUpWithError() throws {
        mockRestaurantRepository = MockRestaurantRepository()
        sut = ListViewModel(repository: mockRestaurantRepository)
    }

    override func tearDownWithError() throws {
        mockRestaurantRepository = nil
        sut = nil
    }

    func testFetchRestaurantsSuccess() throws {
        sut.getRestaurants()
        mockRestaurantRepository.getSuccess()
        XCTAssert(mockRestaurantRepository.getRestaurantsCalled)
        XCTAssert(sut.dataArray.count == 0)
        XCTAssert(sut.errorMessage == nil)
    }
    
    func testFetchRestaurantsFailure() throws {
        sut.getRestaurants()
        mockRestaurantRepository.getFailure()
        XCTAssert(mockRestaurantRepository.getRestaurantsCalled)
        XCTAssert(sut.dataArray.count == 0)
        XCTAssert(sut.errorMessage?.elementsEqual(mockRestaurantRepository.mockErrorMessage) ?? false)
    }
}
