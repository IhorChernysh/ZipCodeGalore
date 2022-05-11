//
//  PlaceInfo.swift
//  ZipCodeGalore
//
//  Created by Ihor Chernysh on 11.05.2022.
//

import Foundation

struct PlaceInfo: Decodable {
    enum CodingKeys: String, CodingKey {
        case postCode = "post code"
        case country
        case countryAbbreviation = "country abbreviation"
        case places
    }
    
    var postCode: String
    var country: String
    var countryAbbreviation: String
    var places: [Places]
}
