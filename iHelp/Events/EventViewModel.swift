//
//  EventViewModel.swift
//  IHelp
//
//  Created by Md Mehedi Hasan on 3/6/24.
//

import Foundation
import SwiftUI
import Combine

class EventViewModel: ObservableObject {
    
    @Published var state: ViewState = .idle
    @Published var events: [IHelpEvent] = []
    @Published var needsUpdate: Bool = false

    private var cancellables = Set<AnyCancellable>()

    init() {
        $needsUpdate
            .filter { $0 } // Proceed only if `needsUpdate` is true
            .sink { [weak self] _ in
                self?.loadData()
            }
            .store(in: &cancellables)
    }

    func loadData() {
        
        state = .loading
        CommonService.fetchEvents{ [weak self] events, error in
            
            guard let self = self else { return }
            
            if let error = error {
                self.state = .failure(error)
            } else {
                self.events = events
                self.state = .success
                self.needsUpdate = false
            }
        }
        
    }
}
