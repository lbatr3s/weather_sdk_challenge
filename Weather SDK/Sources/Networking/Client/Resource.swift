//
//  Resource.swift
//  Weather SDK
//
//  Created by Lester Batres on 21/10/24.
//

protocol Resource {
    
    var resource: (method: HTTPMethod, route: String) { get }
}
