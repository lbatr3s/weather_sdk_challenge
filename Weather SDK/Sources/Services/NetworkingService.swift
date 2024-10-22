//
//  NetworkingService.swift
//  Weather SDK
//
//  Created by Lester Batres on 21/10/24.
//

import Foundation

final class NetworkingService {
    
    private let host = "https://api.weatherbit.io"
    
    var configuration: ClientConfiguration! {
        return makeConfiguration()
    }
    
    static let sessionId = "b2378f9592f142e4981d0c92b85ac9c8"
    
    
    // MARK: Private methods
    
    private func makeConfiguration() -> ClientConfiguration {
        let configuration = ClientConfiguration(baseURL: host,
                                                httpHeaders: makeHeaders(),
                                                sessionConfiguration: makeSessionConfiguration())
        
        return configuration
    }
    
    private func makeHeaders() -> [String: String] {
        ["Content-Type" : "application/json"]
    }
    
    private func makeSessionConfiguration() -> URLSessionConfiguration {
        let sessionConfiguration = URLSessionConfiguration.default
        
        sessionConfiguration.timeoutIntervalForRequest = 60
        sessionConfiguration.timeoutIntervalForResource = 60
        
        return sessionConfiguration
    }
}
