//
//  HomeRoute.swift
//  Swag
//
//  Created by Kazim Ahmad on 15/01/2026.
//

import Foundation

enum HomeRoute: Hashable {
    case home
    case thoughtList
}

enum HomeSheet: Identifiable {
    case about
    var id: String {
        switch self {
        case .about:
            return "about"
        }
    }
}

enum HomeFullScreen: Identifiable {
    case alert(AlertConfig)
    case seeMore(SeeMoreConfig)
    var id: String {
        switch self {
        case .alert:
            return "alert"
        case .seeMore:
            return "seeMore"
        }
    }
}
