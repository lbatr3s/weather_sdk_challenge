//
//  NetworkingError.swift
//  Weather SDK
//
//  Created by Lester Batres on 21/10/24.
//

enum NetworkingError: Error {
    
    case apiError(Int, error: Decodable)
    case invalidRequestError(String)
    case invalidResponse
    case noInternetConnection
    case parsingError(Error, String)
    case unauthorized
    case unexpectedError(Error)
}
