//
//  Places.swift
//  ZipCodeGalore
//
//  Created by Ihor Chernysh on 11.05.2022.
//

import Foundation

struct Places: Decodable {
    enum CodingKeys: String, CodingKey {
        case placeName = "place name"
        case longitude
        case state
        case stateAbbreviation = "state abbreviation"
        case latitude
    }
    
    var placeName: String
    var longitude: String
    var state: String
    var stateAbbreviation: String
    var latitude: String
}
