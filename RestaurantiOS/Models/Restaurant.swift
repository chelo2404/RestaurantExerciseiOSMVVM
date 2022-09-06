//
//  Restaurant.swift
//  RestaurantiOS
//
//  Created by Marcelo Fernandez on 05/09/2022.
//

import Foundation

struct Restaurant: Decodable {
    let id: String
    let name: String
    let imageUrl: URL?
    let rating: Double
    let address: String
    
    enum RootKeys: String, CodingKey {
        case uuid, name, mainPhoto, aggregateRatings, address
    }
    
    enum MainPhotoKeys: String, CodingKey {
        case source
    }
    
    enum AggregateRatingsKeys: String, CodingKey {
        case tripadvisor
    }
    
    enum TripAdvisorKeys: String, CodingKey {
        case ratingValue
    }
    
    enum AddressKeys: String, CodingKey {
        case street, locality, country
    }
    
    // Custom decoder to format the information and get the values we need for the app.
    init(from decoder: Decoder) throws {
        let rootContainer = try decoder.container(keyedBy: RootKeys.self)
        let mainPhotoContainer = try? rootContainer.nestedContainer(keyedBy: MainPhotoKeys.self, forKey: .mainPhoto)
        let ratingsContainer = try rootContainer.nestedContainer(keyedBy: AggregateRatingsKeys.self, forKey: .aggregateRatings)
        let tripAdvisorContainer = try ratingsContainer.nestedContainer(keyedBy: TripAdvisorKeys.self, forKey: .tripadvisor)
        let addressContainer = try rootContainer.nestedContainer(keyedBy: AddressKeys.self, forKey: .address)
        
        let street = try addressContainer.decode(String.self, forKey: .street)
        let locality = try addressContainer.decode(String.self, forKey: .locality)
        let country = try addressContainer.decode(String.self, forKey: .country)
        
        self.id = try rootContainer.decode(String.self, forKey: .uuid)
        self.name = try rootContainer.decode(String.self, forKey: .name)
        self.imageUrl = try? mainPhotoContainer?.decode(URL.self, forKey: .source)
        self.rating = try tripAdvisorContainer.decode(Double.self, forKey: .ratingValue)
        self.address = "\(street), \(locality), \(country)"
    }
}
