//
//  WeatherResource.swift
//  Weather SDK
//
//  Created by Lester Batres on 21/10/24.
//

enum WeatherResource: Resource {
    
    case current
    case hourly
    
    var resource: (method: HTTPMethod, route: String) {
        switch self {
        case .current:
            return (.get, "/v2.0/current")
        case .hourly:
            return (.get, "/v2.0/forecast/hourly")
        }
    }
}
