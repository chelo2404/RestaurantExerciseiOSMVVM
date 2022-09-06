//
//  LocalStorageService.swift
//  RestaurantiOS
//
//  Created by Marcelo Fernandez on 06/09/2022.
//

import Foundation

struct LocalStorageService {
    static let storage = UserDefaults.standard
    
    static func getArrayValueFor(key: String) -> [String] {
        let storedValue = storage.string(forKey: key)
        return storedValue?.components(separatedBy: ",") ?? []
    }
    
    static func setArrayValue(_ value: [String], for key: String) {
        let storedValue = value.joined(separator: ",")
        storage.set(storedValue, forKey: key)
    }
}
