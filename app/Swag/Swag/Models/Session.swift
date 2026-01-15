//
//  Auth.swift
//  Swag
//
//  Created by Kazim Ahmad on 14/01/2026.
//

import Foundation

class Session: ObserverObject {
    static let current = Session()

    @Published private(set) var isAuthenticated: Bool = false
    @Published private(set) var guest: Bool = false
    
    override init() {
        super.init()
        
        observe(SwiftServices.shared.$isGuest) { [weak self] isGuest in
            self?.guest = isGuest != nil
        }
    }
}
