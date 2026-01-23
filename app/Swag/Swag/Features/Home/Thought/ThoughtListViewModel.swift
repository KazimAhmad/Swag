//
//  ThoughtListViewModel.swift
//  Swag
//
//  Created by Kazim Ahmad on 23/01/2026.
//

import Foundation

@MainActor
class ThoughtListViewModel: ObservableObject {
    private weak var coordinator: HomeCoordinator?
    @Published var thoughts: [Thought] = []
    @Published var viewState: ViewState = .loading
    
    var total: Int = 0
    var page: Int = 0
    
    init(coordinator: HomeCoordinator?) {
        self.coordinator = coordinator
    }
    
    func hasMoreThoughts() -> Bool {
        return total > thoughts.count
    }
        
    func getThoughts() {
        page += 1
        Task {
            do {
                let thought = try await ThoughtObject.fetch(for: page)
                self.thoughts.append(contentsOf: thought.items)
                self.total = thought.total
                self.viewState = .info
            }
            catch {
                self.viewState = .error(error)
            }
        }
    }
    
    func refresh() {
        viewState = .loading
        page = 0
        thoughts.removeAll()
        getThoughts()
    }
    
    func seeMore(of thought: Thought) {
        coordinator?.show(.seeMore(SeeMoreConfig(type: .thought,
                                                 title: thought.thought,
                                                 description: thought.more,
                                                 dismiss: { [weak self] in
            self?.coordinator?.dismissFullScreenModal()
        })))
    }
}
