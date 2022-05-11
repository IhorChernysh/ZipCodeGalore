//
//  APIError.swift
//  ZipCodeGalore
//
//  Created by Ihor Chernysh on 11.05.2022.
//

import Foundation

enum APIError: Error {
    case invalidInput
    case badResponse
    case networkIssue
    case invalidToken
    case codableIssue
    
    var descriptionForError: String {
        switch self {
        case .invalidInput:
            return "Input info is invalid"
        case .badResponse:
            return "Bad response"
        case .networkIssue:
            return "Check internet connection, please"
        case .invalidToken:
            return "Invalid token"
        case .codableIssue:
            return "Can't encode or decode data"
        }
    }
    
}
