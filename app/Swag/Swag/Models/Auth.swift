//
//  Auth.swift
//  Swag
//
//  Created by Kazim Ahmad on 14/01/2026.
//

import Foundation

struct Auth: Codable {
    static func enterAsGuest() {
        SwiftServices.shared.enterAsGuest()
    }
}
