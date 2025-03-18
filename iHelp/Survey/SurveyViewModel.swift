//
//  SurveyViewModel.swift
//  IHelp
//
//  Created by Md Mehedi Hasan on 3/20/24.
//

import SwiftUI
import Combine

class SurveyViewModel: ObservableObject {
    
    @Published private(set) var state: ViewState = .idle
    @Published private(set) var surveys: [IHelpSurvey] = []
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
        // Perform your API call and update `items`
        // After loading data, set `needsUpdate` back to false if necessary
        
        state = .loading
        CommonService.fetchSurveys(){ [weak self] surveys, error in
            
            guard let self = self else { return }
            
            
            if let error = error {
                self.state = .failure(error)
            } else {
                if let user = AuthenticationManager.shared.currentUser {
                    self.surveys = surveys.filter { $0.participatorRole == user.roleID }
                } else {
                    self.surveys = surveys
                }
                
                self.state = .success
                self.needsUpdate = false
            }
        }
    }
    
}



