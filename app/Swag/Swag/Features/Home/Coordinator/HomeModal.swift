//
//  HomeModal.swift
//  Swag
//
//  Created by Kazim Ahmad on 15/01/2026.
//

import Foundation

enum HomeModal: Identifiable {
    case about
    var id: String {
        switch self {
        case .about:
            return "about"
        }
    }
}
