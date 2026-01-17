//
//  SwagApp.swift
//  Swag
//
//  Created by Kazim Ahmad on 13/01/2026.
//

import Foundation
//MARK: the end points for app as enum to play around with the different version numbers and base urls
var version = "" // or some cases a version number as v1, v2 etc
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
//MARK: can define according to the environments
let baseURLString = "http://127.0.0.1:5000/"
