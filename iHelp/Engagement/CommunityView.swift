//
//  CommunityView.swift
//  IHelp
//
//  Created by Md Mehedi Hasan on 11/7/23.
//

import SwiftUI

struct CommunityView: View {
    
    @Binding var popToRootTab: Tab
    
    init(popToRootTab: Binding<Tab>) {
      _popToRootTab = popToRootTab
    }
    
    var body: some View {
        
        Text("CommunityView!")
    }
}

//#Preview {
//    CommunityView()
//}
