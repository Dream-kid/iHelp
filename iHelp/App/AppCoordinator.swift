//
//  AppCoordinator.swift
//  IHelp
//
//  Created by Md Mehedi Hasan on 2/12/24.
//

import SwiftUI

final class AppCoordinator: ObservableObject {
    @Published var path: NavigationPath

    init(path: NavigationPath) {
        self.path = path
    }

//    @ViewBuilder
//    func view() -> some View {
//        MainView()
//    }
}

//import Foundation
//import Combine
//
//enum AppRoot {
//    //case splash
//    case authentication
//    case home
//}
//
//final class RootViewManager: ObservableObject {
//    @Published var currentRoot: AppRoot = .authentication
//    
//    private var cancellables = Set<AnyCancellable>()
//    
//    init() {
//        AuthenticationManager.shared.$isAuthenticated
//            .receive(on: DispatchQueue.main)
//            .sink { [weak self] isAuthenticated in
//                self?.currentRoot = isAuthenticated ? .home : .authentication
//            }
//            .store(in: &cancellables)
//    }
//}

