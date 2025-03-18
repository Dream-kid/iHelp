//
//  EmergencyPages.swift
//  IHelp
//
//  Created by Md Mehedi Hasan on 11/30/23.
//

import Foundation
import SwiftUI

class EmergencyPagerViewModel: ObservableObject {
    @Published var tabIndex = 0
}

enum EmergencyPages: CaseIterable {
    case emergency
    case helpline

    
    @ViewBuilder
    var view: some View {
        switch self {
        case .emergency:
            EmergencySupportView()
        case .helpline:
            HelplineInfoView()
        }
    }
    
    var labelInfo: (text: String, icon: String) {
        switch self {
        case .emergency:
            return (text: "Emergency Support", icon: "light.beacon.max.fill")
        case .helpline:
            return (text: "Helpline Info", icon: "info.circle.fill")
        }
    }
}

