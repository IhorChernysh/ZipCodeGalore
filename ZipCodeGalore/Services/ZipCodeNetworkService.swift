//
//  ZipCodeNetworkService.swift
//  ZipCodeGalore
//
//  Created by Ihor Chernysh on 11.05.2022.
//

import Foundation
import Alamofire

class ZipCodeNetworkService {
    func fetchInfoByZipCode(code: String, selectedCountry: String, completion: @escaping ((Result<PlaceInfo, Error>) -> ())) {
        if !Reachability.isConnectedToNetwork() {
            completion(.failure(APIError.networkIssue))
            return
        }
        
        let provider = ZippopotamAPI.fetchZipInfoByCode(code: code, country: selectedCountry)
        if let url = URL(string: "\(baseURL)\(provider.path)") {
            AF.request(url,
                       method: provider.method,
                       parameters: provider.parameters,
                       headers: provider.header == nil ? nil : [provider.header!])
                .responseDecodable(of: PlaceInfo.self) { dataResponse in
                    if let value = dataResponse.value {
                        completion(.success(value))
                        return
                    }
                    
                    if let err = dataResponse.error {
                        completion(.failure(err))
                    }
                }
        }
    }
}
