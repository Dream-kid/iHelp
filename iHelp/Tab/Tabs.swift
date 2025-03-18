//
//  Tabs.swift
//  IHelp
//
//  Created by Md Mehedi Hasan on 11/7/23.
//

import SwiftUI

@MainActor
enum Tab: Int, Identifiable, Hashable {
    case home, health, engagement, literacy, profile
    case other
    
    nonisolated var id: Int {
        rawValue
    }
    
    //  static func loggedOutTab() -> [Tab] {
    //    [.timeline, .settings]
    //  }
    
    static func loggedInTabs() -> [Tab] {
        return [.home, .health, .engagement, .literacy, .profile]
    }
    
    
    @ViewBuilder
    func makeContentView(popToRootTab: Binding<Tab>) -> some View {
        switch self {
        case .home:
            HomeView(popToRootTab: popToRootTab)
        case .health:
            EmergencyView(popToRootTab: popToRootTab)
        case .engagement:
            EngagementView(popToRootTab: popToRootTab)
        case .literacy:
            LearningModuleView(popToRootTab: popToRootTab)
        case .profile:
            ProfileView(popToRootTab: popToRootTab)
        case .other:
            EmptyView()
        }
    }
    
    @ViewBuilder
    var label: some View {
        switch self {
        case .home:
            Label("tab.home", systemImage: iconName)
        case .health:
            Label("tab.health", systemImage: iconName)
        case .engagement:
            Label("tab.engagement", systemImage: iconName)
        case .literacy:
            Label("tab.literacy", systemImage: iconName)
        case .profile:
            Label("tab.profile", systemImage: iconName)
        case .other:
            EmptyView()
        }
    }
    
    var iconName: String {
        switch self {
        case .home:
            "house"
        case .health:
            "light.beacon.max"
        case .engagement:
            "person.3.fill"
        case .literacy:
            "graduationcap"
        case .profile:
            "person.crop.circle"
        case .other:
          ""
        }
    }
    
}
