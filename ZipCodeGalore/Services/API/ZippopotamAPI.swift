//
//  ZippopotamAPI.swift
//  ZipCodeGalore
//
//  Created by Ihor Chernysh on 11.05.2022.
//

import Foundation
import Alamofire

enum ZippopotamAPI {
    case fetchZipInfoByCode(code: String, country: String)
}

extension ZippopotamAPI: TargetEndpoint {
    var path: String {
        switch self {
        case .fetchZipInfoByCode(let code, let country):
            return "/\(country)/\(code)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .fetchZipInfoByCode:
            return .get
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .fetchZipInfoByCode:
            return nil
        }
    }
    
    var header: HTTPHeader? {
         return nil
    }
}
