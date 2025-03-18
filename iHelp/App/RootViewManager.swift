//
//  RootViewManager.swift
//  IHelp
//
//  Created by Md Mehedi Hasan on 11/7/23.
//

import Foundation
import Combine

enum AppRoot {
    //case splash
    case authentication
    case home
}

final class RootViewManager: ObservableObject {
    @Published var currentRoot: AppRoot = .authentication
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        AuthenticationManager.shared.$isAuthenticated
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isAuthenticated in
                self?.currentRoot = isAuthenticated ? .home : .authentication
            }
            .store(in: &cancellables)
    }
}


