//
//  OnboardingViewModel.swift
//  Swag
//
//  Created by Kazim Ahmad on 10/01/2026.
//

import Foundation
enum OnboardingInfoType: String, CaseIterable {
    case videos
    case movies
    case facts
    case more
    
    var image: String {
        switch self {
        case .videos:
            return Images.video
        case .movies:
            return Images.movie
        case .facts:
            return Images.facts
        case .more:
            return Images.more
        }
    }
}

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
    
    func enterAsGuest() {
        Auth.enterAsGuest()
    }
}
