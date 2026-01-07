//
//  LoginViewModel.swift
//  Swag
//
//  Created by Kazim Ahmad on 07/01/2026.
//

import Foundation
import SwiftUI

protocol LoginViewModelProtocol: ObservableObject {
    func lampColors(for colorScheme: ColorScheme) -> [Color]
}

class LoginViewModel: LoginViewModelProtocol {
    func lampColors(for colorScheme: ColorScheme) -> [Color] {
        if colorScheme == .dark {
            return [.lampLight,
                    .lampLight.opacity(0.8),
                    .lampLight.opacity(0.6),
                    .lampLight.opacity(0.4),
                    .lampLight.opacity(0.2),
                    .lampLight.opacity(0.1),
                    .lampLight.opacity(0.0)]
        }
        return []
    }
}
