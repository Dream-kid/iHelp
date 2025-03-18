//
//  LearningModuleView.swift
//  IHelp
//
//  Created by Md Mehedi Hasan on 11/30/23.
//

import SwiftUI

struct LearningModuleView: View {
    
    @Binding var popToRootTab: Tab

    init(popToRootTab: Binding<Tab>) {
      _popToRootTab = popToRootTab
    }
    
    @State private var navigationPath = NavigationPath()
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
    
    let literacyItems = [
        SectionItem(title: "Learning Module", iconName: "graduationcap.fill", eventType: .none),
        SectionItem(title: "Resource", iconName: "books.vertical.fill", eventType: .none),
    ]
    
    
    var body: some View {
        
        NavigationStack(path: $navigationPath) {
            ScrollView {
                VStack {
                                        
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(literacyItems) { item in
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
            .navigationTitle("Literacy")
            .navigationDestination(for: String.self) { pathValue in
                switch pathValue {
                case "Learning Module":
                    LiteracyLearningModuleView()
                        .navigationTitle("Learning Module")
                        .background(Color.blue) // Background color extends under the safe area
                        //.edgesIgnoringSafeArea(.all) // Ignore safe area to extend the background
                        .navigationBarTitleDisplayMode(.large)
                case "Resource":
                    LiteracyResourceView()
                        .navigationTitle("Resource")
                default:
                    EmptyView()
                }
            }
        }
    }
    
    

}

struct LearningModuleView_Previews: PreviewProvider {
    static var previews: some View {
        let binding: Binding<Tab> = .constant(.home)
        return LearningModuleView(popToRootTab: binding)
    }
}

