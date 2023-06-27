//
//  SlipboxProjectApp.swift
//  SlipboxProject
//
//  Created by Karin Prater on 18.11.22.
//

import SwiftUI

@main
struct SlipboxProjectApp: App {
    
    let persistenceController = PersistenceController.shared
    @Environment(\.scenePhase) var scenePhase

    #if os(OSX)
       @NSApplicationDelegateAdaptor(AppDelegate.self) var delegate
    #endif
    
    @AppStorage(wrappedValue: false, AppStorageKeys.showMenubarExtra) var showMenubar: Bool
    
    var body: some Scene {
      
        MainWindow()
        #if os(iOS)
        .onChange(of: scenePhase) { newScenePhase in
            if newScenePhase == .background {
                print("➡️ main app - background")
                persistenceController.save()
            }
        }
        #endif
 
        NoteWindow()

        
        #if os(macOS)
        Settings {
            SettingsView()
        }
        
        MenuBarExtra(isInserted: $showMenubar) {
            MenuBarExtraContentView()
        } label: {
            Label("Slipbox Menu Bar Extra", systemImage: "1.circle")
        }
       // .menuBarExtraStyle(.window)
        #endif
        
    }
}

#if os(OSX)

class AppDelegate: NSObject, NSApplicationDelegate {
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        print("➡️ AppDelegate - applicationDidFinishLaunching")
    }
    
    func applicationWillTerminate(_ notification: Notification) {
        print("➡️ AppDelegate - applicationWillTerminate")
        PersistenceController.shared.save()
    }
    
    func applicationWillResignActive(_ notification: Notification) {
        print("➡️ AppDelegate - applicationWillResignActive")
        PersistenceController.shared.save()
    }
}

#endif
