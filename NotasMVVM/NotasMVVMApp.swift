//
//  NotasMVVMApp.swift
//  NotasMVVM
//
//  Created by Daniel Moya on 14/12/23.
//

import SwiftUI

@main
struct NotasMVVMApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
