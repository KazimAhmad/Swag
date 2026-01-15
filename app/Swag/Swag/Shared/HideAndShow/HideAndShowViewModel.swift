//
//  HideAndShowViewModel.swift
//  Swag
//
//  Created by Kazim Ahmad on 10/01/2026.
//

import Foundation

class HideAndShowViewModel: ObservableObject {
    var state: HideAndShowState
    @Published var showDetail = false

    private let coordinator: OnboardingCoordiantorProtocol

    init(state: HideAndShowState,
         coordinator: OnboardingCoordiantorProtocol) {
        self.state = state
        self.coordinator = coordinator
    }
    
    func dismiss() {
        coordinator.dismissModal()
    }
}
