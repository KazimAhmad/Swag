//
//  SettingsViewModel.swift
//  SwagAdmin
//
//  Created by Kazim Ahmad on 29/01/2026.
//

import SwiftUI

enum SettingsSection: String, CaseIterable {
    case thoughts = "Thoughts"
    case movies = "Movies"
    case books = "Books"
    case funfacts = "Fun Facts"
}
class SettingsViewModel: ObservableObject {
    private weak var coordinator: SettingsCoordinator?
    
    var sections: [SettingsSection] = SettingsSection.allCases
    
    @Published var cards: Cards = []
    var repository: CardRepository = CardRepository()
    
    init(coordinator: SettingsCoordinator? = nil) {
        self.coordinator = coordinator
    }
    
    func navigate(to viewOf: SettingsSection) {
        let draftRoute = SettingsRoute.draft(viewOf)
        coordinator?.push(draftRoute)
    }
}
