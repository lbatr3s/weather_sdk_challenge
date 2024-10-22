//
//  ErrorModel.swift
//  Weather SDK
//
//  Created by Lester Batres on 21/10/24.
//

import Foundation

struct ErrorModel: Codable {
    
    let error: String
    
    init(error: String) {
        self.error = error
    }
}
