//
//  TabBarView.swift
//  IHelp
//
//  Created by Md Mehedi Hasan on 11/7/23.
//

import SwiftUI

struct TabBarView: View {
    
    @State var selectedTab: Tab = .home
    @State var popToRootTab: Tab = .other
    
    
    var availableTabs: [Tab] = [.home, .health, .engagement, .literacy, .profile]
    
    var body: some View {
        
        
        TabView(selection: .init(get: {
          selectedTab
        }, set: { newTab in
          if newTab == selectedTab {
            /// Stupid hack to trigger onChange binding in tab views.
            popToRootTab = .other
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
              popToRootTab = selectedTab
            }
          }
        
          selectedTab = newTab

        
        })) {
          ForEach(availableTabs) { tab in
            tab.makeContentView(popToRootTab: $popToRootTab)
              .tabItem {
                  tab.label
              }
              .tag(tab)
              //.toolbarBackground(Color.red, for: .tabBar)
              //.badge(badgeFor(tab: tab))
              
          }
        }
        .id("current.id")
        .navigationViewStyle(StackNavigationViewStyle())
        .accentColor(Color("primary"))
        
        
    }
}



#Preview {
    TabBarView()
}



