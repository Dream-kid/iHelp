//
//  EngagementView.swift
//  IHelp
//
//  Created by Md Mehedi Hasan on 4/3/24.
//

import SwiftUI

struct EngagementView: View {
    
    @Binding var popToRootTab: Tab
    
    init(popToRootTab: Binding<Tab>) {
      _popToRootTab = popToRootTab
    }
    
    @State private var navigationPath = NavigationPath()
    @StateObject var eventViewModel = EventViewModel()
    
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
    
    let engagementItems = [
        SectionItem(title: "Discussion Forum", iconName: "newspaper.fill", eventType: .none),
        SectionItem(title: "Community Support", iconName: "message.fill", eventType: .learning),
        SectionItem(title: "Events/Activities", iconName: "calendar", eventType: .events)
    ]
    
    
    var body: some View {
        
        NavigationStack(path: $navigationPath) {
            ScrollView {
                VStack {
                    
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(engagementItems) { item in
                            //NavigationLink(room.name, value: item)
                            
                            CustomButton(item: item)
                                .onTapGesture {
                                    navigationPath.append(item.title)
                                }
                        }
                    }
                    
                    
                }
                .padding()
                
            }
            .navigationTitle("Engagement")
            .navigationDestination(for: String.self) { pathValue in
                switch pathValue {
                case "Discussion Forum":
                    WebView(sourceType: .url(URL(string: "https://alzconnected.org/")!))
                        .ignoresSafeArea()
                        .navigationTitle("Discussion Forum")
                        .navigationBarTitleDisplayMode(.inline)
                    
                case "Community Support":
                    WebView(sourceType: .url(URL(string: "https://bpc.caregiver.org/caregivers/search")!))
                        .ignoresSafeArea()
                        .navigationTitle("Community Support")
                        .navigationBarTitleDisplayMode(.inline)
                    
                case "Events/Activities":
                    EventListView(viewModel: eventViewModel)
                default:
                    EmptyView()
                }
            }
        }
    }
}

#Preview {
    EngagementView(popToRootTab: .constant(.home))
}


