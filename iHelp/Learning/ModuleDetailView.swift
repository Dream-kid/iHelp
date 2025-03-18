//
//  ModuleDetailView.swift
//  IHelp
//
//  Created by Md Mehedi Hasan on 4/3/24.
//

import SwiftUI

struct ModuleDetailView: View {
    let module: LearningModule

    var body: some View {
        VStack {
            Text("Module Detail")
                .font(.title)
                .padding()
            
            Text("Title: \(module.title)")
                .font(.headline)
                .padding()
            
            Text("Objective: \(module.description)")
                .font(.subheadline)
                .foregroundColor(.gray)
                .padding()
            
            Spacer()
        }
        .navigationTitle(module.title)
    }
}

//#Preview {
//    ModuleDetailView(module: <#LearningModule#>)
//}
