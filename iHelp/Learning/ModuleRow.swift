//
//  ModuleRow.swift
//  IHelp
//
//  Created by Md Mehedi Hasan on 4/3/24.
//

import SwiftUI

struct ModuleRow: View {
    let module: LearningModule

    var body: some View {
        HStack {
            Image(systemName: iconForModuleType(module.type))
                .font(.largeTitle)
                .foregroundColor(Color("secondary"))
            

            
            VStack(alignment: .leading) {
                Text(module.title)
                    .font(.headline)
                    .foregroundColor(Color("primary"))
                Text(module.description)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
    }

    func iconForModuleType(_ type: String) -> String {
        switch type {
        case "video": return "play.circle.fill"
        case "text": return "doc.text.fill"
        case "pdf": return "book.fill"
        case "website": return "globe"
        default: return "questionmark"
        }
    }
}
