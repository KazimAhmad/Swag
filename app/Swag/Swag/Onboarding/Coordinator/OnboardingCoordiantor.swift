//
//  OnboardingCoordiantor.swift
//  Swag
//
//  Created by Kazim Ahmad on 10/01/2026.
//

import Foundation
import SwiftUI

protocol OnboardingCoordiantorProtocol {
    func navigate(to destination: OnboardingRoutes)
    func present(_ modal: OnboardingModal)
    func pop()
    func dismissModal()
}

class OnboardingCoordiantor: ObservableObject, OnboardingCoordiantorProtocol {
    @Published var path = NavigationPath()
    @Published var activeModal: OnboardingModal? = nil

    func navigate(to destination: OnboardingRoutes) {
        path.append(destination)
    }
    
    func pop() {
        path.removeLast()
    }
    
    // MARK: - Modals
    func present(_ modal: OnboardingModal) {
        activeModal = modal
    }
    
    func dismissModal() {
        activeModal = nil
    }
    
    // MARK: - View Builders
    @MainActor @ViewBuilder
    func destinationView(for destination: OnboardingRoutes) -> some View {
        switch destination {
        case .login:
            LoginView(viewModel: LoginViewModel(coordinator: self))
        case .register:
            RegisterView(viewModel: RegisterViewModel())
        }
    }
}

extension OnboardingCoordiantor {
    @ViewBuilder
    func modalView(for modal: OnboardingModal) -> some View {
        switch modal {
        case .hideShowAnimationView(let state):
            HideAndShowView(viewModel: HideAndShowViewModel(state: state,
                                                            coordinator: self))
                .background(
                    ClearBackgroundView()
                )
        }
    }
}
