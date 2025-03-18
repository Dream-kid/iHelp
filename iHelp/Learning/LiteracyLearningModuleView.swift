//
//  LiteracyLearningModuleView.swift
//  IHelp
//
//  Created by Md Mehedi Hasan on 4/3/24.
//

import SwiftUI

struct LiteracyLearningModuleView: View {
    
    let learningModules: [LearningModule] = LearningModule.getLearningModules()
    
    var body: some View {
//        NavigationView {
            
            List() {
                
                Section {
                    ForEach(learningModules) { module in
                        NavigationLink {
                            switch module.type {
                            case "video":
                                WebView(sourceType: .videoUrl(URL(string: module.link)!))
                                    .ignoresSafeArea()
                                    .navigationTitle("Module Detail")
                                    .navigationBarTitleDisplayMode(.inline)
                                    .frame(minHeight: 0, maxHeight: UIScreen.main.bounds.height * 0.25)
                                    .cornerRadius(6)
                                    .padding(.horizontal, 4)
                            case "pdf":
                                WebView(sourceType: .url(URL(string: module.link)!))
                                    .ignoresSafeArea()
                                    .navigationTitle("Module Detail")
                                    .navigationBarTitleDisplayMode(.inline)
                            case "text":
                                ModuleDetailView(module: module)
                            case "website":
                                WebView(sourceType: .url(URL(string: module.link)!))
                                    .ignoresSafeArea()
                                    .navigationTitle("Module Detail")
                                    .navigationBarTitleDisplayMode(.inline)
                            default:
                                ModuleDetailView(module: module)
                            }
                        } label: {
                            ModuleRow(module: module)
                        }
                    }
                }
            }
//        }
    }
}

#Preview {
    LiteracyLearningModuleView()
}
