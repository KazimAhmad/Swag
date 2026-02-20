//
//  AboutViewModel.swift
//  Swag
//
//  Created by Kazim Ahmad on 15/01/2026.
//

import Foundation

@MainActor
class AboutViewModel: ObservableObject {
    @Published var about: About?
    @Published var viewState: ViewState = .loading
    private let coordinator: HomeCoordinator

    init(coordinator: HomeCoordinator) {
        self.coordinator = coordinator
    }
    
    func close() {
        coordinator.dismissSheet()
    }
    
    func fetchAbout() {
        Task {
            do {
                self.about = try await About.fetch()
                self.viewState = .info
            } catch {
                print("Error fetching about: \(error)")
                self.viewState = .error(error)
            }
        }
    }
}
