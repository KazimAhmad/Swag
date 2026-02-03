//
//  Endpoints+About.swift
//  Swag
//
//  Created by Kazim Ahmad on 03/02/2026.
//

import Foundation

enum AboutEndpoint: Endpoint {
    case about
    
    var path: String {
        return baseURLString + "about"
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var headers: [String : String]? {
        ["Content-Type": "application/json"]
    }
    
    var query: [String: Any]? {
        return nil
    }
    
    var body: HTTPBody? {
        return nil
    }
}
