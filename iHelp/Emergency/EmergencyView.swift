//
//  EmergencyView.swift
//  IHelp
//
//  Created by Md Mehedi Hasan on 11/7/23.
//

import SwiftUI

struct EmergencyView: View {
    
    @Binding var popToRootTab: Tab
    @StateObject var vm = EmergencyPagerViewModel()
    @State var selection = 1
    
    init(popToRootTab: Binding<Tab>) {
        _popToRootTab = popToRootTab
    }
    
    
    @MainActor var body: some View {
        PagerTabStripView(selection: $vm.tabIndex) {
            
            ForEach(EmergencyPages.allCases, id: \.self) { page in
                page.view
                    .pagerTabItem(tag: page.hashValue) {
                        CustomNavBarItem(title: page.labelInfo.text, imageName: page.labelInfo.icon, selection: $selection, tag: page.hashValue)
                    }
                    .onAppear {
                        
                        //                        homeModel.isLoading = true
                        //                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        //                            homeModel.isLoading = false
                        //                        }
                    }
            }
        }
        .pagerTabStripViewStyle(.barButton(tabItemHeight: 68, padding: EdgeInsets(), indicatorViewHeight: 3,
                                           indicatorView: {
            Rectangle().fill(Color("primary")).cornerRadius(5)
        }))
    }
}


struct EmergencyView_Previews: PreviewProvider {
    static var previews: some View {
        let binding: Binding<Tab> = .constant(.home)
        return EmergencyView(popToRootTab: binding)
    }
}

private struct CustomNavBarItem<SelectionType>: View where SelectionType: Hashable {
    
    @EnvironmentObject private var pagerSettings: PagerSettings<SelectionType>
    
    let unselectedColor = Color(.systemGray)
    let selectedColor = Color.black
    
    let title: String
    let image: Image
    @Binding var selection: SelectionType
    let tag: SelectionType
    
    init(title: String, imageName: String, selection: Binding<SelectionType>, tag: SelectionType) {
        self.tag = tag
        self.title = title
        self.image = Image(systemName: imageName)
        _selection = selection
    }
    
    @MainActor var body: some View {
        VStack {
            image
                .renderingMode(.template)
                .resizable()
                .frame(width: 22, height: 22)
                .foregroundColor(unselectedColor.interpolateTo(color: selectedColor,
                                                               fraction: pagerSettings.transition.progress(for: tag)))
            Text(title.uppercased())
                .foregroundColor(unselectedColor.interpolateTo(color: selectedColor,
                                                               fraction: pagerSettings.transition.progress(for: tag)))
                .fontWeight(.semibold)
                .font(.system(size: 13))
        }
        .animation(.default, value: selection)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
