//
//  SlipBoxProjectApp.swift
//  SlipBoxProject
//
//  Created by Jacek Kosinski U on 22/06/2023.
//

import SwiftUI

@main
struct SlipBoxProjectApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
