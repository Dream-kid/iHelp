//
//  SurveyListView.swift
//  IHelp
//
//  Created by Md Mehedi Hasan on 3/20/24.
//

import SwiftUI

struct SurveyListView: View {
    
    @Binding var navigationPath: NavigationPath
    @ObservedObject var viewModel: SurveyViewModel
    
    var body: some View {
        switch viewModel.state {
        case .idle, .loading:
            ProgressView()
                .onAppear {
                    viewModel.needsUpdate = true
                }
        case .success:
            successfulView
        case .failure(let error):
            Text("Failed to load data: \(error.localizedDescription)")
        }
    }
    
    
    var successfulView: some View {
        //NavigationStack {
        ScrollView {
            VStack {
                ForEach(viewModel.surveys) { survey in
                    
                    SurveyCardView(cardData:
                                    SurveyCardView.SurveyCardData(
                                        title: survey.title,
                                        subtitle: survey.subtitle,
                                        actionText: "Tap to start")) {
                                            print("Button tapped")
                                            navigationPath.append(survey)
                                        }
                    
                    
                    /*NavigationLink {
                        WebView(sourceType: .url(URL(string: survey.link)!))
                            .ignoresSafeArea()
                            .navigationTitle("Survey Detail")
                            .navigationBarTitleDisplayMode(.inline)
                    } label: {
                        SurveyCardView(cardData:
                                        SurveyCardView.SurveyCardData(
                                            title: survey.title,
                                            subtitle: survey.subtitle,
                                            actionText: "Tap to start")) {
                                                print("Button tapped")
                                                navigationPath.append(survey)
                                            }
                    }
                    .padding(.top)
                     */
                     
                }
            }
            .padding()
            
        }
        //            }
        .navigationTitle("Available Surveys")
        .navigationBarTitleDisplayMode(.large)
        .navigationDestination(for: IHelpSurvey.self) { value in
            
            if !value.link.isEmpty {
                WebView(sourceType: .url(URL(string: value.link)!))
                    .ignoresSafeArea()
                    .navigationTitle("Survey Detail")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button("Done") {
                                // Action for the Done button
                                print("Done tapped!")
                                navigationPath.removeLast(navigationPath.count)
                            }
                        }
                    }
            } else {
                EmptyView()
            }
            

        }
    }
    
    
}


//#Preview {
//    let path = NavigationPath()
//    SurveyListView(navigationPath: path, viewModel: SurveyViewModel())
//}
