//
//  Response.swift
//  RestaurantiOS
//
//  Created by Marcelo Fernandez on 06/09/2022.
//

import Foundation

struct Response: Decodable {
    let data: [Restaurant]
}
