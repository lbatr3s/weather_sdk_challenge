//
//  ClientConfiguration.swift
//  Weather SDK
//
//  Created by Lester Batres on 21/10/24.
//

import Foundation

typealias HTTPHeaders = [String: String]

struct ClientConfiguration {
    
    let baseURL: String
    let httpHeaders: HTTPHeaders
    let sessionConfiguration: URLSessionConfiguration
    
    public init(baseURL: String,
                httpHeaders: HTTPHeaders,
                sessionConfiguration: URLSessionConfiguration) {
        self.baseURL = baseURL
        self.httpHeaders = httpHeaders
        self.sessionConfiguration = sessionConfiguration
    }
}
