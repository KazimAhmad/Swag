//
//  SwagApp.swift
//  Swag
//
//  Created by Kazim Ahmad on 29/12/2025.
//

import SwiftUI

@main
struct SwagApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

struct MainView: View {
    @ObservedObject var session: Session = Session.current
    @StateObject var coordinator = OnboardingCoordiantor()

    var body: some View {
        if session.guest {
            AppTabView()
        } else {
            NavigationStack(path: $coordinator.path) {
                OnboardingView(viewModel: OnboardingViewModel(coordinator: coordinator))
                    .navigationDestination(for: OnboardingRoutes.self) { destination in
                        coordinator.destinationView(for: destination)
                    }
                    .fullScreenCover(item: $coordinator.activeModal) { modal in
                        coordinator.modalView(for: modal)
                    }
            }
        }
    }
}
