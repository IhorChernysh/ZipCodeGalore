//
//  TargetEndpoint.swift
//  ZipCodeGalore
//
//  Created by Ihor Chernysh on 11.05.2022.
//

import Foundation
import Alamofire

let baseURL = "http://api.zippopotam.us"

protocol TargetEndpoint {
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: [String: Any]? { get }
    var header: HTTPHeader? { get }
}
