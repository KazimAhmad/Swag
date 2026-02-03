//
//  HomeCoordinator.swift
//  Swag
//
//  Created by Kazim Ahmad on 15/01/2026.
//

import Foundation
import SwiftUI

class HomeCoordinator: CoordinatorProtocol {
    typealias Route = HomeRoute
    typealias Sheet = HomeSheet
    typealias FullScreenCover = HomeFullScreen
    
    @Published var path = NavigationPath()
    @Published var sheet: Sheet?
    @Published var fullScreenCover: FullScreenCover?
    
    let thoughtRepo = ThoughtRepository(coreData: ThoughtCoreData(context: PersistenceController.shared.container.viewContext))
    
    var coordinatorView: AnyView {
        AnyView(CoordinatorView(coordinator: self))
    }
    
    var mainView: some View {
        build(page: .home)
    }
    
    func build(page: Route) -> some View {
        switch page {
        case .home:
            HomeView(viewModel: HomeViewModel(coordinator: self,
                                              thoughtRepo: thoughtRepo))
        case .thoughtList:
            ThoughtListView(viewModel: ThoughtListViewModel(coordinator: self,
                                                            thoughtRepo: thoughtRepo))
        }
    }
    
    func build(sheet: Sheet) -> some View {
        switch sheet {
        case .about:
            AboutView(viewModel: AboutViewModel(coordinator: self))
        }
    }
    
    func build(fullScreenCover: FullScreenCover) -> some View {
        switch fullScreenCover {
        case .alert(let config):
            AlertView(config: config)
                .background(ClearBackgroundView())
        case .seeMore(let config):
            SeeMoreView(config: config)
                .background(ClearBackgroundView())
        }
    }
}

extension HomeCoordinator {
    func seeMoreView(config: SeeMoreConfig) {
        present(fullScreenCover: .seeMore(config))
    }
}
