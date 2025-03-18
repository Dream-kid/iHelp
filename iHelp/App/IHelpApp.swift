//
//  IHelpApp.swift
//  IHelp
//
//  Created by Md Mehedi Hasan on 11/6/23.
//

import SwiftUI

@main
struct IHelpApp: App {
    
    @StateObject private var rootViewManager = RootViewManager()
    
    var body: some Scene {
        WindowGroup {
            Group {
                switch rootViewManager.currentRoot {
                case .authentication:
                    LoginView()
                case .home:
                    TabBarView()
                }
            }
            .environmentObject(rootViewManager)
            .environmentObject(AuthenticationManager.shared)
            .preferredColorScheme(.light)
        }
    }
}
