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
            Text("Swag")
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
