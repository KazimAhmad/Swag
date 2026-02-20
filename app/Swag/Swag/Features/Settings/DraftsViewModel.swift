//
//  DraftsViewModel.swift
//  SwagAdmin
//
//  Created by Kazim Ahmad on 31/01/2026.
//

import Foundation

@MainActor
class DraftsViewModel: ObservableObject {
    var section: SettingsSection
    
    var coordinator: SettingsCoordinator?
    var thoughtRepo: ThoughtRepository?
    
    @Published private(set) var thoughts: [Thought] = []
    
    init(section: SettingsSection,
         coordinator: SettingsCoordinator? = nil,
         thoughtRepo: ThoughtRepository?) {
        self.section = section
        self.coordinator = coordinator
        self.thoughtRepo = thoughtRepo
    }
    
    func getDrafts() {
        switch section {
        case .thoughts:
            guard let thoughtRepo = thoughtRepo else { return }
            thoughtRepo.thoughtsCD()
                .receive(on: DispatchQueue.main)
                .assign(to: &$thoughts)
        case .movies:
            print("todo later")
        case .books:
            print("todo later")
        case .funfacts:
            print("todo later")
        }
    }
}
