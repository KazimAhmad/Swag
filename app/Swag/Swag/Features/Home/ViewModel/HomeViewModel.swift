//
//  HomeViewModel.swift
//  Swag
//
//  Created by Kazim Ahmad on 15/01/2026.
//

import Foundation

class HomeViewModel: HomeViewModelProtocol {
    private weak var coordinator: HomeCoordinator?
    private var thoughtRepo: ThoughtRepositoryProtocol

    @Published var thoughtOfTheDay: Thought?
    
    @Published var cards: Cards = []
    @Published var viewState: ViewState = .loading
    
    init(coordinator: HomeCoordinator?,
         thoughtRepo: ThoughtRepositoryProtocol) {
        self.coordinator = coordinator
        self.thoughtRepo = thoughtRepo
    }

    var info: String {
        return "Pakistani digital content creator who is developing entertaining and educational content for South Asian YouTube audience that extends to other platforms - Instagram, Facebook and Snapchat."
    }
    
    func showAbout() {
        coordinator?.present(sheet: .about)
    }
    
    func thoughtList() {
        coordinator?.push(.thoughtList)
    }
    
    @MainActor
    func getThoughtOfDay() {
        Task {
            do {
                thoughtOfTheDay = try await thoughtRepo.oftheday()
            } catch {
                print(error)
            }
        }
    }
    
    @MainActor
    func getCards() {
        if cards.count > 0 { return }
        let repository: CardRepository = CardRepository()
        Task {
            do {
                cards = try await repository.fetch()
                viewState = .info
            } catch {
                print(error)
                viewState = .empty
            }
        }
    }
}

extension HomeViewModel {
    func seeMore(of thought: Thought) {
        let config = SeeMoreConfig(type: .thought,
                                   title: thought.thought,
                                   description: thought.more,
                                   dismiss: { [weak self] in
            self?.coordinator?.dismissFullScreenCover()
        })
        coordinator?.seeMoreView(config: config)
    }
}
