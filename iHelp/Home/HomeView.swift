//
//  HomeView.swift
//  IHelp
//
//  Created by Md Mehedi Hasan on 11/7/23.
//

import SwiftUI

@MainActor
struct HomeView: View {

    @State private var navigationPath = NavigationPath()
    
    
    @State private var selectedItemId: UUID?
    @StateObject var eventViewModel = EventViewModel()
    
    @Binding var popToRootTab: Tab
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
    
    init(popToRootTab: Binding<Tab>) {
        _popToRootTab = popToRootTab
    }
    
    
    let healthItems = [
        SectionItem(title: "Emergency Visit", iconName: "cross.fill", eventType: .none),
        SectionItem(title: "Emergency Support", iconName: "bandage.fill", eventType: .none),
        SectionItem(title: "Service Directory", iconName: "list.bullet", eventType: .serviceDirectory),
        SectionItem(title: "Helpline Info", iconName: "phone.fill", eventType: .helplineInfo)
    ]
    
    let engagementItems = [
        SectionItem(title: "Discussion Forum", iconName: "newspaper.fill", eventType: .none),
        SectionItem(title: "Community Support", iconName: "message.fill", eventType: .learning),
        SectionItem(title: "Events/Activities", iconName: "calendar", eventType: .events)
    ]
    
    let literacyItems = [
        SectionItem(title: "Learning Module", iconName: "graduationcap.fill", eventType: .none),
        SectionItem(title: "Resource", iconName: "books.vertical.fill", eventType: .none),
    ]
    
    private func choose(_ item: SectionItem) {
        if item.eventType != .none {
            print(item.title)
            self.selectedItemId = item.id
        }
    }

    
    var body: some View {
        
        NavigationStack(path: $navigationPath) {
            
            ScrollView {
                VStack {
                    Text("HEALTH".uppercased())
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding(.horizontal, 16)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(Color("secondary"))
                    
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(healthItems) { item in
                            
                            
                            NavigationLink {
                                switch item.eventType {
                                case .events:
                                    EventListView(viewModel: eventViewModel)
                                case .serviceDirectory:
                                    ServiceDirectoryView()
                                        //.ignoresSafeArea()
                                        .navigationTitle("Service Directory")
                                        .navigationBarTitleDisplayMode(.inline)
                                case .helplineInfo:
                                    HelplineInfoView()
                                        .navigationTitle("Helpline Info")
                                default:
                                    EmptyView()
                                }
                            } label: {
                                CustomButton(item: item)
                            }
                        }
                    }
                    
                    Text("ENGAGEMENT")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding(.top, 20)
                        .padding(.horizontal, 16)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(Color("secondary"))
                    
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(engagementItems) { item in
                            CustomButton(item: item)
                                .onTapGesture {
                                    navigationPath.append(item.title)
                                }
                        }
                    }
                    
                    
                    Text("LITERACY")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding(.top, 20)
                        .padding(.horizontal, 16)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(Color("secondary"))
                    
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(literacyItems) { item in
                            CustomButton(item: item)
                                .onTapGesture {
                                    navigationPath.append(item.title)
                                }
                        }
                    }
                    
                    Text("PARTICIPATE IN RESEARCH".uppercased())
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding(.top, 20)
                        .padding(.horizontal, 16)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(Color("secondary"))
                    
                    ActionCardView(cardData:
                                    ActionCardView.ActionCardData(
                                        title: "survey",
                                        subtitle: "Share Your Thoughts! Take one of our quick surveys.",
                                        actionText: "Click Here",
                                        image: Image(systemName: "list.bullet.clipboard.fill"))) {
                                            print("Button tapped")
                                            navigationPath.append("surveys")
                                        }
                    
                }
                .padding()
                
            }
            .navigationDestination(for: String.self) { pathValue in
                switch pathValue {
                case "surveys":
                    let surveyViewModel = SurveyViewModel()
                    SurveyListView(navigationPath: $navigationPath, viewModel: surveyViewModel)
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
                case "Service Directory":
                    ServiceDirectoryView()
                case "Learning Module":
                    LiteracyLearningModuleView()
                        .navigationTitle("Learning Module")
                        .background(Color.blue) // Background color extends under the safe area
                        //.edgesIgnoringSafeArea(.all) // Ignore safe area to extend the background
                        .navigationBarTitleDisplayMode(.large)
                case "Resource":
                    LiteracyResourceView()
                        .navigationTitle("Resource")
                case "Helpline Info":
                    HelplineInfoView()
                        .navigationTitle("Helpline Info")
                default:
                    EmptyView()
                }
            }
            
        }
    }
    
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        let binding: Binding<Tab> = .constant(.home)
        return HomeView(popToRootTab: binding)
    }
}


enum SectionEventType {
    case events, learning // Add more types as needed
    case serviceDirectory
    case helplineInfo
    case none // Use this for items without a detail view
}


struct SectionItem: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let iconName: String
    let eventType: SectionEventType
}


struct CustomButton: View {
    var item: SectionItem
    
    var body: some View {
        VStack {
            Image(systemName: item.iconName)
                .resizable()
                .scaledToFit()
                .frame(width: 28, height: 28)
                .padding(.top, 16)
                .foregroundColor(Color("flag-blue"))
            
            Text(item.title)
                .font(.subheadline)
                .fontWeight(.semibold)
                .lineLimit(2)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.horizontal, 8)
                .padding(.bottom, 8)
                .foregroundColor(Color("primary"))
            
        }
        .frame(width: 100 , height: 100)
        .background(RoundedRectangle(cornerRadius: 15).fill(Color("card-bg")))
    }
}


struct ActionCardView: View {
    
    let cardData: ActionCardData
    var buttonAction: () -> Void
    
    var body: some View {
        ZStack {
            // Your card content goes here. Use VStack or another ZStack depending on your needs.
            VStack {
                
                HStack {
                    VStack(alignment: .leading) {
                        
                        Text(cardData.title.uppercased())
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundColor(Color("secondary"))
                        
                        Text(cardData.subtitle)
                            .font(.subheadline)
                            .lineLimit(3)
                            .fixedSize(horizontal: false, vertical: true)
                                        
                        // Button
                        Button(action: {
                            // Define your action here
                            self.buttonAction()
                        }) {
                            Text(cardData.actionText)
                                .foregroundColor(.white)
                                .padding(8.0)
                                .background(Color("primary"))
                                .cornerRadius(8)
                                .font(.subheadline)
                                .fixedSize(horizontal: false, vertical: true)
                        }.padding(.top, 6)
                    }
                    
                    cardData.image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 28, height: 28)
                        .foregroundColor(Color("flag-blue"))
                        .padding(12.0)
                        .background(Color("card-bg"))
                        .clipShape(Circle())
                }

            }
            .frame(maxWidth: .infinity, minHeight: 100.0) // Adjust height as needed
            .padding(16.0)
            .background(RoundedRectangle(cornerRadius: 15).fill(Color("card-bg")))
        }
        .padding(.horizontal, 10) // Reduces card width slightly for left and right padding
    }
    
    
    struct ActionCardData {
        let title: String
        let subtitle: String
        let actionText: String
        let image: Image
    }
}




