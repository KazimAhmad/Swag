//
//  LoginViewModel.swift
//  Swag
//
//  Created by Kazim Ahmad on 07/01/2026.
//

import Foundation
import SwiftUI

@MainActor
protocol LoginViewModelProtocol: ObservableObject {
    var emailOrUsername: String { get set }
    var password: String { get set }
    var isSecured: Bool { get set }
    var eyeImage: String { get }
    func showAnimation()
}

class LoginViewModel: LoginViewModelProtocol {
    @Published var emailOrUsername: String = ""
    @Published var password: String = ""
    @Published var isSecured: Bool = true
    
    private let coordinator: OnboardingCoordiantorProtocol

    init(coordinator: OnboardingCoordiantorProtocol) {
        self.coordinator = coordinator
    }
    
    func showAnimation() {
        coordinator.present(.hideShowAnimationView(isSecured ? .hidden : .shown))
    }
    
    var eyeImage: String {
        isSecured ? "eye.slash" : "eye"
    }
}
