//
//  OnboardingViewModel.swift
//  Swag
//
//  Created by Kazim Ahmad on 10/01/2026.
//

import Foundation

@MainActor
class OnboardingViewModel: ObservableObject {
    private weak var coordinator: OnboardingCoordiantor?

    init(coordinator: OnboardingCoordiantor?) {
        self.coordinator = coordinator
    }
    
    func goToLogin() {
        coordinator?.navigate(to: .login)
    }

    func goToRegister() {
        coordinator?.navigate(to: .register)
    }
}
