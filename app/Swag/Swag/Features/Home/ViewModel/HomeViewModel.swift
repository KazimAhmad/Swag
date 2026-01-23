//
//  HomeViewModel.swift
//  Swag
//
//  Created by Kazim Ahmad on 15/01/2026.
//

import Foundation

class HomeViewModel: HomeViewModelProtocol {
    private weak var coordinator: HomeCoordinator?

    init(coordinator: HomeCoordinator?) {
        self.coordinator = coordinator
    }

    var info: String {
        return "Pakistani digital content creator who is developing entertaining and educational content for South Asian YouTube audience that extends to other platforms - Instagram, Facebook and Snapchat."
    }
    
    func showAbout() {
        coordinator?.activeModal = .about
    }
    
    func thoughtList() {
        coordinator?.navigate(to: .thoughtList)
    }
}

extension HomeViewModel {
    func seeMore(of thought: Thought) {
        coordinator?.show(.seeMore(SeeMoreConfig(type: .thought,
                                                 title: thought.thought,
                                                 description: thought.more,
                                                 dismiss: { [weak self] in
            self?.coordinator?.dismissFullScreenModal()
        })))
    }
}
